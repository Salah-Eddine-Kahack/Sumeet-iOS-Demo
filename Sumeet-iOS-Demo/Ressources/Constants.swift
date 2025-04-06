//
//  Constants.swift
//  Sumeet-iOS-Demo
//
//  Created by Salah Eddine KAHACK on 06/04/2025.
//

import UIKit


struct Constants {
    
    struct Colors {
        static let primary = UIColor(named: "AccentColor")
        static let background = UIColor(named: "background")
    }
    
    
    struct Sizes {
        static let spacing: CGFloat = 16.0
        static let cornerRaduis: CGFloat = 8.0
    }
    
    
    struct Icons {
        static let phone = UIImage(systemName: "phone")!
        static let email = UIImage(systemName: "envelope")!
        static let text = UIImage(systemName: "bubble")!
        static let male = UIImage(systemName: "figure.stand")!
        static let female = UIImage(systemName: "figure.stand.dress")!
        static let person = UIImage(systemName: "person")!
    }
    
    
    struct URLs {
        static let mockFileURL: URL? = Bundle.main.url(forResource: "mock_data", withExtension: "json")
        static let apiURL: URL? = URL(string: "https://randomuser.me/api/?results=10")
    }
}
