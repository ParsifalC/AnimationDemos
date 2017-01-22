//
//  ViewController.swift
//  LabelTransitionAnimations
//
//  Created by Parsifal on 2017/1/22.
//  Copyright © 2017年 Parsifal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!

    var animated:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func animate(_ sender: UIButton) {
        // top label --简易翻页效果
        let topCloneLabel = cloneLabel(topLabel)
        topCloneLabel.transform = CGAffineTransform.init(scaleX: 1, y: 0.1).concatenating(CGAffineTransform.init(translationX: 0, y: topCloneLabel.bounds.height/2))

        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: [.curveEaseOut],
                       animations: {
                        topCloneLabel.transform = CGAffineTransform.identity
                        self.topLabel.transform = CGAffineTransform.init(scaleX: 1, y: 0.1).translatedBy(x: 0, y: topCloneLabel.bounds.height/2)
                        self.topLabel.alpha = 0
        }) { (_) in
            self.topLabel.text = topCloneLabel.text
            self.topLabel.transform = CGAffineTransform.identity
            self.topLabel.alpha = 1
            topCloneLabel.removeFromSuperview()
        }
        
        // left label --左渐进
        let leftCloneLabel = cloneLabel(leftLabel)
        leftCloneLabel.alpha = 0
        leftCloneLabel.transform = CGAffineTransform.init(translationX: -leftCloneLabel.bounds.width,
                                                                     y: 0)
        UIView.animate(withDuration: 0.5,
                              delay: 0,
                            options: .curveEaseIn,
                         animations: {
                            leftCloneLabel.alpha = 1
                            leftCloneLabel.transform = CGAffineTransform.identity
                            self.leftLabel.transform =
                                CGAffineTransform.init(translationX: -leftCloneLabel.bounds.width,
                                                                  y: 0)
                            self.leftLabel.alpha = 0
        }) { (_) in
            self.leftLabel.text = leftCloneLabel.text
            self.leftLabel.transform = CGAffineTransform.identity
            self.leftLabel.alpha = 1
            leftCloneLabel.removeFromSuperview()
        }
        
        // right label --旋转
        let rightCloneLabel = cloneLabel(rightLabel)
        rightCloneLabel.transform = CGAffineTransform.init(rotationAngle: CGFloat(M_PI))
        rightCloneLabel.alpha = 0
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: [],
                       animations: {
                        rightCloneLabel.transform = CGAffineTransform.identity
                        rightCloneLabel.alpha = 1
                        self.rightLabel.alpha = 0
                        self.rightLabel.transform = CGAffineTransform.init(rotationAngle: CGFloat(M_PI))
        }) { (_) in
            self.rightLabel.transform = CGAffineTransform.identity
            self.rightLabel.text = rightCloneLabel.text
            self.rightLabel.alpha = 1
            rightCloneLabel.removeFromSuperview()
        }
        
        // bottom label --缩放
        let bottomCloneLabel = cloneLabel(bottomLabel)
        bottomCloneLabel.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
        bottomCloneLabel.alpha = 0
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: [],
                       animations: { 
                        bottomCloneLabel.transform = CGAffineTransform.identity
                        bottomCloneLabel.alpha = 1
                        self.bottomLabel.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
                        self.bottomLabel.alpha = 0
        }) { (_) in
            self.bottomLabel.text = bottomCloneLabel.text
            self.bottomLabel.alpha = 1
            self.bottomLabel.transform = CGAffineTransform.identity
            bottomCloneLabel.removeFromSuperview()
        }
        
        animated = !animated
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.4,
                       initialSpringVelocity: 0.8,
                       options: [],
                       animations: { 
                        sender.transform = CGAffineTransform.init(scaleX: 1.5, y: 1.5)
        }) { (_) in
            sender.transform = CGAffineTransform.identity
        }
        
    }
    
    func cloneLabel(_ fromLabel:UILabel) -> UILabel {
        let cloneLabel = UILabel(frame:fromLabel.frame)
        cloneLabel.font = fromLabel.font
        cloneLabel.textColor = fromLabel.textColor
        cloneLabel.textAlignment = fromLabel.textAlignment
        cloneLabel.backgroundColor = fromLabel.backgroundColor
        cloneLabel.text = animated ? "YOYO":"XOXO"
        view.addSubview(cloneLabel)
        return cloneLabel
    }
}

