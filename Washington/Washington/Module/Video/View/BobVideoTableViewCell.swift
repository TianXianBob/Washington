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
    
    
    var model: ContentListModel? {
        didSet {
            guard let m = model else {
                return
            }
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
        addSubview(coverImageView)
        coverImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
    }
}
