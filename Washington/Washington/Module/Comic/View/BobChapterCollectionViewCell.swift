//
//  BobChapterCollectionViewCell.swift
//  Washington
//
//  Created by bob on 2021/5/16.
//

import UIKit

protocol BobChapterCollectionViewCellDelegate: class {
    func collectionViewCellEditClick(_ cell: BobChapterCollectionViewCell)
}

class BobChapterCollectionViewCell: UICollectionViewCell {
    public var delegate: BobChapterCollectionViewCellDelegate?
    public var model: ContentListModel? {
        didSet {
            guard let m = model else  {
                return
            }
            
            containerView.model = m
        }
    }
    
    lazy var containerView: BobChapterContainerView = {
        let view = BobChapterContainerView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    @objc
    func editClick() {
        delegate?.collectionViewCellEditClick(self)
    }
}
