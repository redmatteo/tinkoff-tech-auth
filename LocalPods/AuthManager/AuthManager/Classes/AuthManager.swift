//
//  AuthManager.swift
//  AuthManager
//
//  Created by Mikhail on 19.02.2020.
//

import Foundation

public class AuthManager {
    public static func authentificate() {
        print("Hello World")
    }
    
    public enum State {
        case credentials, setPin, confirmPin
    }
    
    public init() {
        
    }
    
    public func authentificate(_ completion: (_ state: State) -> Void) {
        
    }
}
