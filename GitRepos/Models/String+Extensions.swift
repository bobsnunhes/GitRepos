//
//  String+Extensions.swift
//  GitRepos
//
//  Created by roberto fernandes filho on 21/12/2018.
//  Copyright © 2018 Betocorporation. All rights reserved.
//

import Foundation

extension String {
    func parseToUserFormatTimeZone() -> String? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        if let date = formatter.date(from: self) {
            let userFormatter = DateFormatter()
            userFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss' hrs'"
            return userFormatter.string(from: date)
        } else {
            return nil
        }
    }
    
    func parseToDate() -> Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        if let date = formatter.date(from: self) {
            return date
        } else {
            return nil
        }
    }
}
