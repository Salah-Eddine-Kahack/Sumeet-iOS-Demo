//
//  Constants.swift
//  Sumeet-iOS-Demo
//
//  Created by Salah Eddine KAHACK on 06/04/2025.
//

import UIKit


struct Constants {
    
    // MARK: - Colors
    
    struct Colors {
        static let primary = UIColor(named: "AccentColor")!
        static let secondary = primary.withAlphaComponent(0.7)
        static let background = UIColor(named: "background")!
        static let button = UIColor(named: "buttonTitle")!
    }

    // MARK: - Sizes
    
    struct Sizes {
        
        static let insets: CGFloat = 20.0
        static let tinySpacing: CGFloat = 4.0
        static let smallSpacing: CGFloat = tinySpacing * 2
        static let spacing: CGFloat = smallSpacing * 2
        static let largeSpacing: CGFloat = spacing * 2
        static let cornerRadius: CGFloat = 10.0
        static let defaultFontSize: CGFloat = 16.0
        
        static let buttonEdgeInsets: UIEdgeInsets = .init(
            top: smallSpacing + tinySpacing,
            left: smallSpacing + smallSpacing,
            bottom: smallSpacing + tinySpacing,
            right: smallSpacing + smallSpacing
        )
    }
    
    // MARK: - Icons
    
    struct Icons {
        static let phone = UIImage(systemName: "phone")!
        static let email = UIImage(systemName: "envelope")!
        static let text = UIImage(systemName: "bubble")!
        static let male = UIImage(systemName: "figure.stand")!
        static let female = UIImage(systemName: "figure.stand.dress")!
        static let person = UIImage(systemName: "person")!
        static let noContacts = UIImage(systemName: "person.2.slash")!
    }
    
    // MARK: - Texts
    
    struct Texts {
        
        struct ContactList {
            private static let context: String = "contact-list"
            static let title: String = NSLocalizedString("Contacts", comment: context)
            static let emptyMessage: String = NSLocalizedString("No contacts found", comment: context)
            static let loadContactsButtonTitle: String = NSLocalizedString("Load contacts", comment: context)
        }
        
        struct ContactDetail {
            private static let context: String = "contact-detail"
            static let textButtonTitle: String = NSLocalizedString("Text", comment: context)
            static let callButtonTitle: String = NSLocalizedString("Call", comment: context)
            static let emailButtonTitle: String = NSLocalizedString("Email", comment: context)
        }
    }
    
    // MARK: - URLs
    
    struct URLs {
        static let mockFileURL: URL? = Bundle.main.url(forResource: "mock_data", withExtension: "json")
        static let apiURL: URL? = URL(string: "https://randomuser.me/api/?results=10")
    }
}
