//
//  ModalPresentationController.swift
//  Jumpit
//
//  Created by 정민지 on 5/17/24.
//

import UIKit
import Then
import SnapKit

class ModalPresentationController: UIPresentationController {
    // MARK: - Properties
    private lazy var backgroundView = UIView().then {
        $0.backgroundColor = UIColor.black.withAlphaComponent(0.55)
    }
    
    // MARK: -frameOfPresentedViewInContainerView
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { return .zero }
        
        return CGRect(x: 0, y: containerView.bounds.height * (5/100), width: containerView.bounds.width, height: containerView.bounds.height * (95/100))
    }
    
    // MARK: -presentationTransitionWillBegin
    override func presentationTransitionWillBegin() {
        guard let containerView = containerView else { return }
        
        containerView.addSubview(backgroundView)
        backgroundView.frame = containerView.bounds
        backgroundView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // MARK: -Add tapGesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissController))
        backgroundView.addGestureRecognizer(tapGesture)
        
        if let coordinator = presentedViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { _ in
                self.backgroundView.alpha = 1.0
            })
        } else {
            backgroundView.alpha = 1.0
        }
    }
    
    @objc private func dismissController() {
        presentedViewController.dismiss(animated: true)
    }
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        presentedView?.roundCorners([.topLeft, .topRight], radius: 30)
    }
}

// MARK: -roundCorners
extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

