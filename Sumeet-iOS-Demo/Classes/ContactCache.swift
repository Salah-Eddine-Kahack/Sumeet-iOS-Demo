//
//  ContactCache.swift
//  Sumeet-iOS-Demo
//
//  Created by Salah Eddine KAHACK on 06/04/2025.
//

import Foundation


final class ContactCache {
    
    // MARK: - Constants
    
    struct Keys {
        static let contacts = "contacts"
    }
    
    // MARK: - Singletons
    
    private let defaults = UserDefaults.standard
    static let shared = ContactCache()
    
    // MARK: - APIs
    
    func save(_ contacts: [ContactModel]) {
        
        Logger.log("Saving contacts into cache: \(contacts)", level: .debug)
        
        do {
            let data = try JSONEncoder().encode(contacts)
            defaults.set(data, forKey: Keys.contacts)
        }
        catch {
            Logger.log("Failed to encode contacts: \(error)", level: .error)
        }
    }
    
    func load() -> [ContactModel] {
        
        guard let data = defaults.data(forKey: Keys.contacts) else {
            Logger.log("No contacts found in cache", level: .debug)
            return []
        }
                
        do {
            let contacts = try JSONDecoder().decode([ContactModel].self, from: data)
            Logger.log("Loaded contacts from cache: \(contacts)", level: .debug)
            return contacts
        }
        catch {
            Logger.log("Failed to decode contacts: \(error)", level: .error)
            return []
        }
    }
    
    func clear() {
        Logger.log("Clearing contacts from cache", level: .debug)
        defaults.removeObject(forKey: Keys.contacts)
    }
}
