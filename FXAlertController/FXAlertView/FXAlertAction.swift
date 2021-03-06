//
//  FXAlertAction.swift
//  FXAlertController
//
//  Created by dev on 5/19/16.
//  Copyright © 2016 zfx5130. All rights reserved.
//

import UIKit

public enum FXAlertActionStyle : Int {
    case Default
    case Cancel
    case Destructive
}

typealias Handler = () -> Void

class FXAlertAction: NSObject {

    var title: String?
    var style: FXAlertActionStyle = FXAlertActionStyle.Default
    var handler: Handler?
    var leftImage: UIImage?
    
    internal convenience init(title: String?, style: FXAlertActionStyle, leftImage: UIImage?, handler: Handler?) {
        self.init()
        self.title = title
        self.style = style
        self.handler = handler
        self.leftImage = leftImage
    }
}
