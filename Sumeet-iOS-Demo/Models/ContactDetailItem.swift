//
//  ContactDetailItem.swift
//  Sumeet-iOS-Demo
//
//  Created by Salah Eddine KAHACK on 06/04/2025.
//

import UIKit
import CoreLocation


struct ContactDetailItem: Identifiable {
    
    // MARK: - Enums
    
    enum Row {
        case singleInformation(
            label: String,
            value: String
        )
        case doubleInformation(
            firstLabel: String, firstValue: String,
            secondLabel: String, secondValue: String
        )
        case mapCoordinates(
            coordinates: CLLocationCoordinate2D,
            zoomLevel: Views.Map.ZoomLevel
        )
    }
    
    // MARK: - Properties
    
    let id: UUID
    let firstName: String
    let lastName: String
    let fullName: String
    let placeholderPicture: UIImage
    let pictureURL: URL
    let birthday: String
    let age: String
    let address: String
    let email: String
    let phone: String
    let coordinates: CLLocationCoordinate2D
    let countryFlag: String
    
    // MARK: - Lifecycle
    
    init?(contactModel: ContactModel) {
        
        guard let imageURL = URL(string: contactModel.picture.large),
              let latitude = Double(contactModel.location.coordinates.latitude),
              let longitude = Double(contactModel.location.coordinates.longitude)
        else {
            Logger.log("failed to instantiate ContactDetailItem !", level: .debug)
            return nil
        }
        
        id = contactModel.id
        firstName = contactModel.name.first
        lastName = contactModel.name.last.uppercased()
        fullName = ContactFormatterHelper.getFullName(name: contactModel.name)
        placeholderPicture = ContactFormatterHelper.getGender(contactModel).avatar
        pictureURL = imageURL
        birthday = DateFormatterHelper.birthday(date: contactModel.dateOfBirth.date)
        age = "\(contactModel.dateOfBirth.age)"
        address = AddressFormatterHelper.getFullAddress(location: contactModel.location)
        email = contactModel.email
        phone = contactModel.cell
        coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        countryFlag = AddressFormatterHelper.getCountryFlag(contactModel)
    }
}
