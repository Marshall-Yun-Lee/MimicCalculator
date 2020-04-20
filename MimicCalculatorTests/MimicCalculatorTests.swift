import SwiftUI
import XCTest
@testable import MimicCalculator

var view: ContentView!


class MimicCalculatorTests: XCTestCase {
    
     override class func setUp() {
            view = ContentView()
       }
    
    func test_Init() throws {
        XCTAssertEqual(view.currentResult, "0")
        XCTAssertEqual(view.previousInput, 0)
        XCTAssertNil(view.currentOperation)
    }
    
    func test_NumberClicks() throws {
        view._handleUserInput(clicked: CalcButton.one)
        validateStates(result: "1", input: 0, operation: nil)
       
        view._handleUserInput(clicked: CalcButton.two)
        validateStates(result: "12", input: 0, operation: nil)
        
        view._handleUserInput(clicked: CalcButton.three)
        validateStates(result: "123", input: 0, operation: nil)
        
        view._handleUserInput(clicked: CalcButton.four)
        validateStates(result: "1234", input: 0, operation: nil)
        
        view._handleUserInput(clicked: CalcButton.five)
        validateStates(result: "12345", input: 0, operation: nil)
        
        view._handleUserInput(clicked: CalcButton.six)
        validateStates(result: "123456", input: 0, operation: nil)
        
        view._handleUserInput(clicked: CalcButton.seven)
        validateStates(result: "1234567", input: 0, operation: nil)
        
        view._handleUserInput(clicked: CalcButton.eight)
        validateStates(result: "12345678", input: 0, operation: nil)
        
        view._handleUserInput(clicked: CalcButton.nine)
        validateStates(result: "12356789", input: 0, operation: nil)
        
        view._handleUserInput(clicked: CalcButton.zero)
        validateStates(result: "1234567890", input: 0, operation: nil)
    }
    
    func test_AC() {
        view._handleUserInput(clicked: CalcButton.nine)
        view._handleUserInput(clicked: CalcButton.nine)
        view._handleUserInput(clicked: CalcButton.ac)
        validateStates(result: "0", input: 0, operation: nil)
    }
    
    func test_Plus() {
        view._handleUserInput(clicked: CalcButton.one)
        view._handleUserInput(clicked: CalcButton.plus)
        view._handleUserInput(clicked: CalcButton.one)
        
        view._handleUserInput(clicked: CalcButton.equals)
        validateStates(result: "2.0", input: 0, operation: nil)
    }
    
    func test_Minus() {
        view._handleUserInput(clicked: CalcButton.two)
        view._handleUserInput(clicked: CalcButton.minus)
        view._handleUserInput(clicked: CalcButton.one)
        
        view._handleUserInput(clicked: CalcButton.equals)
        validateStates(result: "1.0", input: 0, operation: nil)
    }
    
    func test_Multiply() {
        view._handleUserInput(clicked: CalcButton.two)
        view._handleUserInput(clicked: CalcButton.multiply)
        view._handleUserInput(clicked: CalcButton.two)
        
        view._handleUserInput(clicked: CalcButton.equals)
        validateStates(result: "4.0", input: 0, operation: nil)
    }
    
    func test_Divide() {
        view._handleUserInput(clicked: CalcButton.nine)
        view._handleUserInput(clicked: CalcButton.divide)
        view._handleUserInput(clicked: CalcButton.three)
        
        view._handleUserInput(clicked: CalcButton.equals)
        validateStates(result: "3.0", input: 0, operation: nil)
    }
}

/*
 This validates all states based on the given parameters
 */
private func validateStates(result: String, input: Float, operation: Operations?) -> Void {
    XCTAssertEqual(view.currentResult, result)
    XCTAssertEqual(view.previousInput, input)
    XCTAssertEqual(view.currentOperation, operation)
}
