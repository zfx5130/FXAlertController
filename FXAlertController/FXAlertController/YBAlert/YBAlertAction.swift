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

typealias Handler = (action: YBAlertAction) -> Void

class YBAlertAction: NSObject {

    var title: String?
    var style: YBAlertActionStyle?
    var handler: Handler?
    
    internal convenience init(title: String?, style: YBAlertActionStyle?, image: UIImage, handler: Handler?) {
        self.init()
        self.title = title
        self.style = style
        self.handler = handler
    }
}
