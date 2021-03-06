//
//  BobBaseCollectionReusableView.swift
//  Washington
//
//  Created by Bob on 2021/10/31.
//  Copyright © 2021年 None. All rights reserved.
//

import UIKit
import Reusable

class BobBaseCollectionReusableView: UICollectionReusableView, Reusable {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func configUI() {}
}

