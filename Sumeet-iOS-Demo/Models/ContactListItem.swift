//
//  ContactListItem.swift
//  Sumeet-iOS-Demo
//
//  Created by Salah Eddine KAHACK on 06/04/2025.
//

import Foundation
import UIKit


struct ContactListItem: Identifiable {
    
    // MARK: Properties
    
    let id: UUID
    let fullname: String
    let email: String
    let phone: String
    let thumbnailURL: URL
    let placeholderThumbnail: UIImage
    
    // MARK: - Lifecycle
    
    init?(contactModel: ContactModel) {
        
        guard let imageURL = URL(string: contactModel.picture.medium)
        else {
            Logger.log("failed to instantiate ContactListItem, missing imageURL !", level: .debug)
            return nil
        }
        
        id = contactModel.id
        fullname = ContactFormatterHelper.getFullName(name: contactModel.name)
        email = contactModel.email
        phone = contactModel.cell
        thumbnailURL = imageURL
        placeholderThumbnail = ContactFormatterHelper.getGender(contactModel).avatar
    }
}
