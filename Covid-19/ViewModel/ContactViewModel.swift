//
//  ContactViewModel.swift
//  Covid-19
//
//  Created by Gaurish Salunke on 4/15/20.
//  Copyright © 2020 Gaurish Salunke. All rights reserved.
//

import SwiftUI
import Combine

class ContactViewModel: ObservableObject {
    var didChange = PassthroughSubject<ContactViewModel, Never>()

    @Published var contact: Contact? {
        didSet {
            self.didChange.send(self)
        }
    }
    
    init() {
    }

    
    func getAllContacts() {
//        let urlString = "https://api.rootnet.in/covid19-in/contacts"
//        WebService().getRequest(from: urlString) { (result: Result<ContactResponse, NetworkError>) in
//            switch result {
//            case .success(let response):
//                self.contact = response.data.contacts
//
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
    }
}
