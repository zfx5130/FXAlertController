//
//  YBAlertView.swift
//  FXAlertController
//
//  Created by dev on 5/18/16.
//  Copyright © 2016 zfx5130. All rights reserved.
//

import UIKit

class YBAlertView: UIView {

    let defaultHeight = ScreenSize.Height as CGFloat
    let defaultHeadViewHeight = 50 as CGFloat
    let defaultLabelHeight = 20 as CGFloat
    let defaultLabelPadding = 20 as CGFloat
    let defaultLabelTopPadding = 15 as CGFloat
    let defaultSingleLabelTopPadding = 15 as CGFloat
    
    private var headViewHeightConstraint: NSLayoutConstraint!
    private var alertViewHeightConstraint: NSLayoutConstraint!
    private var titleLabelHeightConstraint: NSLayoutConstraint!
    private var messageLabelHeightConstraint: NSLayoutConstraint!
    
    private var title: String?
    private var message: String?
    
    //MARK - Laz
    
    private lazy var headView: UIView = {
        return UIView()
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        return UIImageView()
    }()
    
    private lazy var titleLabel: UILabel = {
        return UILabel()
    }()
    
    private lazy var messageLabel: UILabel = {
        return UILabel()
    }()
    
    private func setupLabelAttributes(label: UILabel, text: String?) {
        label.textAlignment = .Center
        label.font = UIFont.boldSystemFontOfSize(14)
        label.text = text
        label.numberOfLines = 0
        label.textColor = UIColor(red: 59 / 255.0, green: 80 / 255.0, blue: 105 / 255.0, alpha: 1.0)
    }
    
    //MARK - Lifecycle
    
    convenience init(title: String?, message: String?) {
        self.init()
        self.title = title
        self.message = message
        setupView()
    }
    
    //MARK - Private
    
    private func setupView() {
        initialize()
        setupBackgroundImageView()
        setupHeadView()
    }
    
    private func initialize() {
        backgroundColor = UIColor.clearColor()
        frame = CGRect(x: 0,
                       y: ScreenSize.Height - defaultHeight,
                       width: ScreenSize.Width,
                       height: defaultHeight)
        setupAlertViewConstraints()
    }
    
    private func setupBackgroundImageView() {
        backgroundImageView.image = UIImage(named: "Community_action_sheet_background_image")
        backgroundImageView.contentMode = .ScaleToFill
        addSubview(backgroundImageView)
        sendSubviewToBack(backgroundImageView)
        setupBackgroundImageViewConstraints()
    }
    
    private func setupHeadView() {
        addSubview(headView)
        setupHeadViewConstraints()
        setupHeadLabel()
    }

    private func setupHeadLabel() {
        headView.addSubview(titleLabel)
        headView.addSubview(messageLabel)
        setupLabelAttributes(titleLabel, text: title)
        setupLabelAttributes(messageLabel, text: message)
        setupHeadLabelConstraints()
        updateViewConstraint()
    }
    
    private func updateViewConstraint() {
        let titleLabelHeight = getLabelHeight(titleLabel)
        let messageLabelHeight = getLabelHeight(messageLabel)
        messageLabelHeightConstraint.constant = messageLabelHeight
        titleLabelHeightConstraint.constant = titleLabelHeight
        
        var labelPadding = defaultLabelTopPadding * 2
        if messageLabelHeight == 0 && titleLabelHeight == 0 {
            labelPadding = 10
        }
        headViewHeightConstraint.constant = messageLabelHeight + titleLabelHeight + labelPadding
        alertViewHeightConstraint.constant = headViewHeightConstraint.constant
    }
    
    private func getLabelHeight(label: UILabel) -> CGFloat {
        let width = ScreenSize.Width - defaultLabelHeight * 2
        let labelSize = label.sizeThatFits(CGSize(width: width, height: 0))
        let titleHeight = (labelSize.height / defaultLabelHeight + 1) * 2.5  + labelSize.height
        if label.text == nil {
            return 0
        }
        return titleHeight
    }
    
    //MARK - Constraint
    
    private func setupHeadLabelConstraints() {
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: titleLabel,
                           attribute: .Leading,
                           relatedBy: .Equal,
                           toItem: headView,
                           attribute: .Leading,
                           multiplier: 1.0,
                           constant: defaultLabelPadding).active = true
        
