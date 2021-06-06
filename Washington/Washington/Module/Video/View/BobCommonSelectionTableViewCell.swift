//
//  BobCommonSelectionTableViewCell.swift
//  Washington
//
//  Created by bob on 2021/6/6.
//

import UIKit

class BobCommonSelectionTableViewCell: BobBaseTableViewCell {
    lazy var selectImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "video_select_on"))
        return view
    }()
    
    lazy var masksView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.7)
        return view
    }()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                addSelectStyle()
            } else {
                removeSelectStyle()
            }
        }
    }
    
    private func addSelectStyle() {
        if masksView.superview == nil {
            addSubview(masksView)
            masksView.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
        }
        
        if selectImageView.superview == nil {
            addSubview(selectImageView)
            selectImageView.snp.makeConstraints { (make) in
                make.size.equalTo(CGSize(width: 50, height: 50))
                make.center.equalToSuperview()
            }
        }
    }
    
    
    private func removeSelectStyle() {
        masksView.removeFromSuperview()
        selectImageView.removeFromSuperview()
    }
}
