//
//  BobChapterContainerView.swift
//  Washington
//
//  Created by bob on 2021/5/16.
//

import UIKit

class BobChapterContainerView: UIView {
    public var model: ContentListModel? {
        didSet {
            guard let m = model else  {
                return
            }
            
            titleLb.text = m.iconName
            bgImageView.kf.setImage(urlString: m.iconUrl)
        }
    }
    
    lazy var bottomView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var titleLb: UILabel = {
        let lb = UILabel()
        lb.textColor = #colorLiteral(red: 0.1215686275, green: 0.137254902, blue: 0.1607843137, alpha: 1)
        lb.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        lb.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return lb
    }()
    
    
    lazy var bgImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        backgroundColor = .white
        addSubview(bgImageView)
        addSubview(bottomView)
        bottomView.addSubview(titleLb)
        
        bgImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.left.right.equalToSuperview()
            make.height.equalTo(self.snp.width).multipliedBy(1.0 / 2)
        }
        
        bottomView.snp.makeConstraints { (make) in
            make.top.equalTo(bgImageView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        
        titleLb.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.right.equalTo(bottomView).offset(-10)
            make.center.equalToSuperview()
        }
        
        layer.borderColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
        layer.borderWidth = 0.5
        layer.cornerRadius = 6
        backgroundColor = .white
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 3, height: 3)
        layer.shadowOpacity = 0.01
        layer.shadowRadius = 0
        layer.cornerRadius = 6
        layer.masksToBounds = true
        
    }
}