        NSLayoutConstraint(item: titleLabel,
                           attribute: .Trailing,
                           relatedBy: .Equal,
                           toItem: headView,
                           attribute: .Trailing,
                           multiplier: 1.0,
                           constant: -defaultLabelPadding).active = true
        
        NSLayoutConstraint(item: titleLabel,
                           attribute: .Top,
                           relatedBy: .Equal,
                           toItem: headView,
                           attribute: .Top,
                           multiplier: 1.0,
                           constant: defaultLabelTopPadding).active = true
        
        titleLabelHeightConstraint = NSLayoutConstraint(item: titleLabel,
                                                        attribute: .Height,
                                                        relatedBy: .Equal,
                                                        toItem: nil,
                                                        attribute: .NotAnAttribute,
                                                        multiplier: 1.0,
                                                        constant: defaultLabelHeight)
        titleLabelHeightConstraint.active = true
        
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: messageLabel,
                           attribute: .CenterX,
                           relatedBy: .Equal,
                           toItem: titleLabel,
                           attribute: .CenterX,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        NSLayoutConstraint(item: messageLabel,
                           attribute: .Width,
                           relatedBy: .Equal,
                           toItem: titleLabel,
                           attribute: .Width,
                           multiplier: 1.0,
                           constant: 0.0).active = true

//        NSLayoutConstraint(item: messageLabel,
//                           attribute: .Bottom,
//                           relatedBy: .Equal,
//                           toItem: headView,
//                           attribute: .Bottom,
//                           multiplier: 1.0,
//                           constant: -defaultLabelTopPadding).active = true
        
        NSLayoutConstraint(item: messageLabel,
                           attribute: .Top,
                           relatedBy: .Equal,
                           toItem: titleLabel,
                           attribute: .Bottom,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
        messageLabelHeightConstraint = NSLayoutConstraint(item: messageLabel,
                                                          attribute: .Height,
                                                          relatedBy: .Equal,
                                                          toItem: nil,
                                                          attribute: .NotAnAttribute,
                                                          multiplier: 1.0,
                                                          constant: defaultLabelHeight)
        messageLabelHeightConstraint.active = true
        
    }
    
    private func setupAlertViewConstraints() {
        
        self.translatesAutoresizingMaskIntoConstraints = false
       alertViewHeightConstraint = NSLayoutConstraint(item: self,
                                                      attribute: .Height,
                                                      relatedBy: .Equal,
                                                      toItem: nil,
                                                      attribute: .NotAnAttribute,
                                                      multiplier: 1.0,
                                                      constant: defaultHeight)
        alertViewHeightConstraint.active = true
    }
    
    private func setupHeadViewConstraints() {
        
        headView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: headView,
                           attribute: .Leading,
                           relatedBy: .Equal,
                           toItem: self,
                           attribute: .Leading,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
        NSLayoutConstraint(item: headView,
                           attribute: .Top,
                           relatedBy: .Equal,
                           toItem: self,
                           attribute: .Top,
                           multiplier: 1.0,
                           constant: 0.0).active = true

        NSLayoutConstraint(item: headView,
                           attribute: .Trailing,
                           relatedBy: .Equal,
                           toItem: self,
                           attribute: .Trailing,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
       headViewHeightConstraint = NSLayoutConstraint(item: headView,
                                                     attribute: .Height,
                                                     relatedBy: .Equal,
                                                     toItem: nil,
                                                     attribute: .NotAnAttribute,
                                                     multiplier: 1.0,
                                                     constant: defaultHeadViewHeight)
        headViewHeightConstraint.active = true
        
    }
    
    private func setupBackgroundImageViewConstraints() {
        
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: backgroundImageView,
                           attribute: .Leading,
                           relatedBy: .Equal,
                           toItem: self,
                           attribute: .Leading,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
        NSLayoutConstraint(item: backgroundImageView,
                           attribute: .Trailing,
                           relatedBy: .Equal,
                           toItem: self,
                           attribute: .Trailing,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
        NSLayoutConstraint(item: backgroundImageView,
                           attribute: .Top,
                           relatedBy: .Equal,
                           toItem: self,
                           attribute: .Top,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
        NSLayoutConstraint(item: backgroundImageView,
                           attribute: .Bottom,
                           relatedBy: .Equal,
                           toItem: self,
                           attribute: .Bottom,
                           multiplier: 1.0,
                           constant: 0.0).active = true
    }

}
