//
//  AuthPinControllerDelegate.swift
//  AuthPinScreen
//
//  Created by Maria on 25.02.2020.
//

import Foundation

public protocol AuthPinControllerDelegate: class {
    
    var state: AuthPinState { set get }
    func didSetNewPin(_ pin: String)
    func didSuccessSignIn()
    func didTouchBackBtn()
}
