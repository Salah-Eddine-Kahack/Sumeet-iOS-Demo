//
//  ContactListItem.swift
//  Sumeet-iOS-Demo
//
//  Created by Salah Eddine KAHACK on 06/04/2025.
//

import Foundation


struct ContactListItem: Identifiable {
    
    // MARK: Properties
    
    let id: UUID
    let fullname: String
    let email: String
    let phone: String
    let thumbnailURL: URL
    
    // MARK: - Lifecycle
    
    init?(contactModel: ContactModel) {
        
        guard let imageURL = URL(string: contactModel.picture.medium)
        else {
            Logger.log("failed to instantiate ContactListItem, missing imageURL !")
            return nil
        }
        
        id = contactModel.id
        fullname = ContactFormatterHelper.getFullName(name: contactModel.name)
        email = contactModel.email
        phone = contactModel.cell
        thumbnailURL = imageURL
    }
}
