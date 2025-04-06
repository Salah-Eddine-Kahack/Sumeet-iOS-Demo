//
//  ContactServiceTests.swift
//  Sumeet-iOS-DemoTests
//
//  Created by Salah Eddine KAHACK on 06/04/2025.
//

import XCTest
import Combine
@testable import Sumeet_iOS_Demo


final class ContactServiceTests: XCTestCase {
    
    // MARK: - Properties
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Tests

    func test_fetchContacts_with_mock_environment() throws {
        
        // Setup test
        let expectation = self.expectation(description: "Fetch contacts expectation")
        let service = ServiceFactory.makeContactService(environment: .mock)
        
        try XCTContext.runActivity(
            named: "fetchContacts should be able to decode and return a list of contacts"
        ) { _ in
            
            var receivedContacts: [ContactModel] = []
            var receivedError: Error?
            
            // Fetch data
            service.fetchContacts()
            .sink(receiveCompletion: { completion in
                
                switch completion {
                    case .failure(let error): receivedError = error
                    case .finished: break
                }
                
                expectation.fulfill()
            },
            receiveValue: { contacts in
                receivedContacts = contacts
            })
            .store(in: &cancellables)
            
            // Give it time to load
            waitForExpectations(timeout: 5.0, handler: nil)
            
            // Check results
            XCTAssertNil(
                receivedError,
                "Expected no error, but received \(receivedError.debugDescription) instead"
            )
            
            XCTAssertEqual(
                receivedContacts.count, 10,
                "Expected 10 contacts, but received \(receivedContacts.count) instead"
            )
            
            let firstContact = try XCTUnwrap(receivedContacts.first)
            
            XCTAssertEqual(
                firstContact.name.last,
                "Dias",
                "Expected first contact last name to be \"Dias\", but got \(firstContact.name.last) instead"
            )
            
            let secondContact = receivedContacts[1]
            
            XCTAssertEqual(
                secondContact.name.last,
                "گلشن",
                "Expected second contact last name to be \"گلشن\", but got \(secondContact.name.last) instead"
            )
            
            // Check formatting
            try checkDateFormatting(contacts: receivedContacts)
            try checkContactFormatting(contacts: receivedContacts)
            checkAddressFormatting(contacts: receivedContacts)
        }
    }
    
    func checkDateFormatting(contacts: [ContactModel]) throws {
        
        let firstContact = try XCTUnwrap(contacts.first)
        let firstContactBirthDate = DateFormatterHelper.simpleDateString(date: firstContact.dateOfBirth.date)
        let firstContactBirthday = DateFormatterHelper.birthday(date: firstContact.dateOfBirth.date)
        
        XCTAssertEqual(
            firstContactBirthDate,
            "03/09/1958",
            "Expected first contact birth date to be \"03/09/1958\" but got \(firstContactBirthDate) instead"
        )
        
        XCTAssertEqual(
            firstContactBirthday,
            "3 September",
            "Expected first contact birth date to be \"3 September\" but got \(firstContactBirthday) instead"
        )
        
        let lastContact = try XCTUnwrap(contacts.last)
        let lastContactBirthDate = DateFormatterHelper.simpleDateString(date: lastContact.dateOfBirth.date)
        let lastContactBirthday = DateFormatterHelper.birthday(date: lastContact.dateOfBirth.date)
        
        XCTAssertEqual(
            lastContactBirthDate,
            "14/10/1963",
            "Expected last contact birth date to be \"14/10/1963\" but got \(lastContactBirthDate) instead"
        )
        
        XCTAssertEqual(
            lastContactBirthday,
            "14 October",
            "Expected last contact birth date to be \"14 October\" but got \(lastContactBirthday) instead"
        )
    }
    
    func checkContactFormatting(contacts: [ContactModel]) throws {
        
        let firstContact = try XCTUnwrap(contacts.first)
        let firstContactFullName = ContactFormatterHelper.getFullName(name: firstContact.name)

        XCTAssertEqual(
            firstContactFullName,
            "Dorico Dias",
            "Expected first contact last name to be \"Dias\", but got \(firstContactFullName) instead"
        )
        
        let secondContact = contacts[1]
        let secondContactFullName = ContactFormatterHelper.getFullName(name: secondContact.name)
        
        XCTAssertEqual(
            secondContactFullName,
            "آدرین گلشن",
            "Expected second contact last name to be \"آدرین گلشن\", but got \(secondContactFullName) instead"
        )
    }
    
    func checkAddressFormatting(contacts: [ContactModel]) {
        
        let secondContact = contacts[1]
        let secondContactFullAddress = AddressFormatterHelper.getFullAddress(location: secondContact.location)
        
        XCTAssertEqual(
            secondContactFullAddress,
            "2252 میدان شهید نامجو, ورامین, Iran",
            "Expected third contact full address to be \"2252 میدان شهید نامجو, ورامین, Iran\", but got \(secondContactFullAddress) instead"
        )
        
        let thirdContact = contacts[2]
        let thirdContactFullAddress = AddressFormatterHelper.getFullAddress(location: thirdContact.location)
        
        XCTAssertEqual(
            thirdContactFullAddress,
            "3053 Jones Road, Sligo, Ireland",
            "Expected third contact full address to be \"3053 Jones Road, Sligo, Ireland\", but got \(thirdContactFullAddress) instead"
        )
    }
}
