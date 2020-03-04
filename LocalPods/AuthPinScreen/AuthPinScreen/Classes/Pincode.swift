//
//  Pincode.swift
//  AuthPinScreen
//
//  Created by Maria on 24.02.2020.
//

import Foundation

class Pincode {
    
    // MARK: - Properties
    var maxLength: Int
    
    var didFinishedEnterPin: ((String) -> Void)?
    var didChangePin: (([UIColor]) -> Void)?
    
    var code = "" {
        didSet {
            if code.count == maxLength, let didFinishedEnterPin = didFinishedEnterPin {
                didFinishedEnterPin(code)
            }
        }
    }
    
    var hasText: Bool {
        return code.count > 0
    }
    
    // MARK: - Lifecycle
    
    init(with length: Int) {
        self.maxLength = length
    }
    
    // MARK: - Public
    
    func insertText(_ text: String) {
        if code.count == maxLength {
            return
        }
        code.append(contentsOf: text)
    }
    
    func removeText() {
        if hasText {
            code.removeLast()
        }
    }
    
    func removeAllText() {
        if hasText {
            code.removeAll()
        }
    }
    
    func isCodeFill() -> Bool {
        return code.count == maxLength
    }

}
