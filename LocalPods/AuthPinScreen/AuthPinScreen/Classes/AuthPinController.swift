//
//  AuthPinController.swift
//  AuthPinScreen
//
//  Created by Maria on 23.02.2020.
//

import UIKit

public enum AuthPinState {
    case setPin // set new pin
    case confirmPin // sign in with pin
}

@available(iOS 9.0, *)
open class AuthPinController: UIViewController {
    //setPin
    @IBOutlet weak var setPinStack: UIStackView?
    @IBOutlet var enterDots: [UIImageView]?
    //confirmPin
    @IBOutlet weak var confirmPinStack: UIStackView?
    @IBOutlet var confirmDots: [UIImageView]?
    //pin numbers
    @IBOutlet var pinBtns: [UIButton]?
    
    public var state: AuthPinState = .setPin
    
    var pincode: Pincode?
    var confirmPincode: Pincode?

    override open func viewDidLoad() {
        super.viewDidLoad()
        switch state {
        case .setPin:
            print("STATE SET PIN")
            setupPin()
            setupConfirmPin()
        case .confirmPin:
            print("STATE CONFIRM PIN")
            setupPin()
        }
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        confirmPinStack?.isHidden = state == .confirmPin
    }
    
    func setupPin() {
        pincode = Pincode()
        pincode?.didChangePin = { [weak self] colors in
            guard let `self` = self, let dots = self.enterDots else { return }
            self.redraw(dots, with: colors)
        }
        pincode?.didFinishedEnterPin = { code in
            print("Pincode is: \(code)")
        }
    }
    
    func redraw(_ dots: [UIImageView], with colors: [UIColor]) {
        guard colors.count == dots.count else { return }
        dots.enumerated().forEach({ (index, element) in
            element.tintColor = colors[index]
        })
    }
    
    func setupConfirmPin() {
        confirmPincode = Pincode()
        confirmPincode?.didChangePin = { [weak self] colors in
            guard let `self` = self, let dots = self.confirmDots else { return }
            self.redraw(dots, with: colors)
        }
        confirmPincode?.didFinishedEnterPin = { code in
            print("Confirm Pincode is: \(code)")
        }
    }
    
    public func createAuthPinController(with state: AuthPinState) -> AuthPinController? {
        let authPinBundle = Bundle(for: AuthPinController.self)
        if let authPinController = authPinBundle.loadNibNamed("AuthPinController", owner: self, options: nil)?.first as? AuthPinController {
            authPinController.state = state
            return authPinController
        }
        return nil
    }
    
    @IBAction func touchNumberBtn(_ sender: UIButton) {
        if pincode?.code.count != pincode?.maxLength {
            pincode?.insertText("\(sender.tag)")
        } else if confirmPincode?.code.count != confirmPincode?.maxLength {
            confirmPincode?.insertText("\(sender.tag)")
        }
    }
    
    @IBAction func touchRemoveBtn(_ sender: Any) {
        if let confirmPincode = confirmPincode, confirmPincode.code.count > 0 {
            confirmPincode.removeText()
        } else if let pincode = pincode, pincode.code.count > 0 {
            pincode.removeText()
        }
    }
    
    @IBAction func touchSignInBtn(_ sender: Any) {
        switch state {
        case .setPin:
            if pincode?.code == confirmPincode?.code {
                print("SUCCESS")
            } else {
                print("ERROR")
            }
        case .confirmPin:
            if let pincode = pincode, pincode.isCodeFill() {
                print("SUCCESS PINCODE = \(pincode.code)")
            }
        }
    }
    
    @IBAction func touchBackBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}


