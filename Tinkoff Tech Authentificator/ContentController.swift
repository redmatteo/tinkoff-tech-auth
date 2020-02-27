//
//  ContentController.swift
//  Tinkoff Tech Authentificator
//
//  Created by Mikhail on 19.02.2020.
//  Copyright © 2020 Tinkoff Courses. All rights reserved.
//

import UIKit
import AuthManager
import AuthPinScreen

class ContentController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func touchUpLogout(_ sender: Any) {
        guard let root = navigationController as? RootAppController else { return }
        root.dismissContent()
    }
}

class AuthPin: AuthPinController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAuthPinController()
    }
    
    func setupAuthPinController() {
        let authPinBundle = Bundle(for: AuthPinController.self)
        if let authPinController = authPinBundle.loadNibNamed("AuthPinController", owner: self, options: nil)?.first as? AuthPinController {
            navigationController?.pushViewController(authPinController, animated: false)
        }
    }
    
}
