//
//  BobRecommendViewController.swift
//  Washington
//
//  Created by chenxingchen on 2021/6/15.
//

import UIKit

class BobRecommendViewController: BobPageViewController {

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
