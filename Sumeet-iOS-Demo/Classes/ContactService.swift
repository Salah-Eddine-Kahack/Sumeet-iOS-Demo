//
//  ContactService.swift
//  Sumeet-iOS-Demo
//
//  Created by Salah Eddine KAHACK on 06/04/2025.
//

import Foundation
import Combine


// MARK: - Protocol

protocol ContactServiceProtocol {
    func fetchContacts() -> AnyPublisher<[ContactModel], Error>
}

// MARK: - Error types

enum ContactServiceError: LocalizedError {
    
    case failedToLoadMockData
    case noInternet
    
    var errorDescription: String? {
        switch self {
            case .failedToLoadMockData: return Constants.Texts.Errors.mockDataLoadingFailed
            case .noInternet: return Constants.Texts.Errors.noInternetConnection
        }
    }
}

// MARK: - Factory

struct ServiceFactory {
    
    static func makeContactService(environment: AppEnvironment) -> ContactServiceProtocol {
        
        switch environment {
            case .mock: MockContactService()
            case .real: ContactService()
        }
    }
}

// MARK: - Mock Service

class MockContactService: ContactServiceProtocol {
    
    func fetchContacts() -> AnyPublisher<[ContactModel], Error> {
        
        guard let url = Constants.URLs.mockFileURL,
              let data = try? Data(contentsOf: url)
        else {
            Logger.log("Cannot load mock file", level: .error)
            
            return Fail(error: ContactServiceError.failedToLoadMockData)
                .eraseToAnyPublisher()
        }

        do {
            let response = try JSONDecoder().decode(ContactAPIResponse.self, from: data)
            
            return Just(response.results)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        catch {
            Logger.log("Error decoding mock file: \(error)", level: .error)
            
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }
}

// MARK: - Real Service

class ContactService: ContactServiceProtocol {
    
    func fetchContacts() -> AnyPublisher<[ContactModel], Error> {
        
        guard let url = Constants.URLs.apiURL else {
            Logger.log("Invalid API URL", level: .error)
            
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }
        
        if !ReachabilityHelper.shared.hasInternetAccess {
            return Fail(error: ContactServiceError.noInternet)
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap {
                guard let response = $0.response as? HTTPURLResponse,
                      (200..<300).contains(response.statusCode)
                else {
                    Logger.log("Bad server response", level: .error)
                    throw URLError(.badServerResponse)
                }
                return $0.data
            }
            .decode(type: ContactAPIResponse.self, decoder: JSONDecoder())
            .map { $0.results }
            .catch { error -> AnyPublisher<[ContactModel], Error> in
                
                Logger.log("Failed to fetch contacts: \(error)", level: .error)
                
                return Fail(error: error)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
