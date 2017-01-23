//
//  ViewController.swift
//  KeezyButtonDemo
//
//  Created by Parsifal on 2017/1/23.
//  Copyright © 2017年 Parsifal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var rollBtn: CPScalableButton!
    @IBOutlet weak var touchedBtn: CPScalableButton!
    let pathRadius:CGFloat = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // demo for the keezy button
    }
    
    @IBAction func animate(_ sender: UIButton) {
        let arcPath = UIBezierPath()
        arcPath.addArc(withCenter: CGPoint(x: rollBtn.center.x, y:rollBtn.center.y-pathRadius),
                       radius: pathRadius,
                       startAngle: CGFloat(M_PI_2),
                       endAngle: CGFloat(1.5*M_PI),
                       clockwise: true)
        
        let postionAnimation = CAKeyframeAnimation.init(keyPath: "position")
        postionAnimation.path = arcPath.cgPath
        postionAnimation.calculationMode = kCAAnimationCubic
        postionAnimation.timingFunction = nil
        
        let rotationAnimation = CABasicAnimation.init(keyPath: "transform.rotation.z")
        rotationAnimation.fromValue = 0
        rotationAnimation.toValue = M_PI
        
        let scaleAnimation = CABasicAnimation.init(keyPath: "transform.scale")
        scaleAnimation.fromValue = 1.0
        scaleAnimation.toValue = 10
        
        let opacityAnimation = CABasicAnimation.init(keyPath: "opacity")
        opacityAnimation.fromValue = 0.1
        opacityAnimation.toValue = 1.0
        
        let groupAniamtion = CAAnimationGroup()
        groupAniamtion.duration = 1
        groupAniamtion.repeatCount = 1
        groupAniamtion.autoreverses = false
        groupAniamtion.isRemovedOnCompletion = false
        groupAniamtion.fillMode = kCAFillModeForwards
        groupAniamtion.animations = [postionAnimation, rotationAnimation, scaleAnimation, opacityAnimation]
        self.rollBtn.layer.add(groupAniamtion, forKey: nil)
    }
}

