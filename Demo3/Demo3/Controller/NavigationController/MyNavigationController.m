//
//  MyNavigationController.m
//  Demo3
//
//  Created by 江一川 on 2020/8/18.
//  Copyright © 2020 江一川. All rights reserved.
//

#import "MyNavigationController.h"
#import "TransitionAnimationEffect.h"
#import "TransitionAnimationPopEffect.h"

@interface MyNavigationController ()<UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@end

@implementation MyNavigationController {
    id <UIViewControllerAnimatedTransitioning> _animtedTransitioning;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self setupRightPanReturn];
    self.type = KAnimationTransitionTypeNone;
    self.delegate = self;
}


#pragma mark — 代理
- (nullable id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    
    if (self.type == KAnimationTransitionTypeScalePushMove) {
        _animtedTransitioning = [[TransitionAnimationEffect alloc] init];
        NSLog(@"返回转场动画");
    } else if (self.type == KAnimationTransitionTypeScalePopMove) {
        _animtedTransitioning = [[TransitionAnimationPopEffect alloc] init];
    } else {
        _animtedTransitioning = nil;
    }
    self.type = KAnimationTransitionTypeNone;
    return _animtedTransitioning;
}

- (void)setupRightPanReturn{
    
    // 获取系统自带滑动手势的target对象
    id target = self.interactivePopGestureRecognizer.delegate;
    // 获取返回方法
    SEL handler = NSSelectorFromString(@"handleNavigationTransition:");
    //  获取添加系统边缘触发手势的View
    UIView *targetView = self.interactivePopGestureRecognizer.view;
    
    //  创建pan手势 作用范围是全屏
    _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:target action:handler];
    _panGestureRecognizer.delegate = self;
    [targetView addGestureRecognizer:_panGestureRecognizer];
    // 关闭边缘触发手势 防止和原有边缘手势冲突
    [self.interactivePopGestureRecognizer setEnabled:NO];
}


@end
