//
//  AuthPinController.swift
//  AuthPinScreen
//
//  Created by Maria on 23.02.2020.
//

import UIKit

@available(iOS 9.0, *)
open class AuthPinController: UIViewController {
    
    @IBOutlet weak var setPinStackView: UIStackView!
    @IBOutlet var pinBtns: [UIButton]!

    override open func viewDidLoad() {
        super.viewDidLoad()

    }
    
    public func createAuthPinController() -> AuthPinController? {
        let authPinBundle = Bundle(for: AuthPinController.self)
        if let authPinController = authPinBundle.loadNibNamed("AuthPinController", owner: self, options: nil)?.first as? AuthPinController {
            return authPinController
        }
        return nil
    }
    
    @IBAction func touchBackBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func touchSignInBtn(_ sender: Any) {
    
    }
}

class Pincode {
    var code = ""
    var maxLenth = 4
}
