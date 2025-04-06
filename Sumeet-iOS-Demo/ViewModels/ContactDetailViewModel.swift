//
//  ContactDetailViewModel.swift
//  Sumeet-iOS-Demo
//
//  Created by Salah Eddine KAHACK on 06/04/2025.
//

import Foundation


class ContactDetailViewModel {
    
    // MARK: - Private properties
    
    private let contactService: ContactServiceProtocol // TODO: Remove if not needed
    
    // MARK: - Published properties
    
    @Published var contact: ContactDetailItem
    
    // MARK: - Lifecycle
    
    init(contact: ContactModel, contactService: ContactServiceProtocol) {
        self.contact = ContactDetailItem(contactModel: contact)
        self.contactService = contactService
    }
    
    // MARK: - Actions
    
    func handleCallContact() {
        // TODO
    }
    
    func handleTextContact() {
        // TODO
    }
    
    func handleEmailContact() {
        // TODO
    }
}
