//
//  Notification.swift
//  Covid-19
//
//  Created by Gaurish Salunke on 4/15/20.
//  Copyright © 2020 Gaurish Salunke. All rights reserved.
//

import Foundation

struct NotificationResponse: Decodable {
    let sucess: Bool
    let data: [Notification]
}

struct Notification: Decodable, Hashable {
    let title: String
    let link: String
}

extension Notification {
    static func getSampleData() -> [Notification] {
        return [
            Notification(title: "District Reportings", link: "https://www.mohfw.gov.in/pdf/DistrictWiseList324.pdf"),
            Notification(title: "PIB", link: ""),
            Notification(title: "20.03.2020 Instructions to all major and minor ports for dealing with(COVID-19)", link: ""),
            Notification(title: "19.03.2020 Additional Travel Advisory", link: ""),
            Notification(title: "18.03.2020 Standard Operating Procedure for Passenger Movement post Disembarkation", link: ""),
            Notification(title: "17.03.2020 Additional Travel Advisory", link: "")
        ]
    }
}
