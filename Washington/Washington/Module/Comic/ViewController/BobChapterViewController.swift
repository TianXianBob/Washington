//
//  BobChapterViewController.swift
//  Washington
//
//  Created by bob on 2021/5/16.
//

import UIKit

class BobChapterViewController: BobBaseViewController {
    public var dataSource: [ContentListModel] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private let identify = "BobChapterCollectionViewCell"
    private let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    private let lineSpacing = CGFloat(10)
    private let interitemSpacing = CGFloat(5)
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = sectionInsets
        layout.minimumLineSpacing = lineSpacing
        layout.minimumInteritemSpacing = interitemSpacing
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.bounces = true
        collectionView.alwaysBounceVertical = true
        collectionView.register(BobChapterCollectionViewCell.self, forCellWithReuseIdentifier: identify)
        return collectionView
    
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = .top
        
        view.backgroundColor = UIColor.white
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
     
    }

}

extension BobChapterViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let m = dataSource[indexPath.row]
        guard let _ = URL(string: m.playUrl ?? "") else {
            return
        }
        let vc = BobVideoViewController(model: m, list: dataSource)
        vc.modalPresentationStyle = .fullScreen
        navigationController?.present(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
       
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = floor((UScreenWidth - interitemSpacing - sectionInsets.left - sectionInsets.right) / 2)
        return CGSize(width: width, height: width * 0.8)
    }
}

extension BobChapterViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = dataSource[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identify, for: indexPath) as! BobChapterCollectionViewCell
        cell.model = model
        cell.delegate = self
        return cell
    }

}

extension BobChapterViewController: BobChapterCollectionViewCellDelegate {
    func collectionViewCellEditClick(_ cell: BobChapterCollectionViewCell) {
        
    }
    
}



