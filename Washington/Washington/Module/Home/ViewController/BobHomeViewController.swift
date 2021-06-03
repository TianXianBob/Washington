//
//  BobHomeViewController.swift
//  Washington
//
//  Created by Bob on 2021/10/24.
//  Copyright © 2021年 None. All rights reserved.
//

import UIKit

class BobHomeViewController: BobPageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configNavigationBar() {
        super.configNavigationBar()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav_search"),
                                                            target: self,
                                                            action: #selector(selectAction))
    }
    
    @objc private func selectAction() {
        navigationController?.pushViewController(USearchViewController(), animated: true)
    }
}

