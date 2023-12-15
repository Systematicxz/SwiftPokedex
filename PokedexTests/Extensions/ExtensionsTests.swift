//
//  ExtensionsTests.swift
//  PokedexTests
//
//  Created by Ezequiel Barreto on 15/12/23.
//

import XCTest
@testable import Pokedex

final class ExtensionsTests: XCTestCase {

    // MARK: - Initialization

    /// Method that is called previous the tests execution (we should initialize all data here)
    override func setUp() {
        super.setUp()
        
    }

    /// Method that is called after one test execution (we should delete all data generated here)
    override func tearDown() {
        super.tearDown()
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
