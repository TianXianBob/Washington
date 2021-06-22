//
//  BobBaseTableViewHeaderFooterView.swift
//  Washington
//
//  Created by Bob on 2021/11/10.
//  Copyright © 2021年 None. All rights reserved.
//

import UIKit
import Reusable

class BobBaseTableViewHeaderFooterView: UITableViewHeaderFooterView, Reusable {

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func configUI() {}

}

