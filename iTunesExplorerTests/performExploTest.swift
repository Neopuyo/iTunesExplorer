//
//  performExploTest.swift
//  iTunesExplorerTests
//
//  Created by Loup Martineau on 04/02/2024.
//

import XCTest
@testable import iTunesExplorer

final class performExploTest: XCTestCase {
	
    func testDumb() {
        XCTExpectFailure()
        XCTAssertEqual(25, Int(24.0), "The dumb test failed")
    }
	
	func testComparingFetches() throws {
		var resultWithURLSession:String = ""
		var resultWithCombine:String = ""
		
		
		let explo_URLSession = Explo()
		let explo_Combine = ExploUsingCombine()
		
		var exploResults_URLSession = [ExploResult]()
		var exploResults_Combine = [ExploResult]()
		
		let exploItem = "smurf"
		
		// URLSESSION FETCH
		let expectation_URLSession = XCTestExpectation(description: "perform UrlSession explo with item \(exploItem)")
		
		explo_URLSession.performExplo(for: exploItem, category: Explo.Category.movie) { success in
			if !success {
				assertionFailure("perform explo URLSession failed for term \(exploItem)")
			} else {
				if case .results(let list) = explo_URLSession.state {
					exploResults_URLSession = list
					for item in exploResults_URLSession {
						resultWithURLSession += item.name + ", "
					}
					expectation_URLSession.fulfill()
				}
			}
		}
		
		// COMBINE FETCH
		let expectation_Combine = XCTestExpectation(description: "perform Combine explo with item \(exploItem)")
		
		explo_Combine.performExplo(for: exploItem, category: ExploUsingCombine.Category.movie) { success in
			if !success {
				assertionFailure("perform explo combine failed for term \(exploItem)")
			} else {
				if case .results(let list) = explo_Combine.state {
					exploResults_Combine = list
					for item in exploResults_Combine {
						resultWithCombine += item.name + ", "
					}
					expectation_Combine.fulfill()
				}
			}
		}
		
		wait(for: [expectation_URLSession, expectation_Combine], timeout: 6.0)
		XCTAssertTrue(exploResults_URLSession.count > 0, "no string result for URLSession explo")
		XCTAssertTrue(exploResults_Combine.count > 0, "no string result for Combine explo")
		addTeardownBlock {
			print("URLSESSION :")
			print(resultWithURLSession)
			
			print("COMBINE :")
			print(resultWithCombine)
			XCTAssertEqual(resultWithURLSession, resultWithCombine, "The two fetches don't give the same")
		}
	}
	
}
