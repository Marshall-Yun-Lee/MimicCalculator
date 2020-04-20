//
//  MimicCalculatorUITests.swift
//  MimicCalculatorUITests
//
//  Created by Marshall Lee on 2020-04-18.
//  Copyright © 2020 Marshall Lee. All rights reserved.
//

import XCTest

class MimicCalculatorUITests: XCTestCase {
    let app = XCUIApplication()

    func testUI() throws {
        app.launch()
        validateButton(key: "0")
        XCTAssertTrue(app.staticTexts["0"].exists)
        validateButton(key: "1")
        XCTAssertTrue(app.staticTexts["1"].exists)
        validateButton(key: "2")
        XCTAssertTrue(app.staticTexts["12"].exists)
        validateButton(key: "3")
        XCTAssertTrue(app.staticTexts["123"].exists)
        validateButton(key: "4")
        XCTAssertTrue(app.staticTexts["1234"].exists)
        validateButton(key: "5")
        XCTAssertTrue(app.staticTexts["12345"].exists)
        validateButton(key: "6")
        XCTAssertTrue(app.staticTexts["123456"].exists)
        validateButton(key: "7")
        XCTAssertTrue(app.staticTexts["1234567"].exists)
        validateButton(key: "8")
        XCTAssertTrue(app.staticTexts["12345678"].exists)
        validateButton(key: "9")
        XCTAssertTrue(app.staticTexts["123456789"].exists)
        
        validateButton(key: "AC")
        XCTAssertTrue(app.staticTexts["0"].exists)
        
        app.buttons["1"].tap()
        validateButton(key: "+")
        app.buttons["1"].tap()
        validateButton(key: "=")
        XCTAssertTrue(app.staticTexts["2.0"].exists)
        
        validateButton(key: "-")
        app.buttons["1"].tap()
        app.buttons["="].tap()
        XCTAssertTrue(app.staticTexts["1.0"].exists)
        
        validateButton(key: "X")
        app.buttons["5"].tap()
        app.buttons["="].tap()
        XCTAssertTrue(app.staticTexts["5.0"].exists)
        
        validateButton(key: "/")
        app.buttons["5"].tap()
        app.buttons["="].tap()
        XCTAssertTrue(app.staticTexts["1.0"].exists)
        
        validateButton(key: "%")
        XCTAssertTrue(app.staticTexts["0.01"].exists)
        
        validateButton(key: "+/-")
        XCTAssertTrue(app.staticTexts["-0.01"].exists)
    }
    
    private func validateButton(key: String) {
        XCTAssertTrue(app.buttons[key].exists)
        app.buttons[key].tap()
    }
}
