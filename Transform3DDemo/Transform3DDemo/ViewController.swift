//
//  ViewController.swift
//  Transform3DDemo
//
//  Created by Parsifal on 2017/2/16.
//  Copyright © 2017年 Parsifal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var rotatedView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func zRotate(_ sender: UIButton) {
        var trans = CATransform3DIdentity
        trans.m34 = -1/500
        rotatedView.layer.transform = CATransform3DRotate(trans, CGFloat(M_PI_4), 0, 0, 1)
    }
    
    @IBAction func yRotate(_ sender: UIButton) {
        var trans = CATransform3DIdentity
        trans.m34 = -1/500
        rotatedView.layer.transform = CATransform3DRotate(trans, CGFloat(M_PI_4), 0, 1, 0)
    }
    
    @IBAction func xRotate(_ sender: UIButton) {
        var trans = CATransform3DIdentity
        trans.m34 = -1/500
        rotatedView.layer.transform = CATransform3DRotate(trans, CGFloat(M_PI_4), 1, 0, 0)
    }
    
}

