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
    case ready(source: ContactListLoadingSource)
    case error(source: ContactListLoadingSource, message: String)
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
    
    func loadCache() {
        
        let cachedContacts = ContactCache.shared.load()
        
        if cachedContacts.isEmpty {
            return
        }
        
        contactModels = cachedContacts
        contactItems = cachedContacts.compactMap { ContactListItem(contactModel: $0) }
        state = .ready(source: .initial)
    }
    
    func loadContacts(_ loadingSource: ContactListLoadingSource) {
        
        // Avoid multiple fetches
        if case .loading = state {
            Logger.log("Tried to fetch contacts while already loading.", level: .debug)
            return
        }
        
        // Avoid offline fetching
        guard ReachabilityHelper.shared.hasInternetAccess
        else {
            state = .error(
                source: loadingSource,
                message: Constants.Texts.Errors.noInternetConnection
            )
            return
        }
        
        state = .loading(source: loadingSource)
        
        contactService.fetchContacts()
        .sink { [weak self] completion in
            
            guard let self else { return }
            
            if case .failure(let error) = completion {
                self.state = .error(
                    source: loadingSource,
                    message: error.localizedDescription
                )
            }
        }
        receiveValue: { [weak self] receivedContacts in
            
            guard let self else { return }
            
            // Load items from cache if needed
            let contacts = receivedContacts.isEmpty ? ContactCache.shared.load() : receivedContacts
            let contactItems = contacts.compactMap { ContactListItem(contactModel: $0) }
            
            // Update stored data
            switch loadingSource {
                    
                case .initial, .refresh:
                    self.contactModels = contacts
                    self.contactItems = contactItems
                    
                case .infiniteScroll:
                    self.contactModels.append(contentsOf: contacts)
                    self.contactItems.append(contentsOf: contactItems)
            }
            
            // Update cache data
            ContactCache.shared.save(self.contactModels)
            
            // Update state
            self.state = contacts.isEmpty ? .empty : .ready(source: loadingSource)
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
