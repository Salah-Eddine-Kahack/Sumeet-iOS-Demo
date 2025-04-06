//
//  ContactDetailItem.swift
//  Sumeet-iOS-Demo
//
//  Created by Salah Eddine KAHACK on 06/04/2025.
//

import UIKit


struct ContactDetailItem: Identifiable {
    
    // MARK: Properties
    
    let id: UUID
    let firstName: String
    let lastName: String
    let genderIcon: UIImage
    let address: String
    let email: String
    let phone: String
    let pictureURL: String
    let birthday: String
    
    // MARK: - Lifecycle
    
    init(contactModel: ContactModel) {
        id = contactModel.id
        firstName = contactModel.name.first
        lastName = contactModel.name.last
        genderIcon = ContactFormatterHelper.getGenderIcon(gender: contactModel.gender)
        address = AddressFormatterHelper.getFullAddress(location: contactModel.location)
        email = contactModel.email
        phone = contactModel.cell
        pictureURL = contactModel.picture.large
        birthday = DateFormatterHelper.birthday(date: contactModel.dateOfBirth.date)
    }
}
