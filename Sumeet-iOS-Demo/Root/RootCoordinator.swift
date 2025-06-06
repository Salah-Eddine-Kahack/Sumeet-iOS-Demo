//
//  RootCoordinator.swift
//  Sumeet-iOS-Demo
//
//  Created by Salah Eddine KAHACK on 06/04/2025.
//

import UIKit


enum AppEnvironment {
    case mock
    case real
}


class RootCoordinator {
    
    // MARK: - Properties
    
    private let navigationController: UINavigationController
    private let contactService: ContactServiceProtocol
    private let appEnvironment: AppEnvironment = .real
    
    // MARK: - Life cycle

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.contactService = ServiceFactory.makeContactService(environment: appEnvironment)
    }
    
    // MARK: - Methods

    func start() {
        
        let contactListViewModel = ContactListViewModel(contactService: contactService)
        
        contactListViewModel.contactSelectedCallback = { [weak self] contact in
            guard let self else { return }
            self.showContactDetail(contact: contact)
        }
        
        let contactListViewController = ContactListViewController(viewModel: contactListViewModel)
        navigationController.pushViewController(contactListViewController, animated: false)
    }
        
    func showContactDetail(contact: ContactModel) {
        
        guard let contactDetailViewModel = ContactDetailViewModel(contact: contact) else { return }
        
        let contactDetailViewController = ContactDetailViewController(viewModel: contactDetailViewModel)
        navigationController.pushViewController(contactDetailViewController, animated: true)
    }
}

