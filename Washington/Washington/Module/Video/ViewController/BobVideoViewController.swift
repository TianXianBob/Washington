//
//  BobVideoViewController.swift
//  Washington
//
//  Created by bob on 2021/5/16.
//

import UIKit
//import Player
import SnapKit
import SJVideoPlayer

class BobVideoViewController: BobBaseViewController {
    private var url: URL? {
        return URL(string: currentModel?.playUrl ?? "")
    }
    private let player = SJVideoPlayer()
    private var dataSource: [ContentListModel] = []
    private var currentModel: ContentListModel?
    
    convenience init(model: ContentListModel, list: [ContentListModel]) {
        self.init()
        currentModel = model
        dataSource = list
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        player.vc_viewDidAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        player.vc_viewWillDisappear()
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        player.vc_viewDidDisappear()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        UIApplication.changeOrientationTo(landscapeRight: true)
    }
//
//    override var shouldAutorotate: Bool {
//        return true
//    }
//
//    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//        return .landscape
//    }
//
//    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
//        return .landscapeRight
//    }
    
    override func configNavigationBar() {
        super.configNavigationBar()
        navigationController?.barStyle(.clear)
    }
    
    private func commonInit() {
        view.backgroundColor = .white
        
        do {
            view.addSubview(player.view)
            player.rotationManager.isDisabledAutorotation = true
            player.defaultEdgeControlLayer.topContainerView.largeContentTitle = "123"
            player.rotationManager.autorotationSupportedOrientations = SJOrientationMaskLandscapeLeft
            player.defaultEdgeControlLayer.bottomAdapter.removeItem(forTag: SJEdgeControlLayerBottomItem_Full)
            player.defaultEdgeControlLayer.bottomAdapter.removeItem(forTag: SJEdgeControlLayerBottomItem_Separator)
            player.defaultEdgeControlLayer.bottomAdapter.exchangeItem(forTag: SJEdgeControlLayerBottomItem_DurationTime, withItemForTag: SJEdgeControlLayerBottomItem_Progress)
            let durationItem = player.defaultEdgeControlLayer.bottomAdapter.item(forTag: SJEdgeControlLayerBottomItem_DurationTime)
            durationItem?.insets = SJEdgeInsets(front: 8, rear: 16)
            player.defaultEdgeControlLayer.bottomContainerView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            player.defaultEdgeControlLayer.topContainerView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            player.defaultEdgeControlLayer.bottomAdapter.reload()
            player.view.snp.makeConstraints { (make) in
//                make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
//                make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
//                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
//                make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
                make.edges.equalToSuperview()
            }
            player.defaultEdgeControlLayer.isEnabledClips = true
            player.defaultEdgeControlLayer.clipsConfig.saveResultToAlbum = true
//            player.controlLayerNeedAppear()
//            [_player.switcher switchControlLayerForIdentifier:SJControlLayer_Clips];

//            [_player.prompt show:[NSAttributedString sj_UIKitText:^(id<SJUIKitTextMakerProtocol>  _Nonnull make) {
//                make.append(@"请旋转至全屏后, 点击右侧剪辑按钮");
//                make.textColor(UIColor.whiteColor);
//            }] duration:3];
            player.controlLayerAppearObserver.appearStateDidChangeExeBlock = { [weak self] mrg  in
                guard let strongSelf = self else { return }

                if mrg.isAppeared {
                    strongSelf.player.promptPopupController.bottomMargin = strongSelf.player.defaultEdgeControlLayer.bottomContainerView.bounds.size.height
                } else {
                    strongSelf.player.promptPopupController.bottomMargin = 16
                }
            }
//            player.defaultEdgeControlLayer.isHiddenBackButtonWhenOrientationIsPortrait = true
           
            
            if let u = url {
                let asset = SJVideoPlayerURLAsset(url: u)
                asset?.attributedTitle = NSAttributedString.sj_UIKitText({ make in
                    make.append(self.currentModel?.iconName ?? "")
                    make.textColor(.white)
                })
//                    [NSAttributedString sj_UIKitText:^(id<SJUIKitTextMakerProtocol>  _Nonnull make) {
//                    make.append(@"SJVideoPlayerURLAsset *asset = [[SJVideoPlayerURLAsset");
//                    make.textColor(UIColor.whiteColor);
//                }];
                player.urlAsset = asset
            }
        }
        
        

    }

  
}

