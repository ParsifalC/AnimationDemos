//
//  ViewController.swift
//  TableViewReloadAnimationDemo
//
//  Created by Parsifal on 2017/2/22.
//  Copyright © 2017年 Parsifal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier = "UITableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func reloadBtnTapped(_ sender: UIButton) {
        tableView.reloadData()
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.backgroundColor = .yellow
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.2, delay: 0.2, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: .autoreverse, animations: {
            cell.transform = CGAffineTransform.init(scaleX: 0.6, y: 0.6)
        }) { (_) in
            cell.transform = CGAffineTransform.identity
        }
    }
    
}
