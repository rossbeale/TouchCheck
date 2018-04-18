//
//  TouchCheck.swift
//  TouchDemo
//
//  Created by Ross Beale on 18/04/2018.
//  Copyright © 2018 Airbyte Ltd. All rights reserved.
//

import UIKit

private struct TouchNode {
    
    let view: UIView
    let touchView: UIView
    
    let height = 39
    let width = 39
    
    init(view: UIView) {
        self.view = view
        
        self.touchView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        self.touchView.backgroundColor = UIColor.blue.withAlphaComponent(0.4)
        self.touchView.isUserInteractionEnabled = false
        self.touchView.center = view.center
    }
}

extension UIViewController {
    
    private func showControlSubviews() {
        // get all views
        let views = view.subviewsRecursive()
        let controlViews = views.filter { $0.isControl() }
        let controlNodes = controlViews.map { TouchNode(view: $0) }
        
        // find nodes
        for node in controlNodes {
            // add touch
            node.view.superview?.addSubview(node.touchView)
        }
        
        for node in controlNodes {
            // determine if touch node is too small
            var valid = true
            let klass = NSStringFromClass(type(of: node.view))
            
            if !["_UIButtonBarButton", "_UIModernBarButton"].contains(klass) {
                valid = valid && node.view.frame.contains(node.touchView.frame)
                
                if let touchViewWindowFrame0 = node.view.superview?.convert(node.view.frame, to: nil) {
                    valid = valid && !controlNodes.contains(where: {
                        if let touchViewWindowFrame1 = $0.view.superview?.convert($0.view.frame, to: nil) {
                            return $0.view != node.view && touchViewWindowFrame0.intersects(touchViewWindowFrame1)
                        }
                        
                        return false
                    })
                }
            }
            
            // add overlay
            let subview = UIView(frame: node.view.frame)
            subview.backgroundColor = valid ? UIColor.green.withAlphaComponent(0.3) : UIColor.red.withAlphaComponent(0.3)
            subview.isUserInteractionEnabled = false
            node.view.superview?.insertSubview(subview, aboveSubview: node.touchView)
        }
    }
    
}

private extension UIView {
    
    func isControl() -> Bool {
        return self is UIControl || self.gestureRecognizers?.count ?? 0 == 1
    }
    
    func subviewsRecursive() -> [UIView] {
        return subviews + subviews.flatMap { $0.subviewsRecursive() }
    }
    
}

private let swizzling: (AnyClass, Selector, Selector) -> () = { forClass, originalSelector, swizzledSelector in
    let originalMethod = class_getInstanceMethod(forClass, originalSelector)
    let swizzledMethod = class_getInstanceMethod(forClass, swizzledSelector)
    method_exchangeImplementations(originalMethod!, swizzledMethod!)
}

private extension UIViewController {
    
    static let classInit: Void = {
        let originalSelector = #selector(viewDidAppear(_:))
        let swizzledSelector = #selector(swizzled_viewDidAppear(animated:))
        swizzling(UIViewController.self, originalSelector, swizzledSelector)
    }()
    
    @objc func swizzled_viewDidAppear(animated: Bool) {
        swizzled_viewDidAppear(animated: animated)
        
        showControlSubviews()
    }
    
}

public final class TouchCheck: NSObject {
    
    /// Defines if and when TouchCheck should be enabled.
    ///
    /// - always:    TouchCheck is always enabled.
    /// - never:     TouchCheck is never enabled.
    /// - debugOnly: TouchCheck is enabled while the `DEBUG` flag is set and enabled.
    @objc public enum Enabled: Int {
        case always
        case never
        case debugOnly
    }
    
    @objc private static var enabled: TouchCheck.Enabled = .never
    
    static var shouldEnable: Bool {
        guard enabled != .never else { return false }
        guard enabled != .debugOnly else {
            #if DEBUG
            return true
            #else
            return false
            #endif
        }
        return true
    }
    
    static public func configure(enabled: TouchCheck.Enabled) {
        self.enabled = enabled
        
        if shouldEnable {
            UIViewController.classInit
        }
    }
    
}
