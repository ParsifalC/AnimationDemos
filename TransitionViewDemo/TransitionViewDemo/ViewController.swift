//
//  ViewController.swift
//  TransitionViewDemo
//
//  Created by Parsifal on 2017/1/22.
//  Copyright © 2017年 Parsifal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // animation tutorial 1
    let containerView:UIView = UIView()
    let newView:UIView = UIView()
    let tipLabel:UILabel = UILabel()
    var isShowing:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        containerView.frame = view.bounds
        view.addSubview(containerView)
        
        tipLabel.frame = CGRect(x:0, y:0, width:view.bounds.width, height:60)
        tipLabel.backgroundColor = .red
        tipLabel.textAlignment = .center
        tipLabel.text = "YO!What's up?"
        tipLabel.isHidden = true
        view.addSubview(tipLabel)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.view.sendSubview(toBack: self.containerView)
        // how to use
        // add new view
//        newView.frame = CGRect(x:containerView.bounds.width/2,
//                               y:containerView.bounds.height/2,
//                               width:50,
//                               height:50)
//        newView.backgroundColor = .red
//        UIView.transition(with: containerView,
//                          duration: 1,
//                          options: [.curveEaseInOut, .transitionFlipFromBottom],
//                          animations: { 
//                            self.containerView.addSubview(self.newView)
//        }, completion: { (_) in
//            // hide the view via transition
//            UIView.transition(with: self.newView,
//                              duration: 3,
//                              options: [.transitionFlipFromBottom],
//                              animations: { 
//                                self.newView.alpha = 0.5
//            }, completion: { (_) in
//                // remove new view
//                UIView.transition(with: self.containerView,
//                                  duration: 3,
//                                  options: [.curveEaseInOut, .transitionFlipFromTop],
//                                  animations: {
//                                    self.newView.alpha = 1
//                                    self.newView.removeFromSuperview()
//                }, completion: { (_) in
//                })
//            })
//        })
    }

    @IBAction func showMessage(_ sender: UIButton) {
        sender.isEnabled = false
        // transition animate & view animate practice
        if self.isShowing {
            UIView.transition(with: self.tipLabel,
                              duration: 0.3,
                              options: [.transitionCrossDissolve, .transitionFlipFromBottom],
                              animations: { 
                                self.tipLabel.isHidden = true
            }, completion: { (_) in
                sender.setTitle("display", for: .normal)
                self.isShowing = false
            })
        } else {
            UIView.transition(with: self.tipLabel,
                              duration: 0.3,
                              options: [.curveEaseInOut, .transitionFlipFromTop],
                              animations: { 
                                self.tipLabel.isHidden = false
            }, completion: { (_) in
                sender.setTitle("dismiss", for: .normal)
                self.isShowing = true
            })
        }
        
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0.6,
                       options: [.autoreverse],
                       animations: {
                        sender.transform = CGAffineTransform.init(scaleX: 1.2, y: 1.2)
        }, completion: { (_) in
            sender.isEnabled = true
        })
    }
}

