//
//  AuthPinController.swift
//  AuthPinScreen
//
//  Created by Maria on 23.02.2020.
//

import UIKit

public enum AuthPinState {
    case setPin // set new pin
    case confirmPin(_ savedPin: String) // sign in with pin
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
    @IBOutlet weak var errorLbl: UILabel?
    @IBOutlet weak var signInBtn: UIButton?
    
    private var pincode: Pincode?
    private var confirmPincode: Pincode?
    private var savedPin: String?
    
    public var delegate: AuthPinControllerDelegate?
    public var state: AuthPinState = .setPin {
        didSet {
            setupPin()
        }
    }
    
    // MARK: - Lifecycle
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        setupState()
        overrideUserInterfaceStyle = .light
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupConfirmStack()
    }
    
    // MARK: - Private func
    
    private func setupState() {
        guard let receivedState = delegate?.state else { return }
        state = receivedState
    }
    
    private func setupPin() {
        pincode = Pincode()
        pincode?.didChangePin = { [weak self] colors in
            guard let `self` = self, let dots = self.enterDots else { return }
            self.redraw(dots, with: colors)
        }
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
        confirmPincode = Pincode()
        confirmPincode?.didChangePin = { [weak self] colors in
            guard let `self` = self, let dots = self.confirmDots else { return }
            self.redraw(dots, with: colors)
        }
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
            confirmPinStack?.isHidden = false
        case .confirmPin:
            confirmPinStack?.isHidden = true
        }
    }
    
    private func configureSkipBtn() {
        
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
    }
    
    @IBAction func touchRemoveBtn(_ sender: Any) {
        if let confirmPincode = confirmPincode, confirmPincode.hasText {
            confirmPincode.removeText()
        } else if let pincode = pincode, pincode.hasText {
            pincode.removeText()
        }
    }
    
    private func pinVerification() {
        switch state {
        case .setPin:
            guard pincode?.code == confirmPincode?.code, let newPin = pincode?.code else {
                catchError(msg: "Несоответствие PIN кодов")
                return }
            delegate?.didSetNewPin(newPin)
        case .confirmPin:
            if let pincode = pincode, pincode.isCodeFill() {
                if let savedPin = savedPin, savedPin == pincode.code {
                    delegate?.didSuccessSignIn()
                } else {
                    catchError(msg: "Неверный PIN код")
                }
                
            }
        }
    }
    
    @IBAction func touchSkipBtn(_ sender: Any) {
        delegate?.didTouchSkipBtn()
    }
    
}


