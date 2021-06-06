//
//  BobBaseTableViewCell.swift
//  Washington
//
//  Created by Bob on 2021/10/24.
//  Copyright © 2021年 None. All rights reserved.
//

import UIKit
import Reusable

class BobBaseTableViewCell: UITableViewCell, Reusable {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func configUI() {}

}

