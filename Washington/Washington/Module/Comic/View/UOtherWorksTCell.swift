//
//  UOtherWorksTCell.swift
//  Washington
//
//  Created by Bob on 2021/11/22.
//  Copyright © 2021年 None. All rights reserved.
//

import UIKit

class UOtherWorksTCell: BobBaseTableViewCell {

    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model: DetailStaticModel? {
        didSet{
            guard let model = model else { return }
            textLabel?.text = "其他作品"
            detailTextLabel?.text = "\(model.otherWorks?.count ?? 0)本"
            detailTextLabel?.font = UIFont.systemFont(ofSize: 15)
        }
    }
}

