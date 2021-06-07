//
//  AppDelegate.swift
//  Washington
//
//  Created by Bob on 2021/9/29.
//  Copyright © 2021年 None. All rights reserved.
//

import UIKit
import Alamofire
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    lazy var reachability: NetworkReachabilityManager? = {
        return NetworkReachabilityManager(host: "http://app.u17.com")
    }()
    
    var orientation: UIInterfaceOrientationMask = .portrait
    
    
    
    internal func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        configBase()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = UTabBarController()
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func configBase() {
        //MARK: 键盘处理
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        //MARK: 性别缓存
        let defaults = UserDefaults.standard
        if defaults.value(forKey: String.sexTypeKey) == nil {
            defaults.set(1, forKey: String.sexTypeKey)
            defaults.synchronize()
        }
        
        //MARK: 网络监控
        reachability?.listener = { status in
            switch status {
            case .reachable(.wwan):
                UNoticeBar(config: UNoticeBarConfig(title: "主人,检测到您正在使用移动数据")).show(duration: 2)
            default: break
            }
        }
        reachability?.startListening()
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return .all
    }
 
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}



//extension UIViewController {
//    func shouldAutorotate() -> Bool {
//        // iPhone的demo用到了播放器的旋转, 这里返回NO, 除播放器外, 项目中的其他视图控制器都禁止旋转
//        if ( .phone == UI_USER_INTERFACE_IDIOM() ) {
//            return false
//        }
//
//        // iPad的demo未用到播放器的旋转, 这里返回YES, 允许所有控制器旋转
//        else if ( .pad == UI_USER_INTERFACE_IDIOM() ) {
//            return false
//        }
//
//        // 如果你的项目仅支持竖屏, 可以直接返回NO, 无需进行上述的判断区分.
//        return false
//    }
//
//    func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
//        // 此处为设置 iPhone demo 仅支持竖屏的方向
//        if ( .phone == UI_USER_INTERFACE_IDIOM() ) {
//            return .portrait;
//        }
//
//        // 此处为设置 iPad demo 仅支持横屏的方向
//        else if ( .pad == UI_USER_INTERFACE_IDIOM() ) {
//            return .landscape;
//        }
//
//        // 如果你的项目仅支持竖屏, 可以直接返回UIInterfaceOrientationMaskPortrait, 无需进行上述的判断区分.
//        return .portrait;
//    }
//    //    - (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    //        // 此处为设置 iPhone demo 仅支持竖屏的方向
//    //        if ( UIUserInterfaceIdiomPhone == UI_USER_INTERFACE_IDIOM() ) {
//    //            return UIInterfaceOrientationMaskPortrait;
//    //        }
//    //
//    //        // 此处为设置 iPad demo 仅支持横屏的方向
//    //        else if ( UIUserInterfaceIdiomPad == UI_USER_INTERFACE_IDIOM() ) {
//    //            return UIInterfaceOrientationMaskLandscape;
//    //        }
//    //
//    //        // 如果你的项目仅支持竖屏, 可以直接返回UIInterfaceOrientationMaskPortrait, 无需进行上述的判断区分.
//    //        return UIInterfaceOrientationMaskPortrait;
//    //    }
//}
