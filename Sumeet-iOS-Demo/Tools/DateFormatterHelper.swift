//
//  DateFormatterHelper.swift
//  Sumeet-iOS-Demo
//
//  Created by Salah Eddine KAHACK on 06/04/2025.
//

import Foundation

struct DateFormatterHelper {
    
    static func date(iso8601String: String) -> Date? {
        
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        let date = formatter.date(from: iso8601String)
        
        return date
    }
    
    static func simpleDateString(date: Date) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let simpleDateString = formatter.string(from: date)
        
        return simpleDateString
    }
    
    static func birthday(date: Date) -> String {
        
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("d MMMM")
        let birthday = formatter.string(from: date)
        
        return birthday
    }
}
