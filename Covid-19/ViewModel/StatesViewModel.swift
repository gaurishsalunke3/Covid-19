//
//  StatesViewModel.swift
//  Covid-19
//
//  Created by Gaurish Salunke on 4/15/20.
//  Copyright © 2020 Gaurish Salunke. All rights reserved.
//

import SwiftUI
import Combine

class StatesViewModel: ObservableObject {
    var didChange = PassthroughSubject<StatesViewModel, Never>()
    
    @Published var countries: [Details]? {
        didSet {
            self.didChange.send(self)
        }
    }

    @Published var states: [Regional]? {
        didSet {
            self.didChange.send(self)
        }
    }
    
    private var stateContacts: [StateContact]?
    private var stateHospitals: [StateHospital]?
    
    init() {
        
    }
    
    func loadCountryData() {
        self.getAllCountriesData()
    }
    
    private func getAllCountriesData() {
        let urlString = "https://corona.lmao.ninja/v2/countries"
        
        WebService().getRequest(from: urlString) { (result: Result<[Details], NetworkError>) in
            switch result {
            case .success(let data):
                let unsortedList = data
                self.countries = unsortedList.sorted {
                    $0.cases > $1.cases
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func loadStateData() {
        
        let dispatchGroup = DispatchGroup()
        
        self.getAllStatesCases(dispatchGroup)
        
        self.getAllSatesContacts(dispatchGroup)
        
        self.getAllStatesHospitals(dispatchGroup)
        
        dispatchGroup.notify(queue: .main) {
            // whatever you want to do when both are done
            var index = 0
            for indiaCase in self.states ?? [] {
                if let contacts = self.stateContacts {
                    let matchedContact = contacts.filter({ $0.stateName == indiaCase.stateName })
                    if matchedContact.count > 0 {
                        self.states?[index].contact = matchedContact[0]
                    }
                }
                
                if let hospitals = self.stateHospitals {
                    let matchedHospital = hospitals.filter({ $0.stateName == indiaCase.stateName })
                    if matchedHospital.count > 0 {
                        self.states?[index].hospital = matchedHospital[0]
                    }
                }
                
                index += 1
            }
        }
    }
    
    private func getAllStatesCases(_ dispatchGroup: DispatchGroup) {
        let urlString = "https://api.rootnet.in/covid19-in/stats/latest"
        
        WebService().getRequest(from: urlString, dispatchGroup: dispatchGroup) { (result: Result<DataResponse, NetworkError>) in
            switch result {
            case .success(let response):
                self.states = response.data.states
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func getAllSatesContacts(_ dispatchGroup: DispatchGroup) {
        let urlString = "https://api.rootnet.in/covid19-in/contacts"
        
        WebService().getRequest(from: urlString, dispatchGroup: dispatchGroup) { (result: Result<ContactResponse, NetworkError>) in
            switch result {
            case .success(let response):
                self.stateContacts = response.data.contacts.states
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func getAllStatesHospitals(_ dispatchGroup: DispatchGroup) {
        let urlString = "https://api.rootnet.in/covid19-in/stats/hospitals"
        
        WebService().getRequest(from: urlString, dispatchGroup: dispatchGroup) { (result: Result<HospitalResponse, NetworkError>) in
            switch result {
            case .success(let response):
                self.stateHospitals = response.data.states
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
