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
        static let secondary = UIColor(named: "secondaryAccentColor")!
        static let background = UIColor(named: "background")!
        static let contentBackground = UIColor(named: "contentBackground")!
        static let borderColor = UIColor(named: "border")!
        static let buttonTitle = UIColor(named: "buttonTitle")!
        static let criticalText = UIColor(named: "criticalText")!
        static let criticalBackground = UIColor(named: "criticalBackground")!
    }

    // MARK: - Sizes
    
    struct Sizes {
        
        static let tinySpacing: CGFloat = 4.0
        static let smallSpacing: CGFloat = tinySpacing * 2.0
        static let regularSpacing: CGFloat = smallSpacing * 2.0
        static let mediumSpacing: CGFloat = regularSpacing + tinySpacing
        static let largeSpacing: CGFloat = regularSpacing * 2.0
        static let cornerRadius: CGFloat = 10.0
        static let largeCornerRadius: CGFloat = cornerRadius + regularSpacing
        static let shadowRadius: CGFloat = 6.0
        static let defaultFontSize: CGFloat = 16.0
        static let mapViewHeight: CGFloat = 128.0
        
        static let buttonEdgeInsets: UIEdgeInsets = .init(
            top: smallSpacing + tinySpacing,
            left: smallSpacing + smallSpacing,
            bottom: smallSpacing + tinySpacing,
            right: smallSpacing + smallSpacing
        )
        
        struct ContactList {
            static let thumbnailSize: CGFloat = 64.0
            static let thumbnailCornerRadius: CGFloat = thumbnailSize / 2.0
        }
        
        struct ContactDetail {
            static let avatarSize: CGFloat = 112.0
            static let avatarCornerRadius: CGFloat = avatarSize / 2.0
        }
    }
    
    // MARK: - Icons
    
    struct Icons {
        static let phone = UIImage(systemName: "phone")!
        static let email = UIImage(systemName: "envelope")!
        static let text = UIImage(systemName: "bubble")!
        static let noContacts = UIImage(systemName: "person.2.slash")!
    }
    
    // MARK: - Texts
    
    struct Texts {
        
        private static let context: String = "general"
        static let emailNotConfiguredTitle: String = NSLocalizedString("Email not configured", comment: context)
        static let emailNotConfiguredMessage: String = NSLocalizedString("It seems you haven't set up your email account. Would you like to set it up now?", comment: context)
        static let settingsAppName: String = NSLocalizedString("Settings", comment: context)
        static let cancelButtonTitle: String = NSLocalizedString("Cancel", comment: context)
        
        struct ContactList {
            private static let context: String = "contact-list"
            static let title: String = NSLocalizedString("Contacts", comment: context)
            static let emptyMessage: String = NSLocalizedString("No contacts found", comment: context)
            static let noInternetMessage: String = NSLocalizedString("No internet connection, please try again later", comment: context)
            static let loadContactsButtonTitle: String = NSLocalizedString("Load contacts", comment: context)
        }
        
        struct ContactDetail {
            private static let context: String = "contact-detail"
            static let textButton: String = NSLocalizedString("Text", comment: context)
            static let callButton: String = NSLocalizedString("Call", comment: context)
            static let emailButton: String = NSLocalizedString("Email", comment: context)
            static let firstNameLabel: String = NSLocalizedString("First name:", comment: context)
            static let lastNameLabel: String = NSLocalizedString("Last name:", comment: context)
            static let phoneLabel: String = NSLocalizedString("Phone number:", comment: context)
            static let emailLabel: String = NSLocalizedString("Email:", comment: context)
            static let birthdayLabel: String = NSLocalizedString("Birthday:", comment: context)
            static let ageLabel: String = NSLocalizedString("Age:", comment: context)
            static let addressLabel: String = NSLocalizedString("Address:", comment: context)
        }
    }
    
    // MARK: - URLs
    
    struct URLs {
        static let mockFileURL: URL? = Bundle.main.url(forResource: "mock_data", withExtension: "json")
        static let apiURL: URL? = URL(string: "https://randomuser.me/api/?results=10")
    }
    
    // MARK: - Cell Identifiers
    
    struct CellIdentifiers {
        static let contactListCellIdentifier: String = "ContactListCell"
        static let contactDetailCellIdentifier: String = "ContactDetailCell"
    }
}
