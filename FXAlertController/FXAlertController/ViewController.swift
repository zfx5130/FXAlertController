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
        
        let cancleAction = YBAlertAction(title: "取消", style: .Cancel, leftImage: nil) {
            print("取消 按钮")
        }
        let photoImage = UIImage(named: "action_sheet_creama_image_icon")
        let photoAction = YBAlertAction(title: "相机拍摄", style: .Default, leftImage: photoImage) {
            print("相机拍摄")
        }
        let pictureImage = UIImage(named: "action_sheet_photo_image_icon")
        let pictureAction = YBAlertAction(title: "从相册选一张", style: .Default, leftImage: pictureImage) {
            print("从相册选一张")
        }

        let routeImage = UIImage(named: "action_sheet_line_image_icon")
        let routeAction = YBAlertAction(title: "使用沿途照片", style: .Default, leftImage: routeImage) {
            print("使用沿途照片")
        }
        
        alertController.addAction(cancleAction)
        alertController.addAction(photoAction)
        alertController.addAction(pictureAction)
        alertController.addAction(routeAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
}

