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
    let country: String
    let thumbnailURL: String
    
    // MARK: - Lifecycle
    
    init(contactModel: ContactModel) {
        id = contactModel.id
        fullname = ContactFormatterHelper.getFullName(name: contactModel.name)
        email = contactModel.email
        phone = contactModel.cell
        country = contactModel.location.country
        thumbnailURL = contactModel.picture.medium // Thumbnail is too small
    }
}
