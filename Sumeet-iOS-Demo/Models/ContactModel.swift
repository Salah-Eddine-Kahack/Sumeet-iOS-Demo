//
//  ContactModel.swift
//  Sumeet-iOS-Demo
//
//  Created by Salah Eddine KAHACK on 06/04/2025.
//

import Foundation
import UIKit


struct ContactAPIResponse: Decodable {
    let results: [ContactModel]
}


struct ContactModel: Codable, Identifiable {
    
    // MARK: - Structs
    
    struct Name: Codable {
        let first: String
        let last: String
    }

    struct Location: Codable {
        
        struct Street: Codable {
            let number: Int
            let name: String
        }
        
        let street: Street
        let city: String
        let country: String
        let coordinates: Coordinates
    }

    struct Coordinates: Codable {
        let latitude: String
        let longitude: String
    }

    struct Picture: Codable {
        let large: String
        let medium: String
        let thumbnail: String
    }
    
    struct DateOfBirth: Codable {
        
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

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            let dateString = DateFormatterHelper.string(from: date)
            try container.encode(dateString, forKey: .date)
            try container.encode(age, forKey: .age)
        }
    }
    
    // MARK: - Properties
    
    let id: UUID
    let gender: String
    let name: Name
    let location: Location
    let email: String
    let cell: String
    let dateOfBirth: DateOfBirth
    let picture: Picture
    let countryCode: String

    private enum CodingKeys: String, CodingKey {
        case name, location, email, cell, picture, gender
        case dateOfBirth = "dob"
        case countryCode = "nat"
    }

    // MARK: - Life cycle
    
    init(id: UUID = UUID(),
         gender: String,
         name: Name,
         location: Location,
         email: String,
         cell: String,
         dateOfBirth: DateOfBirth,
         picture: Picture,
         countryCode: String)
    {
        self.id = id
        self.gender = gender
        self.name = name
        self.location = location
        self.email = email
        self.cell = cell
        self.dateOfBirth = dateOfBirth
        self.picture = picture
        self.countryCode = countryCode
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = UUID()
        name = try container.decode(Name.self, forKey: .name)
        location = try container.decode(Location.self, forKey: .location)
        email = try container.decode(String.self, forKey: .email)
        cell = try container.decode(String.self, forKey: .cell)
        dateOfBirth = try container.decode(DateOfBirth.self, forKey: .dateOfBirth)
        picture = try container.decode(Picture.self, forKey: .picture)
        gender = try container.decode(String.self, forKey: .gender)
        countryCode = try container.decode(String.self, forKey: .countryCode)
    }
}
