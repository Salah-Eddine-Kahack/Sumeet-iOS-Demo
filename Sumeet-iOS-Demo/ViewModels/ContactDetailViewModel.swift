//
//  ContactDetailViewModel.swift
//  Sumeet-iOS-Demo
//
//  Created by Salah Eddine KAHACK on 06/04/2025.
//

import UIKit


class ContactDetailViewModel {
    
    // MARK: - Private properties
    
    private var contact: ContactDetailItem
    
    // MARK: - Getters
    
    var title: String {
        contact.fullName
    }
    
    var avatarURL: URL {
        contact.pictureURL
    }
    
    var detailItemRows: [ContactDetailItem.Row] {[
        .doubleInformation(
            firstLabel: Constants.Texts.ContactDetail.firstNameLabel,
            firstValue: contact.firstName,
            secondLabel: Constants.Texts.ContactDetail.lastNameLabel,
            secondValue: contact.lastName
        ),
        .singleInformation(
            label: Constants.Texts.ContactDetail.phoneLabel,
            value: contact.phone
        ),
        .singleInformation(
            label: Constants.Texts.ContactDetail.emailLabel,
            value: contact.email
        ),
        .doubleInformation(
            firstLabel: Constants.Texts.ContactDetail.birthdayLabel,
            firstValue: contact.birthday,
            secondLabel: Constants.Texts.ContactDetail.ageLabel,
            secondValue: contact.age
        ),
        .singleInformation(
            label: Constants.Texts.ContactDetail.addressLabel,
            value: contact.address
        ),
        .mapCoordinates(coordinates: contact.coordinates)
    ]}
    
    
    // MARK: - Lifecycle
    
    init?(contact: ContactModel) {
        
        guard let contact = ContactDetailItem(contactModel: contact)
        else {
            return nil
        }
        
        self.contact = contact
    }
    
    // MARK: - Actions
    
    func handleCallContact() {

        guard let url = URL(string: "tel://\(contact.phone)")
        else {
            Logger.log("Invalid phone number URL.", level: .error)
            return
        }

        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        else {
            Logger.log("Cannot open phone URL.", level: .error)
        }
    }

    func handleTextContact() {

        guard let url = URL(string: "sms:\(contact.phone)")
        else {
            Logger.log("Invalid phone number URL.", level: .error)
            return
        }

        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        else {
            Logger.log("Cannot open SMS URL.", level: .error)
        }
    }

    func handleEmailContact(viewController: UIViewController) {

        guard let url = URL(string: "mailto:\(contact.email)")
        else {
            Logger.log("Invalid email URL.", level: .error)
            return
        }

        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        else {
            Logger.log("Cannot open email URL. Displaying alert to user.", level: .debug)

            // Display an alert to the user
            let alert = UIAlertController(
                title: Constants.Texts.emailNotConfiguredTitle,
                message: Constants.Texts.emailNotConfiguredMessage,
                preferredStyle: .alert
            )

            let settingsAction = UIAlertAction(title: Constants.Texts.settingsAppName, style: .default) { _ in
                
                if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
                }
            }

            let cancelAction = UIAlertAction(
                title: Constants.Texts.cancelButtonTitle,
                style: .cancel,
                handler: nil
            )

            alert.addAction(settingsAction)
            alert.addAction(cancelAction)

            viewController.present(alert, animated: true, completion: nil)
        }
    }
}
