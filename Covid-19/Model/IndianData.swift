//
//  IndianData.swift
//  Covid-19
//
//  Created by Gaurish Salunke on 4/15/20.
//  Copyright © 2020 Gaurish Salunke. All rights reserved.
//

import Foundation

struct DataResponse: Decodable {
    let success: Bool
    let data: PanIndiaCount
}

struct PanIndiaCount: Decodable {
    var nationalSummary: IndiaSummary
    var states: [Regional]
    
    private enum CodingKeys: String, CodingKey {
        case nationalSummary = "summary"
        case states = "regional"
    }
}

struct IndiaSummary: Decodable {
    let total: Int
    let confirmedCasesIndian: Int
    let confirmedCasesForeign: Int
    let discharged: Int
    let deaths: Int
    var contact: NationalContact?
    var hospital: IndiaHospitalSummary?
    
    var activeCases: Int {
        return total - (deaths + discharged)
    }
}

struct Regional: Decodable, Hashable {
    let stateName: String
    let confirmedCasesIndian: Int
    let discharged: Int
    let deaths: Int
    let confirmedCasesForeign: Int
    var contact: StateContact?
    var hospital: StateHospital?
    
    var confirmedTotalCases: Int {
        return confirmedCasesIndian + confirmedCasesForeign
    }
    
    var activeCases: Int {
        return (confirmedCasesIndian + confirmedCasesForeign) - (deaths + discharged)
    }
    
    private enum CodingKeys: String, CodingKey {
        case stateName = "loc"
        
        case confirmedCasesIndian, discharged, deaths, confirmedCasesForeign, contact, hospital
    }
}

extension Regional {
    static func getSampleData() -> [Regional] {
        return [
            Regional(stateName: "Maharashtra", confirmedCasesIndian: 487, discharged: 42, deaths: 24, confirmedCasesForeign: 3, contact: StateContact(stateName: "Maharashtra", contactNumber: "+91-20-26127394"), hospital: StateHospital(stateName: "Maharashtra", ruralHospitals: 273, ruralBeds: 12398, urbanHospitals: 438, urbanBeds: 39048, totalHospitals: 711, totalBeds: 51446, updatedDate: "2015-12-31T00:00:00.000Z")),
            Regional(stateName: "Maharashtra", confirmedCasesIndian: 487, discharged: 42, deaths: 24, confirmedCasesForeign: 3, contact: StateContact(stateName: "Maharashtra", contactNumber: "+91-20-26127394"), hospital: StateHospital(stateName: "Maharashtra", ruralHospitals: 273, ruralBeds: 12398, urbanHospitals: 438, urbanBeds: 39048, totalHospitals: 711, totalBeds: 51446, updatedDate: "2015-12-31T00:00:00.000Z")),
            Regional(stateName: "Maharashtra", confirmedCasesIndian: 487, discharged: 42, deaths: 24, confirmedCasesForeign: 3, contact: StateContact(stateName: "Maharashtra", contactNumber: "+91-20-26127394"), hospital: StateHospital(stateName: "Maharashtra", ruralHospitals: 273, ruralBeds: 12398, urbanHospitals: 438, urbanBeds: 39048, totalHospitals: 711, totalBeds: 51446, updatedDate: "2015-12-31T00:00:00.000Z")),
            Regional(stateName: "Maharashtra", confirmedCasesIndian: 487, discharged: 42, deaths: 24, confirmedCasesForeign: 3, contact: StateContact(stateName: "Maharashtra", contactNumber: "+91-20-26127394"), hospital: StateHospital(stateName: "Maharashtra", ruralHospitals: 273, ruralBeds: 12398, urbanHospitals: 438, urbanBeds: 39048, totalHospitals: 711, totalBeds: 51446, updatedDate: "2015-12-31T00:00:00.000Z"))
        ]
    }
}
