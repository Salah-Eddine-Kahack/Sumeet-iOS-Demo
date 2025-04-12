//
//  ContactTests.swift
//  Sumeet-iOS-DemoTests
//
//  Created by Salah Eddine KAHACK on 06/04/2025.
//

import XCTest
import Combine
@testable import Sumeet_iOS_Demo


final class ContactTests: XCTestCase {
    
    // MARK: - Properties
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Tests

    func test_ContactService_fetchContacts_with_mock_environment() throws {
        
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
            try checkAddressFormatting(contacts: receivedContacts)
        }
    }
    
    func checkDateFormatting(contacts: [ContactModel]) throws {
        
        let firstContact = try XCTUnwrap(contacts.first)
        let lastContact = try XCTUnwrap(contacts.last)
        
        // MARK: Testing DateFormatterHelper.simpleDateString
        
        let firstContactBirthDate = DateFormatterHelper.simpleDateString(date: firstContact.dateOfBirth.date)
        let lastContactBirthDate = DateFormatterHelper.simpleDateString(date: lastContact.dateOfBirth.date)
        
        XCTAssertEqual(
            firstContactBirthDate,
            "03/09/1958",
            "Expected first contact birth date to be \"03/09/1958\" but got \(firstContactBirthDate) instead"
        )
        
        XCTAssertEqual(
            lastContactBirthDate,
            "14/10/1963",
            "Expected last contact birth date to be \"14/10/1963\" but got \(lastContactBirthDate) instead"
        )
        
        // MARK: Testing DateFormatterHelper.birthday
        
        let firstContactBirthday = DateFormatterHelper.birthday(date: firstContact.dateOfBirth.date)
        let lastContactBirthday = DateFormatterHelper.birthday(date: lastContact.dateOfBirth.date)
        
        XCTAssertEqual(
            firstContactBirthday,
            "3 September",
            "Expected first contact birth date to be \"3 September\" but got \(firstContactBirthday) instead"
        )
        
        XCTAssertEqual(
            lastContactBirthday,
            "14 October",
            "Expected last contact birth date to be \"14 October\" but got \(lastContactBirthday) instead"
        )
    }
    
    func checkContactFormatting(contacts: [ContactModel]) throws {
        
        let firstContact = try XCTUnwrap(contacts.first)
        let secondContact = contacts[1]
        let sixthContact = contacts[5]
        
        // MARK: Testing ContactFormatterHelper.getFullName
        
        let firstContactFullName = ContactFormatterHelper.getFullName(name: firstContact.name)

        XCTAssertEqual(
            firstContactFullName,
            "Dorico DIAS",
            "Expected first contact full name to be \"Dorico DIAS\", but got \(firstContactFullName) instead"
        )
        
        let secondContactFullName = ContactFormatterHelper.getFullName(name: secondContact.name)
        
        XCTAssertEqual(
            secondContactFullName,
            "آدرین گلشن",
            "Expected second contact last name to be \"آدرین گلشن\", but got \(secondContactFullName) instead"
        )
        
        let faultyContactFullName = ContactFormatterHelper.getFullName(name: ContactModel.Name(first: " ", last: "\n"))

        XCTAssertEqual(
            faultyContactFullName,
            Constants.Texts.Testing.unknownFullName,
            "Expected first contact full name to be \"\(Constants.Texts.Testing.unknownFullName)\", but got \(faultyContactFullName) instead"
        )
        
        // MARK: Testing ContactFormatterHelper.getGender
        
        let firstContactGender = ContactFormatterHelper.getGender(firstContact)
        
        XCTAssertEqual(
            firstContactGender,
            .male,
            "Expected first contact gender to be \"male\", but got \(firstContactGender) instead"
        )
        
        let sixthContactGender = ContactFormatterHelper.getGender(sixthContact)
        
        XCTAssertEqual(
            sixthContactGender,
            .female,
            "Expected sixth contact gender to be \"female\", but got \(sixthContactGender) instead"
        )
    }
    
    func checkAddressFormatting(contacts: [ContactModel]) throws {
        
        let firstContact = try XCTUnwrap(contacts.first)
        let secondContact = contacts[1]
        let thirdContact = contacts[2]
        
        // MARK: Testing AddressFormatterHelper.getFullAddress

        let secondContactFullAddress = AddressFormatterHelper.getFullAddress(location: secondContact.location)
        
        XCTAssertEqual(
            secondContactFullAddress,
            "2252 میدان شهید نامجو, ورامین, Iran",
            "Expected third contact full address to be \"2252 میدان شهید نامجو, ورامین, Iran\", but got \(secondContactFullAddress) instead"
        )
        
        let thirdContactFullAddress = AddressFormatterHelper.getFullAddress(location: thirdContact.location)
        
        XCTAssertEqual(
            thirdContactFullAddress,
            "3053 Jones Road, Sligo, Ireland",
            "Expected third contact full address to be \"3053 Jones Road, Sligo, Ireland\", but got \(thirdContactFullAddress) instead"
        )
        
        let faultyLocation = ContactModel.Location(
            street: ContactModel.Location.Street(number: -1, name: ""),
            city: "",
            country: "",
            coordinates: ContactModel.Coordinates(latitude: "", longitude: "")
        )
        
        let faultyAddress = AddressFormatterHelper.getFullAddress(location: faultyLocation)
        
        XCTAssertEqual(
            faultyAddress,
            Constants.Texts.Testing.unknownAddress,
            "Expected faulty address to return \"\(Constants.Texts.Testing.unknownAddress)\", but got \(faultyAddress) instead"
        )
        
        // MARK: Testing AddressFormatterHelper.getCountryFlag
        
        let firstContactCountryFlag = AddressFormatterHelper.getCountryFlag(firstContact)
        
        XCTAssertEqual(
            firstContactCountryFlag,
            "🇧🇷",
            "Expected first contact country flag to be \"🇧🇷\", but got \(firstContactCountryFlag) instead"
        )
        
        let thirdContactCountryFlag = AddressFormatterHelper.getCountryFlag(thirdContact)
        
        XCTAssertEqual(
            thirdContactCountryFlag,
            "🇮🇪",
            "Expected third contact country flag to be \"🇮🇪\", but got \(thirdContactCountryFlag) instead"
        )
    }
}
