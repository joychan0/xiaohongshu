//
//  SceneDelegate.m
//  Demo3
//
//  Created by 江一川 on 2020/8/11.
//  Copyright © 2020 江一川. All rights reserved.
//

#import "SceneDelegate.h"

#import "HomepageVC.h"
#import "StoreVC.h"
#import "MessageVC.h"
#import "MineVC.h"
#import "Header.h"
#import "MyTabbarVC.h"
#import "MyNavigationController.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    //首页
    HomepageVC *homeVC = [[HomepageVC alloc] init];
    MyNavigationController *homeNav = [[MyNavigationController alloc] initWithRootViewController:homeVC];
    homeNav.navigationBar.translucent = NO;
    [homeNav.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -15)];
    [homeNav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0x000000),NSFontAttributeName : [UIFont boldSystemFontOfSize:24.f]} forState:UIControlStateHighlighted];
    [homeNav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0x333333),NSFontAttributeName : [UIFont systemFontOfSize:16.f]} forState:UIControlStateNormal];
    homeNav.tabBarItem.tag = 1001;
    homeNav.tabBarItem.title = @"首页";
    
    //商城
    StoreVC *workVC = [[StoreVC alloc] init];
    MyNavigationController *storeNav = [[MyNavigationController alloc] initWithRootViewController:workVC];
    storeNav.navigationBar.translucent = NO;
    [storeNav.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -15)];
    [storeNav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0x000000),NSFontAttributeName : [UIFont boldSystemFontOfSize:24.f]} forState:UIControlStateHighlighted];
    [storeNav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0x333333),NSFontAttributeName : [UIFont systemFontOfSize:16.f]} forState:UIControlStateNormal];
    storeNav.tabBarItem.tag = 1002;
    storeNav.tabBarItem.title = @"商城";
    //消息
    MessageVC *noticeVC = [[MessageVC alloc] init];
    MyNavigationController *messageNav = [[MyNavigationController alloc] initWithRootViewController:noticeVC];
    messageNav.navigationBar.translucent = NO;
    [messageNav.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -15)];
    [messageNav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0x000000),NSFontAttributeName : [UIFont boldSystemFontOfSize:24.f]} forState:UIControlStateHighlighted];
    [messageNav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0x333333),NSFontAttributeName : [UIFont systemFontOfSize:16.f]} forState:UIControlStateNormal];
    messageNav.tabBarItem.tag = 1003;
    messageNav.tabBarItem.title = @"消息";
    
    
    //我的
    MineVC *mineVC = [[MineVC alloc] init];
    MyNavigationController *mineNav = [[MyNavigationController alloc] initWithRootViewController:mineVC];
    mineNav.navigationBar.translucent = NO;
    
    [mineNav.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -15)];
    [mineNav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0x000000),NSFontAttributeName : [UIFont boldSystemFontOfSize:24.f]} forState:UIControlStateHighlighted];
    [mineNav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0x333333),NSFontAttributeName : [UIFont systemFontOfSize:16.f]} forState:UIControlStateNormal];
    mineNav.tabBarItem.tag = 1004;
    mineNav.tabBarItem.title = @"我";
    
    //2、创建一个数组，放置多有控制器
    NSArray *vcArray = [NSArray arrayWithObjects:homeNav, storeNav, messageNav, mineNav, nil];
        
    //3、创建UITabBarController，将控制器数组设置给UITabBarController
    UITabBarController *tabBarVC = [[UITabBarController alloc] init];
    //设置多个Tab的ViewController到TabBarViewController
    tabBarVC.viewControllers = vcArray;
    //4、将UITabBarController设置为Window的RootViewController
    tabBarVC.tabBar.translucent = NO;
    
    self.window.rootViewController = tabBarVC;
    //显示Window
    [self.window makeKeyAndVisible];
    
    
}


- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}


@end
