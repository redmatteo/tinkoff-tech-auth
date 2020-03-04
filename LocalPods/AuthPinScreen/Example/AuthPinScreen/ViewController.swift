//
//  ViewController.swift
//  AuthPinScreen
//
//  Created by mikhail on 02/19/2020.
//  Copyright (c) 2020 mikhail. All rights reserved.
//

import UIKit
import AuthPinScreen

class ViewController: UIViewController, AuthPinControllerDelegate {

    let testPin = "1111"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAuthPinController()
    }
    
    func setupAuthPinController() {
//        let bundle = Bundle(for: TestViewController.self)
        
//        let bundle = Bundle(for: AuthPinController.self)
//        let controller = AuthPinController(nibName: "AuthPinController", bundle: bundle)
        
        let controller = AuthPinController(nibName: "AuthPinController", bundle: nil)
        
        //1
//        guard let controller = bundle.loadNibNamed("TestViewController", owner: nil, options: nil)?.first as? TestViewController  else { return }
        
        //2
//        let controller = TestViewController(nibName: "TestViewController", bundle: bundle)
        
//        guard let controller = AuthPinController.new(with: self) else { return }
//        controller.state = .setPin
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
    //if state is setPin
    func didSetNewPin(_ pin: String) {
        print("Success set new PIN = \(pin)")
    }
    
    //if state is confirmPin
    func didSuccessSignIn() {
        print("Success Sign in")
    }
    
}

