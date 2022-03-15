//
//  SettingsViewModel.swift
//  Newsify
//
//  Created by Daksh K on 15/03/22.
//

import Foundation
enum Country: String, CaseIterable {
    case us = "us"
    case canada = "ca"
}

extension Country {
    
    var displayName: String {
        get {
            switch(self) {
                case .us:
                    return "US"
                case .canada:
                    return "Canada"
            }
        }
    }
    
    var displayShortName: String {
        get {
            switch(self) {
                case .us:
                    return "US"
                case .canada:
                    return "CA"
            }
        }
    }
    
}

class SettingsViewModel {
    
    let countries = Country.allCases
    
    var selectedCountry: Country {
        get {
            let userDefaults = UserDefaults.standard
            var countryValue = ""
            if let value = userDefaults.value(forKey: "countryCode") as? String {
                countryValue = value
            }
            return Country(rawValue: countryValue)!
        }
        set {
            let userDefault = UserDefaults.standard
            userDefault.set(newValue.rawValue, forKey: "countryCode")
        }
    }
    
}
