//
//  ViewController.swift
//  UIViewKit
//
//  Created by Nelmeris on 03/03/2020.
//  Copyright (c) 2020 Nelmeris. All rights reserved.
//

import UIKit
import UIViewKit

class ViewController: UIViewController {

    @IBOutlet weak var pincodeView: PincodeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clicked(_ sender: Any) {
        pincodeView.fillNextDot(animated: true)
    }

    @IBAction func removed(_ sender: Any) {
        pincodeView.emptyLastDot(animated: true)
    }
    
    @IBAction func empty(_ sender: Any) {
        pincodeView.emptyAllDots(animated: true)
    }
    
    @IBAction func randomColors(_ sender: Any) {
        pincodeView.emptyDotColor = .random()
        pincodeView.filledDotColor = .random()
    }
    
}


extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
}
