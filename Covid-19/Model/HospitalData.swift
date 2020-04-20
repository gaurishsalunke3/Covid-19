//
//  HospitalData.swift
//  Covid-19
//
//  Created by Gaurish Salunke on 4/15/20.
//  Copyright © 2020 Gaurish Salunke. All rights reserved.
//

import SwiftUI

struct HospitalResponse: Decodable {
    let success: Bool
    let data: PanIndiaHospitalData
}

struct PanIndiaHospitalData: Decodable {
    let nationalSummary: IndiaHospitalSummary
    let states: [StateHospital]
    
    private enum CodingKeys: String, CodingKey {
        case nationalSummary = "summary"
        case states = "regional"
    }
}

struct IndiaHospitalSummary: Decodable {
    let ruralHospitals: Int
    let ruralBeds: Int
    let urbanHospitals: Int
    let urbanBeds: Int
    let totalHospitals: Int
    let totalBeds: Int
}

struct StateHospital: Decodable, Hashable {
    let stateName: String
    let ruralHospitals: Int
    let ruralBeds: Int
    let urbanHospitals: Int
    let urbanBeds: Int
    let totalHospitals: Int
    let totalBeds: Int
    let updatedDate: String
    
    private enum CodingKeys: String, CodingKey {
        case stateName = "state"
        case ruralHospitals, ruralBeds, urbanHospitals, urbanBeds, totalHospitals, totalBeds
        case updatedDate = "asOn"
    }
}
