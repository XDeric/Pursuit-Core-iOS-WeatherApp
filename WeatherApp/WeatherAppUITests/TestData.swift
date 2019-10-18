//
//  TestData.swift
//  WeatherAppUITests
//
//  Created by EricM on 10/17/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import XCTest
@testable import WeatherApp

class TestData: XCTestCase {
    
    func testGetData(){
        //Arrange
        let picData = getSampleData()
        //Act
        let picture = Hits.getPic(from: picData)
        //Assert
        XCTAssert(picture.count != 0)
    }
    
    func getSampleData() -> Data{
        guard let pathData = Bundle.main.path(forResource: "test", ofType: "json") else {
            fatalError("json not found ")
        }
        let internalURL = URL(fileURLWithPath: pathData)
        do{
            let data = try Data(contentsOf: internalURL)
            return data
        }catch {
            fatalError("\(error.localizedDescription)")
        }
    }

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
