//
//  Contact.swift
//  Covid-19
//
//  Created by Gaurish Salunke on 4/15/20.
//  Copyright © 2020 Gaurish Salunke. All rights reserved.
//

import SwiftUI

struct ContactResponse: Decodable {
    let success: Bool
    let data: Contacts
}

struct Contacts: Decodable {
    let contacts: Contact
}

struct Contact: Decodable {
    let nationalContact: NationalContact
    let states: [StateContact]
    
    private enum CodingKeys: String, CodingKey {
        case nationalContact = "primary"
        case states = "regional"
    }
}

struct NationalContact: Decodable {
    let contactNumber: String
    let tollFree: String
    let email: String
    let twitter: String
    let facebook: String
    
    private enum CodingKeys: String, CodingKey {
        case contactNumber = "number"
        case tollFree = "number-tollfree"
        case email, twitter, facebook
    }
}

struct StateContact: Decodable, Hashable {
    let stateName: String
    let contactNumber: String
    
    private enum CodingKeys: String, CodingKey {
        case stateName = "loc"
        case contactNumber = "number"
    }
}

extension StateContact {
    static func getSampleData() -> [StateContact] {
        return [
            StateContact(stateName: "Andhra Pradesh", contactNumber: "+91-866-2410978"),
            StateContact(stateName: "Arunachal Pradesh", contactNumber: "+91-9436055743"),
            StateContact(stateName: "Karnataka", contactNumber: "104"),
            StateContact(stateName: "Maharashtra", contactNumber: "+91-20-26127394")
        ]
    }
}
