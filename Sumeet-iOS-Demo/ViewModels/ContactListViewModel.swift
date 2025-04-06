//
//  ContactListViewModel.swift
//  Sumeet-iOS-Demo
//
//  Created by Salah Eddine KAHACK on 06/04/2025.
//

import Combine


class ContactListViewModel {
    
    typealias ContactSelectedCallback = (ContactModel) -> Void
    
    // MARK: - Private properties
    
    private var cancellables = Set<AnyCancellable>()
    private let contactService: ContactServiceProtocol
    private var contactModels: [ContactModel] = []
    
    // MARK: - Published properties
    
    @Published var contacts: [ContactListItem] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    // MARK: - Internal properties
    
    var contactSelectedCallback: ContactSelectedCallback?
    
    // MARK: - Lifecycle
    
    init(contactService: ContactServiceProtocol) {
        self.contactService = contactService
    }
    
    // MARK: - Methods
    
    func loadContacts() {
        // TODO
    }
    
    // MARK: - Actions
    
    func handleContactSelection(selectedContactItem: ContactListItem) {
        
        if let index = contacts.firstIndex(where: { $0.id == selectedContactItem.id }) {
            
            let selectedContactModel = contactModels[index]
            contactSelectedCallback?(selectedContactModel)
        }
    }
}
