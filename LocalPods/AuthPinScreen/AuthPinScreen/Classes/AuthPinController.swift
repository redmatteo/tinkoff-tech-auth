//
//  AuthPinController.swift
//  AuthPinScreen
//
//  Created by Maria on 23.02.2020.
//

import UIKit
import UIViewKit

public enum AuthPinState {
    case setPin // set new pin
    case confirmPin(_ savedPin: String) // sign in with pin
}

extension AuthPinController {
    public class func new() -> AuthPinController? {
        let bundle = Bundle(for: self.classForCoder())
        let controller = AuthPinController(nibName: "AuthPinController", bundle: bundle)
        return controller
    }
}

open class AuthPinController: UIViewController {
    
    //setPin
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pincodeView: PincodeView!
    
    //pin numbers
    @IBOutlet weak var errorLbl: UILabel?
    
    private var pincode: Pincode?
    private var confirmPincode: Pincode?
    
    private var savedPin: String?
    
    public var delegate: AuthPinControllerDelegate?
    public var state: AuthPinState = .setPin {
        didSet { setupPin() }
    }
    
    // MARK: - Lifecycle
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupConfirmStack()
    }
    
    // MARK: - Private
    
    private func setupPin() {
        pincode = Pincode(with: 4)
        pincode?.didFinishedEnterPin = { [weak self] code in
            guard let `self` = self else { return }
            print("Pincode is: \(code)")
            switch self.state {
            case .confirmPin(let savedPin):
                self.savedPin = savedPin
                self.pinVerification()
            case .setPin:
                self.setupConfirmPin()
            }
        }
    }
    
    private func setupConfirmPin() {
        confirmPincode = Pincode(with: 4)
        confirmPincode?.didFinishedEnterPin = { code in
            print("Confirm Pincode is: \(code)")
            self.pinVerification()
        }
    }
    
    private func redraw(_ dots: [UIImageView], with colors: [UIColor]) {
        guard colors.count == dots.count else { return }
        dots.enumerated().forEach({ (index, element) in
            element.tintColor = colors[index]
        })
    }
    
    private func setupConfirmStack() {
        switch state {
        case .setPin:
            titleLabel.text = "Введите PIN"
        case .confirmPin:
            titleLabel.text = "Повторите PIN"
        }
    }
    
    private func catchError(msg: String) {
        errorLbl?.text = msg
        errorLbl?.isHidden = false
        pincode?.removeAllText()
        confirmPincode?.removeAllText()
    }
    
    // MARK: - Actions
    
    @IBAction func touchNumberBtn(_ sender: UIButton) {
        errorLbl?.isHidden = true
        if let pincode = pincode, !pincode.isCodeFill() {
            pincode.insertText("\(sender.tag)")
        } else if let confirmPincode = confirmPincode, !confirmPincode.isCodeFill() {
            confirmPincode.insertText("\(sender.tag)")
        }
        pincodeView.fillNextDot(animated: true)
    }
    
    @IBAction func touchRemoveBtn(_ sender: Any) {
        switch state {
        case .setPin:
            pincode?.removeText()
        case .confirmPin:
            confirmPincode?.removeText()
        }
        pincodeView.emptyLastDot(animated: true)
    }
    
    private func pinVerification() {
        switch state {
        case .setPin:
            guard pincode?.code == confirmPincode?.code,
                let newPin = pincode?.code else {
                catchError(msg: "Несоответствие PIN кодов")
                return
            }
            delegate?.didSetNewPin(newPin)
        case .confirmPin:
            if let pincode = pincode, pincode.isCodeFill() {
                if let savedPin = savedPin,
                    savedPin == pincode.code {
                    delegate?.didSuccessSignIn()
                } else {
                    catchError(msg: "Неверный PIN код")
                }
            }
        }
    }
    
}


