//
//  ContactFormatterHelper.swift
//  Sumeet-iOS-Demo
//
//  Created by Salah Eddine KAHACK on 06/04/2025.
//

import UIKit


enum ContactGender {
    
    case male
    case female
    case unknown
    
    var avatar: UIImage {
        switch self {
            case .male: return UIImage(named: "avatar_male")!
            case .female: return UIImage(named: "avatar_female")!
            default: return UIImage(named: "avatar_unknown")!
        }
    }
}


struct ContactFormatterHelper {
    
    static func getFullName(name: ContactModel.Name) -> String {
        
        let nameParts = [name.first, name.last.uppercased()]
            .compactMap { $0.trimmingCharacters(in: .whitespacesAndNewlines ) }
            .filter { !$0.isEmpty }

        let joinedName = nameParts.joined(separator: " ")
        let fullName = joinedName.isEmpty ? Constants.Texts.Testing.unknownFullName : joinedName
        
        return fullName
    }
    
    static func getGender(_ contact: ContactModel) -> ContactGender {
        
        switch contact.gender {
            case "male": return .male
            case "female": return .female
            default: return .unknown
        }
    }
}
