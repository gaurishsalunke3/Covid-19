//
//  GlobalData.swift
//  Covid-19
//
//  Created by Gaurish Salunke on 4/15/20.
//  Copyright © 2020 Gaurish Salunke. All rights reserved.
//

import Foundation

struct Global: Decodable {
    var cases: Double
    var deaths: Double
    var updated: Double
    var recovered: Double
    var active: Double
    
    var indiaData: Details?
}

struct CountryListResponse: Decodable, Hashable {
    var data: [Details]
}

struct Details: Decodable, Hashable {
    var countryName: String
    var countryInfo: CountryInfo
    var cases: Double
    var todayCases: Double
    var deaths: Double
    var todayDeaths: Double
    var recovered: Double
    var active: Double
    var critical: Double
    var tests: Double
    var casesPerOneMillion: Double?
    var deathsPerOneMillion: Double?
    var testsPerOneMillion: Double?
    
    private enum CodingKeys: String, CodingKey {
        case countryName = "country"
        
        case countryInfo, cases, todayCases, deaths, todayDeaths, recovered, active, critical, tests, casesPerOneMillion, deathsPerOneMillion, testsPerOneMillion
    }
}

struct CountryInfo: Decodable, Hashable {
    let countryCode: String?
    
    private enum CodingKeys: String, CodingKey {
        case countryCode = "iso2"
    }
}

extension Details {
    static func getAllCountriesSamples() -> [Details] {
        return [
            Details(countryName: "USA", countryInfo: CountryInfo(countryCode: "US"), cases: 142735, todayCases: 275, deaths: 2489, todayDeaths: 5, recovered: 4562, active: 135684, critical: 2970, tests: 3861596, casesPerOneMillion: 431, deathsPerOneMillion: 8, testsPerOneMillion: 11666),
            Details(countryName: "Italy", countryInfo: CountryInfo(countryCode: "IT"), cases: 97689, todayCases: 0, deaths: 10779, todayDeaths: 0, recovered: 13030, active: 73880, critical: 3906, tests: 0, casesPerOneMillion: 1616, deathsPerOneMillion: 178, testsPerOneMillion: 0),
            Details(countryName: "China", countryInfo: CountryInfo(countryCode: "CN"), cases: 81470, todayCases: 31, deaths: 3304, todayDeaths: 4, recovered: 75700, active: 2466, critical: 633, tests: 3861596, casesPerOneMillion: 57, deathsPerOneMillion: 2, testsPerOneMillion: 11666),
            Details(countryName: "Spain", countryInfo: CountryInfo(countryCode: "ES"), cases: 80110, todayCases: 0, deaths: 6803, todayDeaths: 0, recovered: 14709, active: 58598, critical: 4165, tests: 930230, casesPerOneMillion: 1713, deathsPerOneMillion: 146, testsPerOneMillion: 19896),
            Details(countryName: "Germany", countryInfo: CountryInfo(countryCode: "DE"), cases: 62435, todayCases: 0, deaths: 541, todayDeaths: 0, recovered: 9211, active: 52683, critical: 1979, tests: 1728357, casesPerOneMillion: 745, deathsPerOneMillion: 6, testsPerOneMillion: 20629)
        ]
    }
}
