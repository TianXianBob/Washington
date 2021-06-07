//
//  BobSwitchVideoViewController.swift
//  Washington
//
//  Created by bob on 2021/6/6.
//

import UIKit
import SJVideoPlayer

protocol BobCustomControlLayerViewControllerDelegate: AnyObject {
    func tappedBlankAreaOnTheControlLayer(_ layer: SJControlLayer)
    func changeVideo(_ model: ContentListModel)
}

class BobSwitchVideoViewController: UIViewController, SJControlLayer {
    public weak var delegate: BobCustomControlLayerViewControllerDelegate?
    public var currentModel: ContentListModel? {
        didSet {
            list.reloadData()
        }
    }

    
    private weak var player: SJVideoPlayer?
    private var dataSource: [ContentListModel] = []
    private let list = UITableView(frame: .zero, style: .plain)
    private let rightContainerView = UIView()
    
    convenience init(model: ContentListModel, list: [ContentListModel]) {
        self.init()
        currentModel = model
        dataSource = list
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    private func commonInit() {
        
        do {
            rightContainerView.backgroundColor = .black
            rightContainerView.sjv_disappearDirection = SJViewDisappearAnimation_Right
            view.addSubview(rightContainerView)
            rightContainerView.snp.makeConstraints { make in
                make.top.right.bottom.equalToSuperview()
            }
        }
        
        do {
            list.showsHorizontalScrollIndicator = false
            list.showsVerticalScrollIndicator = false
            list.delegate = self
            list.dataSource = self
            list.backgroundColor = .clear
            list.estimatedRowHeight = 0
            list.separatorStyle = .none
            list.register(BobVideoTableViewCell.self, forCellReuseIdentifier: BobVideoTableViewCell.reuseIdentifier)
            rightContainerView.addSubview(list)
            list.snp.makeConstraints { make in
                make.top.left.right.bottom.equalToSuperview()
                make.width.equalTo(min(UScreenWidth, UScreenHeight) / 1.5)
            }
            
            if let m = currentModel {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else {return}
                    let index = self.dataSource.firstIndex(of: m) ?? 0
                    self.list.scrollToRow(at: IndexPath(item: index, section: 0), at: .middle, animated: true)
                }
            }
            
        }
        
    }
    
    
    //MARK: SJControlLayer
    internal var restarted: Bool = false
    func controlView() -> UIView! {
        return self.view
    }
    
    
    
    func restartControlLayer() {
        restarted = true
        sj_view_makeAppear(controlView(), true)
        sj_view_makeAppear(rightContainerView, true)
    }
    
    func exitControlLayer() {
        restarted = false
        sj_view_makeDisappear(rightContainerView, true)
        sj_view_makeDisappear(controlView(), true) { [weak self] in
            guard let self = self else { return }
            if !self.restarted {
                self.controlView().removeFromSuperview()
            }
        };
    }
    
    func installedControlView(to videoPlayer: SJBaseVideoPlayer!) {
        guard let p = videoPlayer as? SJVideoPlayer else {
            return
        }
        
        player = p
            
        if view.layer.needsLayout() {
            sj_view_initializes(rightContainerView)
        }
        
        sj_view_makeDisappear(rightContainerView, false)
    }
    
    func videoPlayer(_ videoPlayer: SJBaseVideoPlayer!, gestureRecognizerShouldTrigger type: SJPlayerGestureType, location: CGPoint) -> Bool {
        if type == SJPlayerGestureType_SingleTap {
            if !rightContainerView.frame.contains(location) {
                delegate?.tappedBlankAreaOnTheControlLayer(self)
            }
        }
        
        return false
    }
}

extension BobSwitchVideoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (UScreenWidth - 30) / 2.5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let m = dataSource[indexPath.row]
        currentModel = m
        list.reloadData()
        list.scrollToRow(at: indexPath, at: .middle, animated: true)
        delegate?.changeVideo(m)
    }
}

extension BobSwitchVideoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BobVideoTableViewCell.reuseIdentifier) as? BobVideoTableViewCell else {
            return .init()
        }
        
        let m = dataSource[indexPath.row]
        
        cell.model = m
        
        if let current = currentModel, current == m {
            cell.isSelected = true
        } else {
            cell.isSelected = false
        }
        
        return cell
    }
    
    
}


