//
//  YBAlertView.swift
//  FXAlertController
//
//  Created by dev on 5/18/16.
//  Copyright © 2016 zfx5130. All rights reserved.
//

import UIKit

class YBActionTableViewCell: UITableViewCell {
    
    let defaultImageViewSize = 24 as CGFloat
    let defaultImageViewLeftPadding = 16 as CGFloat
    let defaultImageViewTopPadding = 13 as CGFloat

    private lazy var leftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .Center
        imageView.userInteractionEnabled = false
        return imageView
    }()
    
    private lazy var actionButton: UIButton = {
        let button = UIButton(type: .System)
        let color = UIColor(red: 59 / 255.0, green: 80 / 255.0, blue: 105 / 255.0, alpha: 1.0)
        button.setTitleColor(color, forState: .Normal)
        button.backgroundColor = UIColor.clearColor()
        button.userInteractionEnabled = false
        button.titleLabel?.font = UIFont.boldSystemFontOfSize(14)
        return button
    }()
    
    private lazy var bottomLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 229 / 255.0, green: 234 / 255.0, blue: 240 / 255.0, alpha: 1.0)
        return view
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.clearColor()
        setupActionButton()
        setupLeftImageView()
        setupBottonLineView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK - Private
    
    private func setupActionButton() {
        addSubview(actionButton)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: actionButton,
                           attribute: .Leading,
                           relatedBy: .Equal,
                           toItem: self,
                           attribute: .Leading,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
        NSLayoutConstraint(item: actionButton,
                           attribute: .Trailing,
                           relatedBy: .Equal,
                           toItem: self,
                           attribute: .Trailing,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
        NSLayoutConstraint(item: actionButton,
                           attribute: .Top,
                           relatedBy: .Equal,
                           toItem: self,
                           attribute: .Top,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
        NSLayoutConstraint(item: actionButton,
                           attribute: .Bottom,
                           relatedBy: .Equal,
                           toItem: self,
                           attribute: .Bottom,
                           multiplier: 1.0,
                           constant: 0.0).active = true
    }
    
    private func setupLeftImageView() {
        
        insertSubview(leftImageView, aboveSubview: actionButton)
        leftImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: leftImageView,
                           attribute: .Leading,
                           relatedBy: .Equal,
                           toItem: self,
                           attribute: .Leading,
                           multiplier: 1.0,
                           constant: defaultImageViewLeftPadding).active = true
        
        NSLayoutConstraint(item: leftImageView,
                           attribute: .Width,
                           relatedBy: .Equal,
                           toItem: nil,
                           attribute: .NotAnAttribute,
                           multiplier: 1.0,
                           constant: defaultImageViewSize).active = true
        
        NSLayoutConstraint(item: leftImageView,
                           attribute: .Height,
                           relatedBy: .Equal,
                           toItem: nil,
                           attribute: .NotAnAttribute,
                           multiplier: 1.0,
                           constant: defaultImageViewSize).active = true
        
        NSLayoutConstraint(item: leftImageView,
                           attribute: .CenterY,
                           relatedBy: .Equal,
                           toItem: self,
                           attribute: .CenterY,
                           multiplier: 1.0,
                           constant: 0.0).active = true
    }
    
    private func setupBottonLineView() {
        
        addSubview(bottomLineView)
        bringSubviewToFront(bottomLineView)
        
        bottomLineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: bottomLineView,
                           attribute: .Leading,
                           relatedBy: .Equal,
                           toItem: self,
                           attribute: .Leading,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
        NSLayoutConstraint(item: bottomLineView,
                           attribute: .Trailing,
                           relatedBy: .Equal,
                           toItem: self,
                           attribute: .Trailing,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
        NSLayoutConstraint(item: bottomLineView,
                           attribute: .Bottom,
                           relatedBy: .Equal,
                           toItem: self,
                           attribute: .Bottom,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
        NSLayoutConstraint(item: bottomLineView,
                           attribute: .Height,
                           relatedBy: .Equal,
                           toItem: nil,
                           attribute: .NotAnAttribute,
                           multiplier: 1.0,
                           constant: 0.5).active = true
        
    }
}

class YBAlertView: UIView {

    let defaultHeight = ScreenSize.Height as CGFloat
    let defaultHeadViewHeight = 50 as CGFloat
    let defaultLabelHeight = 20 as CGFloat
    let defaultLabelPadding = 20 as CGFloat
    let defaultLabelTopPadding = 15 as CGFloat
    let defaultSingleLabelTopPadding = 15 as CGFloat
    let defaultBottomViewHeight = 60 as CGFloat
    let defaultCancelButtonPadding = 10 as CGFloat
    let defaultActionButtonHeight = 50 as CGFloat
    let defaultActionButtonPadding = 10 as CGFloat
    
    private var headViewHeightConstraint: NSLayoutConstraint!
    private var alertViewHeightConstraint: NSLayoutConstraint!
    private var titleLabelHeightConstraint: NSLayoutConstraint!
    private var messageLabelHeightConstraint: NSLayoutConstraint!
    private var bottomViewHeightConstraint: NSLayoutConstraint!
    
    var viewController: YBAlertController!
    private var title: String?
    private var message: String?
    private var cancelHandler: Handler!
    private var actions: [YBAlertAction] = []
    private var actionStyle: YBAlertActionStyle = .Default
    
    //MARK - Laz
    
    private lazy var headView: UIView = {
        return UIView()
    }()
    
    private lazy var centerView: UIView = {
        return UIView()
    }()
    
    private lazy var shadowLayer: CALayer = {
        return CALayer()
    }()
    
    private lazy var bottomView: UIView = {
        return UIView()
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        return UIImageView()
    }()
    
    private lazy var actionBackgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .ScaleToFill
        return imageView
    }()
    
    private lazy var actionTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .None
        tableView.delegate = self
        tableView.dataSource = self
        tableView.scrollEnabled = false
        tableView.layer.cornerRadius = 2
        tableView.layer.borderColor = UIColor(red: 202 / 255.0, green: 211 / 255.0, blue: 221 / 255.0, alpha: 1.0).CGColor
        tableView.layer.borderWidth = 0.5
        tableView.layer.masksToBounds = true
        tableView.registerClass(YBActionTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(YBActionTableViewCell.self))
        return tableView
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .System)
        let color = UIColor(red: 59 / 255.0, green: 80 / 255.0, blue: 105 / 255.0, alpha: 1.0)
        button.setTitleColor(color, forState: .Normal)
        button.layer.cornerRadius = 2
        button.layer.borderColor = UIColor(red: 202 / 255.0, green: 211 / 255.0, blue: 221 / 255.0, alpha: 1.0).CGColor
        button.layer.borderWidth = 0.5
        button.backgroundColor = UIColor.whiteColor()
        button.titleLabel?.font = UIFont.boldSystemFontOfSize(14)
        return button
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
    
    //MARK - Public
    
    internal func addAction(action: YBAlertAction) {
        switch action.style {
        case .Default:
            setupDefaultAlertAction(action)
        case .Cancel:
            setupCancelAlertAction(action)
        case .Destructive:
            setupDefaultAlertAction(action)
        }
    }
    
    //MARK - Private
    
    private func setupDefaultAlertAction(action: YBAlertAction) {
        addSubview(centerView)
        actions.append(action)
        centerView.addSubview(actionTableView)
        centerView.insertSubview(actionBackgroundImageView, belowSubview: actionTableView)
        setupCenterViewConstraints()
    }
    
    private func setupCancelAlertAction(action: YBAlertAction) {
        updateBottomViewConstraints()
        setupBottomCancelButton(action)
    }
    
    private func setupView() {
        initialize()
        setupBackgroundImageView()
        setupHeadView()
        addSubview(bottomView)
        setupBottomViewConstraints()
    }
    
    private func initialize() {
        backgroundColor = UIColor.clearColor()
        frame = CGRect(x: 0,
                       y: ScreenSize.Height - defaultHeight,
                       width: ScreenSize.Width,
                       height: defaultHeight)
        setupAlertViewConstraints()
    }
    
    private func setupBottomCancelButton(action: YBAlertAction) {
        cancelButton.setTitle(action.title, forState: .Normal)
        cancelButton.addTarget(self,
                               action: #selector(cancelButtonWasPressed),
                               forControlEvents: .TouchUpInside)
        cancelHandler = action.handler
        bottomView.addSubview(cancelButton)
        setupButtonInnerShadow(cancelButton)
        setupCancelButtonConstraints()
    }
    
    private func setupButtonInnerShadow(button: UIButton) {
        shadowLayer.frame = CGRect(x: 0,
                                   y: 0,
                                   width: ScreenSize.Width - 20,
                                   height: defaultBottomViewHeight - 20)
        shadowLayer.masksToBounds = false
        shadowLayer.shadowColor = UIColor.blackColor().CGColor
        shadowLayer.shadowOffset = CGSize(width: 0, height: 1)
        shadowLayer.shadowRadius = 2
        shadowLayer.shadowOpacity = 0.06
        button.layer.insertSublayer(shadowLayer, atIndex: 0)
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
    
    private func setupCenterViewConstraints() {
        
        centerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: centerView,
                           attribute: .Leading,
                           relatedBy: .Equal,
                           toItem: self,
                           attribute: .Leading,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
        NSLayoutConstraint(item: centerView,
                           attribute: .Trailing,
                           relatedBy: .Equal,
                           toItem: self,
                           attribute: .Trailing,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
        NSLayoutConstraint(item: centerView,
                           attribute: .Top,
                           relatedBy: .Equal,
                           toItem: headView,
                           attribute: .Bottom,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
        NSLayoutConstraint(item: centerView,
                           attribute: .Bottom,
                           relatedBy: .Equal,
                           toItem: bottomView,
                           attribute: .Top,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
        actionTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: actionTableView,
                           attribute: .Leading,
                           relatedBy: .Equal,
                           toItem: centerView,
                           attribute: .Leading,
                           multiplier: 1.0,
                           constant: defaultActionButtonPadding).active = true
        
        NSLayoutConstraint(item: actionTableView,
                           attribute: .Trailing,
                           relatedBy: .Equal,
                           toItem: centerView,
                           attribute: .Trailing,
                           multiplier: 1.0,
                           constant: -defaultActionButtonPadding).active = true
        
        NSLayoutConstraint(item: actionTableView,
                           attribute: .Top,
                           relatedBy: .Equal,
                           toItem: centerView,
                           attribute: .Top,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
        NSLayoutConstraint(item: actionTableView,
                           attribute: .Bottom,
                           relatedBy: .Equal,
                           toItem: centerView,
                           attribute: .Bottom,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
        actionBackgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: actionBackgroundImageView,
                           attribute: .Leading,
                           relatedBy: .Equal,
                           toItem: centerView,
                           attribute: .Leading,
                           multiplier: 1.0,
                           constant: defaultActionButtonPadding).active = true
        
        NSLayoutConstraint(item: actionBackgroundImageView,
                           attribute: .Trailing,
                           relatedBy: .Equal,
                           toItem: centerView,
                           attribute: .Trailing,
                           multiplier: 1.0,
                           constant: -defaultActionButtonPadding).active = true
        
        NSLayoutConstraint(item: actionBackgroundImageView,
                           attribute: .Top,
                           relatedBy: .Equal,
                           toItem: centerView,
                           attribute: .Top,
                           multiplier: 1.0,
                           constant: 0).active = true
        
        NSLayoutConstraint(item: actionBackgroundImageView,
                           attribute: .Bottom,
                           relatedBy: .Equal,
                           toItem: centerView,
                           attribute: .Bottom,
                           multiplier: 1.0,
                           constant: 0).active = true
        
        alertViewHeightConstraint.constant =
            alertViewHeightConstraint.constant + defaultActionButtonHeight
        
    }
    
    private func setupCancelButtonConstraints() {
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: cancelButton,
                           attribute: .Leading,
                           relatedBy: .Equal,
                           toItem: bottomView,
                           attribute: .Leading,
                           multiplier: 1.0,
                           constant: defaultCancelButtonPadding).active = true
        
        NSLayoutConstraint(item: cancelButton,
                           attribute: .Trailing,
                           relatedBy: .Equal,
                           toItem: bottomView,
                           attribute: .Trailing,
                           multiplier: 1.0,
                           constant: -defaultCancelButtonPadding).active = true
        
        NSLayoutConstraint(item: cancelButton,
                           attribute: .Top,
                           relatedBy: .Equal,
                           toItem:bottomView,
                           attribute: .Top,
                           multiplier: 1.0,
                           constant: defaultCancelButtonPadding).active = true

        NSLayoutConstraint(item: cancelButton,
                           attribute: .Bottom,
                           relatedBy: .Equal,
                           toItem: bottomView,
                           attribute: .Bottom,
                           multiplier: 1.0,
                           constant: -defaultCancelButtonPadding).active = true
        
    }
    
    private func updateBottomViewConstraints() {
        bottomViewHeightConstraint.constant = defaultBottomViewHeight
        alertViewHeightConstraint.constant = alertViewHeightConstraint.constant + bottomViewHeightConstraint.constant - defaultCancelButtonPadding
    }
    
    private func setupBottomViewConstraints() {
        
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: bottomView,
                           attribute: .Trailing,
                           relatedBy: .Equal,
                           toItem: self,
                           attribute: .Trailing,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
        NSLayoutConstraint(item: bottomView,
                           attribute: .Leading,
                           relatedBy: .Equal,
                           toItem: self,
                           attribute: .Leading,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
        NSLayoutConstraint(item: bottomView,
                           attribute: .Bottom,
                           relatedBy: .Equal,
                           toItem: self,
                           attribute: .Bottom,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
       bottomViewHeightConstraint = NSLayoutConstraint(item: bottomView,
                                                       attribute: .Height,
                                                       relatedBy: .Equal,
                                                       toItem: nil,
                                                       attribute: .NotAnAttribute,
                                                       multiplier: 1.0,
                                                       constant: defaultCancelButtonPadding)
        bottomViewHeightConstraint.active = true
        alertViewHeightConstraint.constant = alertViewHeightConstraint.constant + defaultCancelButtonPadding
        
    }
    
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

//MARK - Handlers

extension YBAlertView {
    
    @objc private func cancelButtonWasPressed(sender: UIButton) {
        dismiss()
    }
    
    private func dismiss() {
        guard cancelHandler != nil else {
            return
        }
        cancelHandler()

        if viewController != nil {
            viewController.dismissViewControllerAnimated(true, completion:nil)
        }
    }
    
}

//MARK - UITableViewDelegate

extension YBAlertView: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        cancelHandler = actions[indexPath.row].handler
        dismiss()
    }
}

//MARK - UITableViewDelegate

extension YBAlertView: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actions.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return defaultActionButtonHeight
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(NSStringFromClass(YBActionTableViewCell.self), forIndexPath: indexPath) as! YBActionTableViewCell
        let action = actions[indexPath.row]
        cell.actionButton.setTitle(action.title, forState: .Normal)
        if action.style == .Destructive {
            let color = UIColor(red: 237 / 255.0, green: 71 / 255.0, blue: 66 / 255.0, alpha: 1.0)
            cell.actionButton.setTitleColor(color, forState: .Normal)
        }
        cell.bottomLineView.hidden = (indexPath.row == actions.count - 1)
        cell.leftImageView.image = action.leftImage
        return cell
    }
    
}