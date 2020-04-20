import Foundation

struct Stack {
    fileprivate var stackedItems: [String] = []
    
    mutating func push(_ element: String) {
        stackedItems.append(element)
    }
    
    mutating func pop() -> String? {
        if !stackedItems.isEmpty {
            return stackedItems.removeLast()
        }
        return nil
    }
}

extension Stack: CustomStringConvertible {
    var description: String {
        let topDivider = "---Stack---\n"
        let bottomDivider = "\n-----------\n"
        
        let stackElements = stackedItems.reversed().joined(separator: "\n")
        return topDivider + stackElements + bottomDivider
    }
}



