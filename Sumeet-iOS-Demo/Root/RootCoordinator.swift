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
    
    private let navigationController: UINavigationController
    private let contactService: ContactServiceProtocol
    private let appEnvironment: AppEnvironment = .mock

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.contactService = ServiceFactory.makeContactService(environment: appEnvironment)
    }

    func start() {
        // TODO
    }
}

