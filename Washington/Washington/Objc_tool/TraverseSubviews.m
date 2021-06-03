//
//  TraverseSubviews.m
//  Washington
//
//  Created by bob on 2021/5/29.
//

#import "TraverseSubviews.h"
#import "ViewNode.h"


@implementation TraverseSubviews
+ (NSString *)traverseSubviews {
    NSArray *windows = UIApplication.sharedApplication.windows;
    [self traverseWindows:windows];
    return nil;
}


+ (void)traverseWindows:(NSArray<UIWindow *> *)windows {
    [windows enumerateObjectsUsingBlock:^(UIWindow * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self logSubviewsWithView:obj];
//        [self traverseViewController:obj.rootViewController];
    }];
}


+ (void)traverseViewController:(UIViewController *)viewController {
    if (!viewController) {
        return;
    }
    
    [self logSubviewsWithView:viewController.view];
    
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        [self traverseNavController:(UINavigationController *)viewController];
    } else if ([viewController isKindOfClass:[UITabBarController class]]) {
        [self traverseTabbarController:(UITabBarController *)viewController];
    }
    
    // 遍历ChildViewController
    [self traverseChildViewControllerWithController:viewController];
    
    // 遍历presentedViewController
    if (viewController.presentedViewController) {
        [self traverseViewController:viewController.presentedViewController];
    }
}

+ (void)traverseTabbarController:(UITabBarController *)tabbarViewController {
    if (![tabbarViewController isKindOfClass:[UITabBarController class]]) {
        return;
    }
    
    if (!tabbarViewController.selectedViewController) {
        return;
    }
    
    [self traverseViewController:tabbarViewController.selectedViewController];
}

+ (void)traverseNavController:(UINavigationController *)navController {
    if (![navController isKindOfClass:[UINavigationController class]]) {
        return;
    }
    
    if (navController.childViewControllers.count == 0) {
        return;
    }
    
    for (UIViewController *vc in navController.childViewControllers) {
        [self traverseViewController:vc];
    }
}


+ (void)traverseChildViewControllerWithController:(UIViewController *)vc {
    if (vc.childViewControllers.count == 0) {
        return;
    }
    
    for (UIViewController *sub in vc.childViewControllers) {
        [self logSubviewsWithView:sub.view];
        if ([sub isKindOfClass:NSClassFromString(@"BobBoutiqueListViewController")]) {
            NSLog(@"BobBoutiqueListViewController");
        }
        
        [self traverseChildViewControllerWithController:sub];
    }
}



+ (void)logSubviewsWithView:(UIView *)view {
    if (view.subviews.count == 0) {
        return;
    }
    
    NSLog(@"-------------------------------- begin");
    
    [view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIButton class]]) {
            NSLog(@"--------- viewClass = %@, superViewClass = %@, content = %@ ---------", NSStringFromClass(obj.class), NSStringFromClass(obj.superview.class), ((UIButton *)obj).titleLabel.text);

        } else if ([obj isKindOfClass:[UILabel class]]) {
            NSLog(@"--------- viewClass = %@, superViewClass = %@, content = %@ ---------", NSStringFromClass(obj.class), NSStringFromClass(obj.superview.class), ((UILabel *)obj).text);

        } else if ([obj isKindOfClass:[UIControl class]]) {
            NSLog(@"--------- viewClass = %@, superViewClass = %@, enabled = %d ---------", NSStringFromClass(obj.class), NSStringFromClass(obj.superview.class), ((UIControl *)obj).enabled);

        } else if ([obj isKindOfClass:[UICollectionView class]]){
            NSLog(@"--------- viewClass = %@, superViewClass = %@, tag = %ld---------", NSStringFromClass(obj.class), NSStringFromClass(obj.superview.class), obj.tag);
        }
        else {
            NSLog(@"--------- viewClass = %@, superViewClass = %@, tag = %ld---------", NSStringFromClass(obj.class), NSStringFromClass(obj.superview.class), obj.tag);
        }
        
        [self logSubviewsWithView:obj];
    }];
    
}

+ (UIViewController *)visiableViewController {
    UIViewController *topViewController = nil;
    topViewController = [self recursive_topViewController:[[UIApplication sharedApplication].windows.firstObject rootViewController]];
    while (topViewController.presentedViewController) {
        topViewController = [self recursive_topViewController:topViewController.presentedViewController];
    }
    return topViewController;
}

+ (UIViewController *)nextViewController:(UIViewController *)vc {
    if (vc.presentedViewController) {
        return vc.presentedViewController;
    }
    
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return (UINavigationController *)vc.childViewControllers.firstObject;
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [(UITabBarController *)vc selectedViewController];
    } else {
        return nil;
    }
}

+ (UIViewController *)recursive_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self recursive_topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self recursive_topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
}
@end
