//
//  YBAlertAction.swift
//  FXAlertController
//
//  Created by dev on 5/19/16.
//  Copyright © 2016 zfx5130. All rights reserved.
//

import UIKit

public enum YBAlertActionStyle : Int {
    case Default
    case Cancel
}

typealias Handler = () -> Void

class YBAlertAction: NSObject {

    var title: String?
    var style: YBAlertActionStyle = YBAlertActionStyle.Default
    var handler: Handler?
    var leftImage: UIImage?
    
    internal convenience init(title: String?, style: YBAlertActionStyle, leftImage: UIImage?, handler: Handler?) {
        self.init()
        self.title = title
        self.style = style
        self.handler = handler
        self.leftImage = leftImage
    }
}
