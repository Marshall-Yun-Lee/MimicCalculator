//
//  ContentView.swift
//  MimicCalculator
//
//  Created by Marshall Lee on 2020-04-18.
//  Copyright © 2020 Marshall Lee. All rights reserved.
//

import SwiftUI
import Foundation

// button information
enum CalcButton: String {
    case zero, one, two, three, four, five, six, seven, eight, nine, decimal
    case equals, plus, minus, multiply, divide
    case ac, plusMinus, percentage
    
    var title: String {
        switch self {
            case .zero: return "0"
            case .one: return "1"
            case .two: return "2"
            case .three: return "3"
            case .four: return "4"
            case .five: return "5"
            case .six: return "6"
            case .seven: return "7"
            case .eight: return "8"
            case .nine: return "9"
            case .decimal: return "."
            case .equals: return "="
            case .plus: return "+"
            case .minus: return "-"
            case .multiply: return "X"
            case .divide: return "/"
            case .ac: return "AC"
            case .plusMinus: return "+/-"
            case .percentage: return "%"
        }
    }
    
    var backgroundColor: Color {
        switch self {
            case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .decimal:
                return Color(.darkGray)
            case .equals, .plus, .minus, .multiply, .divide:
                return Color(.orange)
            case .ac, .plusMinus, .percentage:
                return Color(.lightGray)
        }
    }
}

enum Operations  {
    case plus
    case minus
    case multiply
    case divide
    
    var name: String {
        switch self {
        case .plus: return "+"
        case .minus: return "-"
        case .multiply: return "*"
        case .divide: return "/"
        default:
            return "nil"
        }
    }
}

// numbers
let numberList: [String] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "."]

struct ContentView: View {
    // User input data
    @State var currentResult: String = "0";
    @State var previousInput: Float = 0;
    @State var currentOperation: Operations? = nil;
    @State var isNegative: Bool = false;
    
    // button list
    let buttons: [[CalcButton]] = [
        [.ac, .plusMinus, .percentage, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .decimal, .equals]
    ]
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all) // background
            
            VStack(spacing: 10) { // actual number stacks
                Spacer()
                 // output
                HStack {
                    Spacer()
                    self._drawOutput(input:  currentResult)
                }.padding(.horizontal)
                
                 // buttons
                ForEach(buttons, id: \.self) { row in
                    HStack {
                        ForEach(row, id: \.self) { button in
                            Button(action: {
                                self._handleUserInput(clicked: button)
                            }) {
                                Text(button.title)
                                    .font(.system(size: 30))
                                    .frame(width: (button.title == "0") ? self._calcButtonWidth() * 2 + 10 : self._calcButtonWidth(),
                                           height: self._calcButtonWidth()) // adding 10 for spacings in the mdidle
                                    .foregroundColor(Color.white)
                                    .background(button.backgroundColor)
                            }.cornerRadius(self._calcButtonWidth())
                        }
                    }.padding(.horizontal)
                }
            }.padding(.bottom)
        }
    }
    
    /**
     returns button width based on the screen size
     screen width - 10px margin * 5 each / 4 buttons
     */
    func _calcButtonWidth() -> CGFloat {
        return (UIScreen.main.bounds.width - 5 * 10) / 4
    }
    
    /**
     return 70 white Text with the given string
     */
    private func _drawOutput(input: String) -> Text {
        return isNegative ? Text("-" + input).foregroundColor(Color.white).font(.system(size: 70))
                                : Text(input).foregroundColor(Color.white).font(.system(size: 70))
    }
    
    /**
     This handles button clicks
     */
    func _handleUserInput(clicked: CalcButton) {
        if self._isNumberButton(button: clicked) {
            if currentResult == "0" || currentResult == "0.0" || currentResult == ".0" {
                self.currentResult = clicked.title
            } else if currentOperation != nil {
                currentResult += clicked.title
            } else {
                self.currentResult += clicked.title
            }
        } else {
            switch clicked.title {
            case "AC": self._handleAC()
            case "C": self._handleC()
            case "+/-": self._handlePlusMinus()
            case "%": self._handlePercentage()
            
            case "+": self._handleOperations(operation: Operations.plus)
            case "-": self._handleOperations(operation: Operations.minus)
            case "X": self._handleOperations(operation: Operations.multiply)
            case "/": self._handleOperations(operation: Operations.divide)
            
            case "=": self._handleCompute()
            default:
                print("Unable to recognize current input: " + clicked.title)
            }
        }
        
        print(currentResult)
        print(previousInput)
        print(currentOperation ?? "nil")
        print("\n")
    }
    
    /**
     This validates if the clicked button is number
     */
    private func _isNumberButton(button: CalcButton) -> Bool {
        return numberList.contains(button.title)
    }
    
    
    //================Instant Operations=================
    /**
     this handles AC input (clear all)
     */
    private func _handleAC() -> Void {
        currentResult = "0"
        previousInput = 0
        currentOperation = nil
        isNegative = false;
    }
    
    /**
    This handles C input (Clear current input)
     */
    private func _handleC() -> Void {
        currentResult = "0"
    }
    
    /**
    this handles +/- input (invert sign)
     */
    private func _handlePlusMinus() -> Void {
        isNegative = !isNegative
    }
    
    /**
     This handles % input (percentage)
     */
    private func _handlePercentage() -> Void {
        currentResult = String((Float(currentResult) ?? 0) / 100.0)
    }
    
    /**
     This handles = input (compute)
     */
    private func _handleCompute() -> Void {
        self._compute()
    }
    
    //===================================================
    
    
    //================Numeric Operations=================
    /*
     This handles calculations based on the given operation
     */
    private func _handleOperations(operation: Operations) -> Void {
        if isNegative { // current input is negative
            previousInput = (Float(currentResult) ?? 0) * -1
        } else { // current input is positive
            previousInput = Float(currentResult) ?? 0
        }
        isNegative = false;
        currentResult = "0"
        
        // perform operation if there is an existing operation
        if (currentResult != "0" || currentResult != "0.0" || currentResult != ".0") && previousInput != 0 {
            if currentOperation != nil {
                self._performOperations(operation: currentOperation)
            } else {
                // Operation's nil. Do nothing
            }
        }
        // override the operation with new one
        currentOperation = operation
    }
    
    // this performs arithmetic operation provided
    private func _performOperations(operation: Operations?) -> Void {
        if operation == nil {
            print("current operation is unknown")
            return;
        } else {
            let current: Float = Float(currentResult) ?? 0;
            let previous: Float = previousInput;
            
            switch operation {
            case .plus:      currentResult = String(previous + current)
            case .minus:     currentResult = String(previous - current)
            case .multiply: currentResult = String(previous * current)
            case .divide:   currentResult = String(previous / current)
            default:
                print("Unable to recognize the given arithmetic operation")
            }
        }
        if currentResult.first == "-" {
            isNegative = true
            currentResult = String(currentResult[currentResult.index(after: currentResult.startIndex)..<currentResult.endIndex])
        } else {
            isNegative = false
        }
        previousInput = 0
        currentOperation = nil
    }
    
    // this computes whatevern number and operation in the memory at the moment of invocation
    private func _compute() -> Void {
        if currentOperation == nil {
            // do nohting
        } else {
            self._performOperations(operation: currentOperation)
        }
    }
    //===================================================
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
