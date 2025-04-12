//
//  ContactListViewModel.swift
//  Sumeet-iOS-Demo
//
//  Created by Salah Eddine KAHACK on 06/04/2025.
//

import Combine


enum ContactListState {
    case empty
    case loading(source: ContactListLoadingSource)
    case ready
    case error(String)
}


enum ContactListLoadingSource {
    case initial
    case refresh
    case infiniteScroll
}


class ContactListViewModel {
    
    typealias ContactSelectedCallback = (ContactModel) -> Void
    
    // MARK: - Private properties
    
    private var cancellables = Set<AnyCancellable>()
    private let contactService: ContactServiceProtocol
    private var contactModels: [ContactModel] = []
    
    // MARK: - Published properties
    
    @Published var contactItems: [ContactListItem] = []
    @Published var state: ContactListState = .empty
    
    // MARK: - Internal properties
    
    var contactSelectedCallback: ContactSelectedCallback?
    
    // MARK: - Lifecycle
    
    init(contactService: ContactServiceProtocol) {
        self.contactService = contactService
    }
    
    // MARK: - Methods
    
    func loadContacts(_ loadingSource: ContactListLoadingSource) {
        
        state = .loading(source: loadingSource)
        
        contactService.fetchContacts()
        .sink { [weak self] completion in
            
            guard let self else { return }
            
            if case .failure(let error) = completion {
                self.state = .error(error.localizedDescription)
            }
        }
        receiveValue: { [weak self] contacts in
            
            guard let self else { return }
            
            // TODO: Handle infinite scroll & cache management
            self.contactModels = contacts
            self.contactItems = contacts.compactMap { ContactListItem(contactModel: $0) }
            self.state = contacts.isEmpty ? .empty : .ready
        }
        .store(in: &cancellables)
    }
    
    // MARK: - Actions
    
    func handleContactSelection(selectedContactItem: ContactListItem) {
        
        if let index = contactItems.firstIndex(where: { $0.id == selectedContactItem.id }) {
            
            let selectedContactModel = contactModels[index]
            contactSelectedCallback?(selectedContactModel)
        }
    }
}
