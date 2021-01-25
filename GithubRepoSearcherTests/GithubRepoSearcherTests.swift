//
//  GithubRepoSearcherTests.swift
//  GithubRepoSearcherTests
//
//  Created by Dariusz Mazur on 25/01/2021.
//  Copyright © 2021 eRapid Studio. All rights reserved.
//

import XCTest
@testable import GithubRepoSearcher

class GithubRepoSearcherTests: XCTestCase {
    var vc: SearchVC!
    
    override func setUp() {
        super.setUp()
        vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "SearchVC") as? SearchVC
        vc.loadViewIfNeeded()
    }

    override func tearDown() {
        vc = nil
        super.tearDown()
    }

    func testSearchIsEmpty() {
        let guess = vc.searchBar.text

        // 3. then
        XCTAssertEqual(guess, "", "SearchBar should be empty")
    }
    
    func testSearchText() {
        vc.searchBar.text = "Test Text"
        let guess = vc.searchBar.text

        // 3. then
        XCTAssertEqual(guess, "Test Text", "SearchBar should have value 'Test Text'")
    }
}
