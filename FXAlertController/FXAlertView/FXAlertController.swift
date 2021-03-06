//
//  FXAlertController.swift
//  FXAlertController
//
//  Created by dev on 5/18/16.
//  Copyright © 2016 zfx5130. All rights reserved.
//

import UIKit

struct ScreenSize {
    private static let ScreenBounds = UIScreen.mainScreen().bounds
    static let Width = ScreenSize.ScreenBounds.width
    static let Height = ScreenSize.ScreenBounds.height
}

 //MARK: - FXAlertPresentSlideUp

class FXAlertPresentSlideUp: NSObject {
}

extension FXAlertPresentSlideUp: UIViewControllerAnimatedTransitioning {
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5;
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let destinationVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! FXAlertController
        let view = destinationVC.view
        let centerY = view.bounds.height + destinationVC.alertView.frame.size.height * 0.5
        destinationVC.backgroundView.alpha = 0;
        destinationVC.alertView.center = CGPoint(x: view.center.x, y: centerY)
        
        let containerView = transitionContext.containerView()
        containerView?.addSubview(destinationVC.view)
        let duration = transitionDuration(transitionContext)
        UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: {
            destinationVC.backgroundView.alpha = 0.4
            let height = destinationVC.alertView.frame.size.height
            destinationVC.alertView.frame = CGRect(x: 0, y: ScreenSize.Height - height, width: ScreenSize.Width, height: destinationVC.alertView.frame.size.height)
        }){ finished in
            transitionContext.completeTransition(true)
        }
    }
}

 //MARK: - FXAlertDismissSildeDown

class FXAlertDismissSildeDown: NSObject {
}

extension FXAlertDismissSildeDown: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.3;
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let originVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! FXAlertController
        let duration = transitionDuration(transitionContext)
        UIView.animateWithDuration(duration, animations: { 
            originVC.backgroundView.alpha = 0.0
            let view = originVC.view
            let centerY = view.bounds.height + originVC.alertView.frame.size.height / 2
            originVC.alertView.center = CGPoint(x: view.center.x, y: centerY)
            }) { finished in
                transitionContext.completeTransition(true)
        }
    }
}

 //MARK: - FXAlertController

class FXAlertController: UIViewController {
    
    var alertView: FXAlertView!
    
    private lazy var backgroundView: UIView = {
        let view = UIView(frame: self.view.bounds)
        view.backgroundColor = UIColor.blackColor()
        view.alpha = 0.4
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismiss))
        view.addGestureRecognizer(gesture)
        return view
    }()
    
    //MARK - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        setupBackgroundView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK - Public
    internal convenience init(title: String?, message: String?) {
        self.init()
        let alertView = FXAlertView(title: title, message: message)
        alertView.viewController = self
        self.alertView = alertView
        setupAlertView()
    }
    
    //MARK - add Action
    internal func addAction(action: FXAlertAction) {
        guard alertView != nil else {
            return
        }
        let customView: FXAlertView = alertView as FXAlertView
        customView.addAction(action)
    }
    
    //MARK - add Actions
    internal func addActions(actions: [FXAlertAction]) {
        for action in actions {
            addAction(action)
        }
    }
    
    //MARK - Private
    
    private func initialize() {
        transitioningDelegate = self
        modalPresentationStyle = .Custom
        view.backgroundColor = UIColor.clearColor()
    }
    
    private func setupBackgroundView() {
        view.addSubview(backgroundView)
    }
    
    private func setupAlertView() {
        view.addSubview(alertView)
        setupAlertViewConstraints()
    }
    
    private func setupAlertViewConstraints() {
        
        NSLayoutConstraint(item: alertView,
                           attribute: .Leading,
                           relatedBy: .Equal,
                           toItem: self.view,
                           attribute: .Leading,
                           multiplier: 1.0,
                           constant: 0.0).active = true

        NSLayoutConstraint(item: alertView,
                           attribute: .Bottom,
                           relatedBy: .Equal,
                           toItem: self.view,
                           attribute: .Bottom,
                           multiplier: 1.0,
                           constant: 0.0).active = true
        
        NSLayoutConstraint(item: alertView,
                           attribute: .Trailing,
                           relatedBy: .Equal,
                           toItem: self.view,
                           attribute: .Trailing,
                           multiplier: 1.0,
                           constant: 0.0).active = true
    }
    
}

extension FXAlertController: UIViewControllerTransitioningDelegate {
 
    //MARK - UIViewControllerTransitioningDelegate
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FXAlertPresentSlideUp()
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FXAlertDismissSildeDown()
    }
}

extension FXAlertController {
    
    //MARK - Handlers
    
    @objc func dismiss() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}