//
//  AddressFormatterHelper.swift
//  Sumeet-iOS-Demo
//
//  Created by Salah Eddine KAHACK on 06/04/2025.
//

import Foundation


struct AddressFormatterHelper {
    
    static func getFullAddress(location: ContactModel.Location) -> String {
        
        // Check street
        let streetComponents = [
            "\(location.street.number)",
            location.street.name
        ]
        .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
        .filter { !$0.isEmpty }
        
        let street = streetComponents.joined(separator: " ")
        
        // Check adress
        let addressComponents = [
            street,
            location.city,
            location.country
        ]
        .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
        .filter { !$0.isEmpty }

        // Format address
        let joinedAdress = addressComponents.joined(separator: ", ")
        let fullAdress = joinedAdress.isEmpty ? "Unknown Galaxy" : joinedAdress
        
        return fullAdress
    }
}
