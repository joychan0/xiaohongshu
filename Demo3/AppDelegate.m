//
//  AppDelegate.m
//  Demo3
//
//  Created by 江一川 on 2020/8/11.
//  Copyright © 2020 江一川. All rights reserved.
//

#import "AppDelegate.h"


#import "HomepageVC.h"
#import "StoreVC.h"
#import "MessageVC.h"
#import "MineVC.h"
#import "Header.h"
#import "MyTabbarVC.h"
#import "MyNavigationController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    if (@available(iOS 13.0, *)) {
    
    } else {
        self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
        //1.创建Tab所属的ViewController
        //首页
        HomepageVC *homeVC = [[HomepageVC alloc] init];
        MyNavigationController *homeNav = [[MyNavigationController alloc] initWithRootViewController:homeVC];
        homeNav.navigationBar.translucent = NO;
        
        [homeNav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0xf6f6f6),NSFontAttributeName : [UIFont systemFontOfSize:14.f]} forState:UIControlStateSelected];
        [homeNav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0x333333),NSFontAttributeName : [UIFont systemFontOfSize:10.f]} forState:UIControlStateNormal];
        homeNav.tabBarItem.tag = 1001;
        homeNav.tabBarItem.title = @"首页";
        
        //商城
        StoreVC *workVC = [[StoreVC alloc] init];
        MyNavigationController *workNav = [[MyNavigationController alloc] initWithRootViewController:workVC];
        workNav.navigationBar.translucent = NO;
            
        //消息
        MessageVC *noticeVC = [[MessageVC alloc] init];
        MyNavigationController *noticeNav = [[MyNavigationController alloc] initWithRootViewController:noticeVC];
        noticeNav.navigationBar.translucent = NO;
            
        //我的
        MineVC *mineVC = [[MineVC alloc] init];
        MyNavigationController *mineNav = [[MyNavigationController alloc] initWithRootViewController:mineVC];
        mineNav.navigationBar.translucent = NO;
            
        //2、创建一个数组，放置多有控制器
        NSArray *vcArray = [NSArray arrayWithObjects:homeNav, workNav, noticeNav, mineNav, nil];
            
        //3、创建UITabBarController，将控制器数组设置给UITabBarController
        MyTabbarVC *tabBarVC = [[MyTabbarVC alloc] init];
        //设置多个Tab的ViewController到TabBarViewController
        tabBarVC.viewControllers = vcArray;
        tabBarVC.tabBar.translucent = NO;
        //4、将UITabBarController设置为Window的RootViewController
        self.window.rootViewController = tabBarVC;
        //显示Window
        [self.window makeKeyAndVisible];
    }
    
    
    
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
