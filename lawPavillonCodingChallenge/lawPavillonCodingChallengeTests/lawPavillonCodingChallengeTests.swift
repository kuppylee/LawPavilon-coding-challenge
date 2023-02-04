//
//  lawPavillonCodingChallengeTests.swift
//  lawPavillonCodingChallengeTests
//
//  Created by Kuppylee on 01/02/2023.
//

import XCTest
@testable import lawPavillonCodingChallenge

final class lawPavillonCodingChallengeTests: XCTestCase {
    
     var searchViewController : SearchViewController!
    
        override func setUp() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            searchViewController = storyboard.instantiateViewController(identifier: "SearchViewController") as? SearchViewController
            _ = searchViewController.view
        }

    let response = SearchResultResponse(total_count: 10, incomplete_results: true, items: [])
    let searchResultViewModel = SearchResultViewModel()
    
    //To test if my TableView is Instantiated
    func testInitSearchResultTableView(){
        XCTAssertNotNil(searchViewController.searchResultTableView)
    }
    
    //    To test if my tableview dataSource is not nill
    func testSearchResultTableViewDataSource(){
        XCTAssertNotNil(searchViewController.searchResultTableView?.dataSource)
    }
    //    To test if my tableview delegate is not nill
    func testSearchResultTableViewDelegate(){
        XCTAssertNotNil(searchViewController.searchResultTableView?.delegate)
    }
    //To test if  datasource and delegate is from the same Instance
    func testIfDataSourceAndDelegateSameInstance(){
    XCTAssertEqual(searchViewController.searchResultTableView.dataSource as! SearchViewController, searchViewController.searchResultTableView.dataSource as! SearchViewController, "Error: Datasource and Delegate are not from the same instance")
        }
    // To test response model
    func testApiResponse() {
        XCTAssertNotNil(response)
    }
    // To test Search textfield
    func testTextfield() {
        XCTAssertEqual(searchViewController.searchUserTextField.text, "")
    }
    //To test the view model
    func testViewModel(){
        let result: () = searchResultViewModel.getSearchResult(username: "dan", page: 3 , perPage: 3, completion: {})
        XCTAssertNotNil(result)
        }
    
    
    
}
