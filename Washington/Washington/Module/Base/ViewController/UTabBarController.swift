//
//  UTabBarController.swift
//  Washington
//
//  Created by Bob on 2021/9/29.
//  Copyright © 2021年 None. All rights reserved.
//

import UIKit

class UTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.isTranslucent = false
        
        /// 首页
        let classVC = BobRecommendViewController(titles: ["推荐",
        ],
        vcs: [BobRecommendListViewController()],
        pageStyle: .navgationBarSegment)
        addChildViewController(classVC,
                               title: "推荐",
                               image: UIImage(named: "tab_home"),
                               selectedImage: UIImage(named: "tab_home"))
        
        
        /// 分类
        let onePageVC = BobHomeViewController(titles: ["分类",
        ],
        vcs: [BobBoutiqueListViewController()],
        pageStyle: .navgationBarSegment)
        addChildViewController(onePageVC,
                               title: "分类",
                               image: UIImage(named: "tab_class"),
                               selectedImage: UIImage(named: "tab_class_S"))
        //        let classVC = UCateListViewController()
        //        addChildViewController(classVC,
        //                               title: "分类",
        //                               image: UIImage(named: "tab_class"),
        //                               selectedImage: UIImage(named: "tab_class_S"))
        
        
        /// 书架
        let feetVC = UBookViewController(titles: ["收藏",
                                                  "历史",
                                                  "下载"],
                                         vcs: [UCollectListViewController(),
                                               UDocumentListViewController(),
                                               UDownloadListViewController()],
                                         pageStyle: .navgationBarSegment)
        addChildViewController(feetVC,
                               title: "足迹",
                               image: UIImage(named: "tab_book"),
                               selectedImage: UIImage(named: "tab_book_S"))
        
        
        /// 我的
        let mineVC = UMineViewController()
        addChildViewController(mineVC,
                               title: "我的",
                               image: UIImage(named: "tab_mine"),
                               selectedImage: UIImage(named: "tab_mine_S"))
    }
    
    func addChildViewController(_ childController: UIViewController, title:String?, image:UIImage? ,selectedImage:UIImage?) {
        
        childController.title = title
        childController.tabBarItem = UITabBarItem(title: nil,
                                                  image: image?.withRenderingMode(.alwaysOriginal),
                                                  selectedImage: selectedImage?.withRenderingMode(.alwaysOriginal))
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            childController.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        }
        addChild(UNavigationController(rootViewController: childController))
    }
    
}

extension UTabBarController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        guard let select = selectedViewController else { return .lightContent }
        return select.preferredStatusBarStyle
    }
}

