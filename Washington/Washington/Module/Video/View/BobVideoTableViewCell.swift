//
//  BobVideoTableViewCell.swift
//  Washington
//
//  Created by bob on 2021/6/6.
//

import UIKit

class BobVideoTableViewCell: BobCommonSelectionTableViewCell {
    private lazy var coverImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.layer.cornerRadius = 4
        imgView.layer.masksToBounds = true
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        return imgView
    }()
    
    private lazy var bottomView: UIView = {
        let view = UIView()
//        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        view.blurView.setup(style: .light, alpha: 1).enable()
        return view
    }()
    
    private lazy var titleLb: UILabel = {
        let lb = UILabel()
        lb.textColor = #colorLiteral(red: 0.1215686275, green: 0.137254902, blue: 0.1607843137, alpha: 1)
        lb.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        lb.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return lb
    }()
    
    
    var model: ContentListModel? {
        didSet {
            guard let m = model else {
                return
            }
            
            titleLb.text = m.iconName
            coverImageView.kf.setImage(urlString: m.iconUrl, placeholder: (bounds.width > bounds.height) ? UIImage(named: "normal_placeholder_h") : UIImage(named: "normal_placeholder_v"))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func configUI() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        coverImageView.addSubview(bottomView)
        addSubview(coverImageView)
        bottomView.addSubview(titleLb)
        coverImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
//            make.top.equalToSuperview().offset(5)
//            make.left.right.equalToSuperview()
//            make.height.equalTo(self.snp.width).multipliedBy(1.0 / 2)
        }
        
        bottomView.snp.makeConstraints { (make) in
//            make.top.equalTo(coverImageView.snp.bottom)
//            make.left.right.bottom.equalToSuperview()
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(coverImageView.snp.height).dividedBy(3)
        }
        
        titleLb.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.right.equalTo(bottomView).offset(-10)
            make.center.equalToSuperview()
        }
    }
}
