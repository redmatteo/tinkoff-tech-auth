//
//  Pincode.swift
//  AuthPinScreen
//
//  Created by Maria on 24.02.2020.
//

import Foundation

class Pincode {
    
    var maxLength = 4
    var didFinishedEnterPin: ((String) -> Void)?
    var didChangePin: (([UIColor]) -> Void)?
    
    var code = "" {
        didSet {
            didChangePin?(updateStack(by: code))
            if code.count == maxLength, let didFinishedEnterPin = didFinishedEnterPin {
                didFinishedEnterPin(code)
            }
        }
    }
    
    var hasText: Bool {
        return code.count > 0
    }
    
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
    
    private func emptyDot() -> UIColor {
        return .lightGray
    }
    
    private func fillDot() -> UIColor {
        return .systemYellow
    }
    
    private func updateStack(by code: String) -> [UIColor] {
        var emptyDotsColors: [UIColor] = Array(0..<maxLength).map { _ in emptyDot()}
        let userPinLength = code.count
        let fillDotsColors: [UIColor] = Array(0..<userPinLength).map { _ in fillDot()}
        
        for (index, element) in fillDotsColors.enumerated() {
            emptyDotsColors[index] = element
        }
        return emptyDotsColors
    }

}
