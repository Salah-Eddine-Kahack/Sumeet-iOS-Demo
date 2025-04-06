//
//  ContactModel.swift
//  Sumeet-iOS-Demo
//
//  Created by Salah Eddine KAHACK on 06/04/2025.
//

import Foundation


struct ContactAPIResponse: Decodable {
    let results: [ContactModel]
}


struct ContactModel: Decodable, Identifiable {
    
    // MARK: - Structs
    
    struct Name: Decodable {
        let first: String
        let last: String
    }

    struct Location: Decodable {
        
        struct Street: Decodable {
            let number: Int
            let name: String
        }
        
        let street: Street
        let city: String
        let country: String
        let coordinates: Coordinates
    }

    struct Coordinates: Decodable {
        let latitude: String
        let longitude: String
    }

    struct Picture: Decodable {
        let large: String
        let medium: String
        let thumbnail: String
    }
    
    struct DateOfBirth: Decodable {
        
        let date: Date
        let age: Int
        
        private enum CodingKeys: String, CodingKey {
            case date, age
        }
        
        init(from decoder: Decoder) throws {
            
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let dateString = try container.decode(String.self, forKey: .date)
            age = try container.decode(Int.self, forKey: .age)
            
            if let date = DateFormatterHelper.date(iso8601String: dateString) {
                self.date = date
            }
            else {
                throw DecodingError.dataCorruptedError(
                    forKey: .date,
                    in: container,
                    debugDescription: "Invalid date format"
                )
            }
        }
    }
    
    // MARK: - Properties
    
    let id = UUID()
    let gender: String
    let name: Name
    let location: Location
    let email: String
    let cell: String
    let dateOfBirth: DateOfBirth
    let picture: Picture

    private enum CodingKeys: String, CodingKey {
        
        case name, location, email, cell, picture, gender, login
        case dateOfBirth = "dob"
        case nationality = "nat"
    }

    // MARK: - Life cycle
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)

        name = try container.decode(Name.self, forKey: .name)
        location = try container.decode(Location.self, forKey: .location)
        email = try container.decode(String.self, forKey: .email)
        cell = try container.decode(String.self, forKey: .cell)
        dateOfBirth = try container.decode(DateOfBirth.self, forKey: .dateOfBirth)
        picture = try container.decode(Picture.self, forKey: .picture)
        gender = try container.decode(String.self, forKey: .gender)
    }
}
