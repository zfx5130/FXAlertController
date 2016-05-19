//
//  ViewController.swift
//  FXAlertController
//
//  Created by dev on 5/18/16.
//  Copyright © 2016 zfx5130. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func alertButtonWasPressed(sender: UIButton) {
        let alertController = YBAlertController(title: nil, message: nil)
        presentViewController(alertController, animated: true, completion: nil)
    }
}

