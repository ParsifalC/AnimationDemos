//
//  CPKeezyView.swift
//  KeezyButtonDemo
//
//  Created by Parsifal on 2017/1/24.
//  Copyright © 2017年 Parsifal. All rights reserved.
//

import UIKit

public enum CPKeezyViewState {
    case normal
    case animating
    case zoomed
}

open class CPKeezyView: UIView {
    var touchStartTime: NSDate = NSDate()
    var isAnimating: Bool = false
    var state: CPKeezyViewState = .normal
    let zoomInKey = "zoomin"
    let zoomOutKey = "zoomout"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func startAnimations() {
        print("beforestart:\(state)")
        if state == .animating {
            return
        }
        
        let scaleAnimation = CABasicAnimation.init(keyPath: "transform.scale")
        scaleAnimation.fromValue = 1.0
        scaleAnimation.toValue = 8.0
        scaleAnimation.isRemovedOnCompletion = false
        scaleAnimation.fillMode = kCAFillModeForwards
        scaleAnimation.duration = 0.5
        layer.add(scaleAnimation, forKey: zoomInKey)
        touchStartTime = NSDate()
        state = .animating
        print("afterstart:\(state)")
    }
    
    func endAnimations() {
        print("beforeend:\(state)")
        switch state {
        case .animating:
            let touchDuration = fabs(touchStartTime.timeIntervalSinceNow)
            if touchDuration<0.25 {
                let currentScale = layer.presentation()?.value(forKeyPath: "transform.scale")
                layer.removeAllAnimations()
                let scaleAnimation = zoomoutAnimation(fromValue: currentScale,
                                                      toValue: 1)
                layer.add(scaleAnimation, forKey: zoomOutKey)
                state = .normal
            } else {
                state = .zoomed
            }
        case .zoomed:
            layer.removeAllAnimations()
            layer.add(zoomoutAnimation(fromValue: 8, toValue: 1), forKey: zoomOutKey)
            state = .normal
        default:
            break
        }
        print("afterend:\(state)")
    }
    
    func zoomoutAnimation(fromValue: Any?, toValue: Any?) -> CAAnimation{
        let scaleAnimation = CABasicAnimation.init(keyPath: "transform.scale")
        scaleAnimation.fromValue = fromValue
        scaleAnimation.toValue = toValue
        scaleAnimation.isRemovedOnCompletion = true
        scaleAnimation.fillMode = kCAFillModeRemoved
        scaleAnimation.duration = 0.5
        return scaleAnimation
    }
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if state == .zoomed {
            endAnimations()
        } else {
            startAnimations()
        }
    }
    
    override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        endAnimations()
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        endAnimations()
    }
    
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if state != .zoomed {
            return super.hitTest(point, with: event)
        }
        return self
    }
}
