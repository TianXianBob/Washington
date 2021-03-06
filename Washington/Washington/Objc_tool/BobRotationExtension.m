//
//  BobRotationExtension.m
//  Washington
//
//  Created by bob on 2021/6/8.
//

#import "BobRotationExtension.h"
#import <UIKit/UIKit.h>
#import <SJVideoPlayer/SJVideoPlayer.h>

@implementation SJVideoPlayer (RotationControl)
- (BOOL)isFullScreen {
    return YES;
}
@end

@implementation BobRotationExtension

@end

@implementation UIViewController (RotationControl)
///
/// 控制器是否可以旋转
///
- (BOOL)shouldAutorotate {
    // iPhone的demo用到了播放器的旋转, 这里返回NO, 除播放器外, 项目中的其他视图控制器都禁止旋转
    if ( UIUserInterfaceIdiomPhone == UI_USER_INTERFACE_IDIOM() ) {
        return NO;
    }
    
    // iPad的demo未用到播放器的旋转, 这里返回YES, 允许所有控制器旋转
    else if ( UIUserInterfaceIdiomPad == UI_USER_INTERFACE_IDIOM() ) {
        return YES;
    }
    
    // 如果你的项目仅支持竖屏, 可以直接返回NO, 无需进行上述的判断区分.
    return NO;
}

///
/// 控制器旋转支持的方向
///
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    // 此处为设置 iPhone demo 仅支持竖屏的方向
    if ( UIUserInterfaceIdiomPhone == UI_USER_INTERFACE_IDIOM() ) {
        return UIInterfaceOrientationMaskPortrait;
    }
    
    // 此处为设置 iPad demo 仅支持横屏的方向
    else if ( UIUserInterfaceIdiomPad == UI_USER_INTERFACE_IDIOM() ) {
        return UIInterfaceOrientationMaskLandscape;
    }
    
    // 如果你的项目仅支持竖屏, 可以直接返回UIInterfaceOrientationMaskPortrait, 无需进行上述的判断区分.
    return UIInterfaceOrientationMaskPortrait;
}

@end


@implementation UITabBarController (RotationControl)
- (UIViewController *)sj_topViewController {
    if ( self.selectedIndex == NSNotFound )
        return self.viewControllers.firstObject;
    return self.selectedViewController;
}

- (BOOL)shouldAutorotate {
    return [[self sj_topViewController] shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [[self sj_topViewController] supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [[self sj_topViewController] preferredInterfaceOrientationForPresentation];
}
@end

@implementation UINavigationController (RotationControl)
- (BOOL)shouldAutorotate {
    return self.topViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.topViewController.supportedInterfaceOrientations;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return self.topViewController.preferredInterfaceOrientationForPresentation;
}

- (nullable UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}

- (nullable UIViewController *)childViewControllerForStatusBarHidden {
    return self.topViewController;
}
@end

