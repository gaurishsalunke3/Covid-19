//
//  HomeViewModel.swift
//  Covid-19
//
//  Created by Gaurish Salunke on 4/15/20.
//  Copyright © 2020 Gaurish Salunke. All rights reserved.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    var didChange = PassthroughSubject<HomeViewModel, Never>()
    
    @Published var globalData: Global? {
        didSet {
            self.didChange.send(self)
        }
    }
    
    @Published var countries: [Details] = [] {
        didSet {
            self.didChange.send(self)
        }
    }
    
    @Published var indiaContact: NationalContact? {
        didSet {
            self.didChange.send(self)
        }
    }
    
    init() {
    }
    
    func loadSummaryData() {
        
        let dispatchGroup = DispatchGroup()
        
        self.getUpdatedData(dispatchGroup)
        
        self.getAllCountriesData(dispatchGroup)
        
        dispatchGroup.notify(queue: .main) {
            // whatever you want to do when both are done
            //            self.globalData?.indiaData = self.indiaData
        }
    }
    
    func getUpdatedData(_ dispatchGroup: DispatchGroup) {
        let urlString = "https://corona.lmao.ninja/v2/all"
        
        WebService().getRequest(from: urlString, dispatchGroup: dispatchGroup) { (result: Result<Global, NetworkError>) in
            switch result {
            case .success(let data):
                self.globalData = data
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getSampleData(showProgress: Binding<Bool>) {
        //        self.countries = Details.getAllCountriesSamples()
    }
    
    func getAllCountriesData(_ dispatchGroup: DispatchGroup) {
        let urlString = "https://corona.lmao.ninja/v2/countries"
        
        WebService().getRequest(from: urlString, dispatchGroup: dispatchGroup) { (result: Result<[Details], NetworkError>) in
            switch result {
            case .success(let response):
                let unsortedList = response
                let sortedList = unsortedList.sorted {
                    $0.cases > $1.cases
                }
                self.globalData?.indiaData = self.fetchIndiaData(sortedList: sortedList)
                
                self.countries = sortedList.takeElements(elementCount: 10)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchIndiaData(sortedList: [Details]) -> Details? {
        return sortedList.filter{ $0.country == "India" }.first
    }
    
    // Fetch India Contact details
    
    func getIndiaContactData() {
        let urlString = "https://api.rootnet.in/covid19-in/contacts"
        
        WebService().getRequest(from: urlString) { (result: Result<ContactResponse, NetworkError>) in
            switch result {
            case .success(let response):
                self.indiaContact = response.data.contacts.nationalContact
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension Array {
    func takeElements(elementCount: Int) -> Array {
        if (elementCount > count) {
            return Array(self[0..<count])
        }
        return Array(self[0..<elementCount])
    }
}
