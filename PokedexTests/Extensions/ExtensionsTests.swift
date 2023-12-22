//
//  ExtensionsTests.swift
//  PokedexTests
//
//  Created by Ezequiel Barreto on 15/12/23.
//

import XCTest
@testable import Pokedex

final class ExtensionsTests: XCTestCase {
    // MARK: - Properties
    
    var viewModel: PokemonDetailViewModelConcrete!
    var pokemon: Pokemon!
    // MARK: - Initialization
    
    /// Method that is called previous the tests execution (we should initialize all data here)
    override func setUp() {
        super.setUp()
        pokemon = Pokemon(id: 10, attack: 55, name: "Pikachu", type: "Electric", defense: 40, description: "A cute Pokemon", imageUrl: "https://example.com/pikachu.png")
        viewModel = PokemonDetailViewModelConcrete()
    }
    
    /// Method that is called after one test execution (we should delete all data generated here)
    override func tearDown() {
        super.tearDown()
        viewModel = nil
        pokemon = nil
    }
    func testGetNumberOfRows() {
        let numberOfSections = viewModel.getNumberOfRows()
        XCTAssertEqual(numberOfSections, PokemonDetailSection.allCases.count)
    }
    
    func testImageURL() {
        let pokemon = Pokemon(id: 10, attack: 55, name: "Pikachu", type: "https://example.com/pikachu.png", defense: 40, description: "Electric", imageUrl: "https://example.com/pikachu.png")
        viewModel = PokemonDetailViewModelConcrete(pokemonToShow: pokemon)
        
        XCTAssertEqual(viewModel.getImageURL(), "https://example.com/pikachu.png")
    }
    
    func testInfoData() {
        if let infoData = viewModel.getInfoData() {
            XCTAssertEqual(infoData.attack, 0)
            XCTAssertEqual(infoData.defense, 0)
        } else {
            XCTFail("The data hasn't be nill")
        }
    }
    
    func testGetValueReusable() {
        
        XCTAssertEqual(viewModel.getValueReusable(forSection: .title) as? String, "Bulbasaur")
        XCTAssertEqual(viewModel.getValueReusable(forSection: .type) as? String, "Type: Grass")
        // here have to be more date if its necesary
    }
    
    func testGetView() {
        let viewController = viewModel.getView() as? pokemonDetailViewController
        
        XCTAssertNotNil(viewController)
        
        if let viewModelFromViewController = viewController?.viewModel as? PokemonDetailViewModelConcrete {
            XCTAssertEqual(viewModelFromViewController.pokemonToShow?.name, pokemon.name)
            XCTAssertEqual(viewModelFromViewController.pokemonToShow?.imageUrl, pokemon.imageUrl)
            // Chek if the propierties and other data necesary
        } else {
            XCTFail("cannt obtain data or the viewContoller its diff type")
        }
    }
    // MARK: - Tests
    
    func test_add_subviews_extension_count_successfully() {
        let testView = UIView()
        let childView1 = UIView()
        let childView2 = UIView()
        
        testView.addSubviews(childView1, childView2)
        
        
        XCTAssertEqual(testView.subviews.count, 2)
    }
    
}
