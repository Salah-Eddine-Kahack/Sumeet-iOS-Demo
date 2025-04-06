//
//  ContactService.swift
//  Sumeet-iOS-Demo
//
//  Created by Salah Eddine KAHACK on 06/04/2025.
//

import Foundation
import Combine


protocol ContactServiceProtocol {
    func fetchContacts() -> AnyPublisher<[ContactModel], Error>
}


struct ServiceFactory {
    
    static func makeContactService(environment: AppEnvironment) -> ContactServiceProtocol {
        
        switch environment {
            case .mock: MockContactService()
            case .real: ContactService()
        }
    }
}


class MockContactService: ContactServiceProtocol {
    
    func fetchContacts() -> AnyPublisher<[ContactModel], Error> {
        
        guard let url = Constants.URLs.mockFileURL,
              let data = try? Data(contentsOf: url)
        else {
            return Fail(
                error: NSError(
                    domain: "MockDataError",
                    code: -1,
                    userInfo: [NSLocalizedDescriptionKey: "Mock file not found"]
                )
            )
            .eraseToAnyPublisher()
        }

        do {
            let response = try JSONDecoder().decode(ContactAPIResponse.self, from: data)
            return Just(response.results)
                   .setFailureType(to: Error.self)
                   .eraseToAnyPublisher()
        }
        catch {
            return Fail(error: error)
                   .eraseToAnyPublisher()
        }
    }
}


class ContactService: ContactServiceProtocol {
    
    func fetchContacts() -> AnyPublisher<[ContactModel], Error> {
        
        Just([]) // TODO: Implement
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }
}
