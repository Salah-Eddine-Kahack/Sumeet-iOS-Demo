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
        
        isLoading = true
        
        contactService.fetchContacts()
        .sink { [weak self] completion in
            
            guard let self else { return }
            
            switch completion {
                case .failure(let error): self.errorMessage = error.localizedDescription
                case .finished: break
            }
            
            self.isLoading = false
        }
        receiveValue: { [weak self] contacts in
            
            guard let self else { return }
            
            self.contactModels = contacts
            self.contacts = contacts.compactMap { ContactListItem(contactModel: $0) }
        }
        .store(in: &cancellables)
    }
    
    // MARK: - Actions
    
    func handleContactSelection(selectedContactItem: ContactListItem) {
        
        if let index = contacts.firstIndex(where: { $0.id == selectedContactItem.id }) {
            
            let selectedContactModel = contactModels[index]
            contactSelectedCallback?(selectedContactModel)
        }
    }
}
