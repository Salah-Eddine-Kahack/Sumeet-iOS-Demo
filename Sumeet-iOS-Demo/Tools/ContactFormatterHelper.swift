//
//  ContactFormatterHelper.swift
//  Sumeet-iOS-Demo
//
//  Created by Salah Eddine KAHACK on 06/04/2025.
//

import UIKit


struct ContactFormatterHelper {
    
    static func getFullName(name: ContactModel.Name) -> String {
        
        let nameParts = [name.first, name.last]
            .compactMap { $0.trimmingCharacters(in: .whitespaces ) }
            .filter { !$0.isEmpty }

        let joinedName = nameParts.joined(separator: " ")
        let fullName = joinedName.isEmpty ? "Unknown Humanoïde" : joinedName
        
        return fullName
    }
    
    static func getGenderIcon(gender: String) -> UIImage {
        
        switch gender {
            case "male": return Constants.Icons.male
            case "female": return Constants.Icons.female
            default: return Constants.Icons.person
        }
    }
}
