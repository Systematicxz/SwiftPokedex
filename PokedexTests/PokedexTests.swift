//
//  PokedexTests.swift
//  PokedexTests
//
//  Created by Ezequiel Barreto on 15/12/23.
//

import XCTest
@testable import Pokedex

final class PokedexTests: XCTestCase {
    
    // MARK: - Initialization
    func testSingletonInstance() {
        let manager1 = PokemonManager.shared
        let manager2 = PokemonManager.shared
        
        XCTAssertTrue(manager1 === manager2, "the instance are not the same ")
    }
    /// Method that is called previous the tests execution (we should initialize all data here)
    override func setUp() {
        super.setUp()
        
    }
    func testDelegateNotNil() {
        XCTAssertNotNil(PokemonManager.shared.delegate, "Delegate shouldnt be nil ")
    }
    
    func testShowPokemonDoesNotCrash() {
        // method that check the showPokemon() don't throws and exception
        XCTAssertNoThrow(PokemonManager.shared.showPokemon(), "call to showPokemon() provoke an excepcion ")
    }
    enum TestError: Error {
        case testCase
    }
    
    func testMethodThrowsError() {
        XCTAssertThrowsError(try someMethodThatThrows(), "The metodh should throw an error") { error in
            // Add more code based in the error if its necesary
            // for example cheking inf the error or the message display
            XCTAssertTrue((error as? TestError) == .testCase, "the error its not the expected")
        }
    }
    
    // Exapmle for a method that throw and excepcion
    func someMethodThatThrows() throws {
        throw TestError.testCase
    }
    
    /// Method that is called after one test execution (we should delete all data generated here)
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Tests
    
    /// All the tests should start with the word `test` so Xcode can detect it
    func testExample() throws {
        
    }
}
