//
//  BobPlayer.swift
//  Washington
//
//  Created by bob on 2021/5/20.
//

import UIKit
import Player

class BobPlayer: UIView {
    private let player: Player = Player()
    public var url: URL? {
        didSet {
            guard let u = url else {
                return
            }
            
            player.url = u
            player.playFromBeginning()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    private func commonInit() {
        player.playerDelegate = self
        player.playbackDelegate = self
     

        parentContainerViewController()?.addChild(self.player)
        addSubview(self.player.view)
        player.didMove(toParent: parentContainerViewController())
        player.view.backgroundColor = .black
        player.view.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalToSuperview().dividedBy(3)
        }
    }

}

extension BobPlayer: PlayerDelegate {
    func playerReady(_ player: Player) {
        
    }
    
    func playerPlaybackStateDidChange(_ player: Player) {
        
    }
    
    func playerBufferingStateDidChange(_ player: Player) {
        
    }
    
    func playerBufferTimeDidChange(_ bufferTime: Double) {
        
    }
    
    func player(_ player: Player, didFailWithError error: Error?) {
        
    }
    
    
}

extension BobPlayer: PlayerPlaybackDelegate {
    func playerCurrentTimeDidChange(_ player: Player) {
        let a = Double(player.currentTime.value) / player.maximumDuration
        print(a)
    }
    
    func playerPlaybackWillStartFromBeginning(_ player: Player) {
        
    }
    
    func playerPlaybackDidEnd(_ player: Player) {
        
    }
    
    func playerPlaybackWillLoop(_ player: Player) {
        
    }
    
    func playerPlaybackDidLoop(_ player: Player) {
        
    }
    
    
}
