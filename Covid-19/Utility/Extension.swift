//
//  Extension.swift
//  Covid-19
//
//  Created by Gaurish Salunke on 4/15/20.
//  Copyright © 2020 Gaurish Salunke. All rights reserved.
//

import Foundation

extension Numeric {
    func getValue() -> String {
        let format = NumberFormatter()
        format.numberStyle = .decimal
        format.locale = Locale.current
        
        return format.string(for: self)!
    }
}

extension String {
    internal func getFlag() -> String {
        return self
            .unicodeScalars
            .map({ 127397 + $0.value })
            .compactMap(UnicodeScalar.init)
            .map(String.init)
            .joined()
    }
}
