//
//  ContentController.swift
//  Tinkoff Tech Authentificator
//
//  Created by Mikhail on 19.02.2020.
//  Copyright © 2020 Tinkoff Courses. All rights reserved.
//

import UIKit
import AuthManager

class ContentController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        AuthManager.authentificate()
        // Do any additional setup after loading the view.
    }


}

