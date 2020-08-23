//
//  TransitionAnimationEffect.m
//  Demo3
//
//  Created by 江一川 on 2020/8/19.
//  Copyright © 2020 江一川. All rights reserved.
//

#import "TransitionAnimationEffect.h"
#import "MyViewController.h"
#import "HomepageFindView.h"
#import "Header.h"
#import "UIView+Additions.h"
#import "FeedDetailView.h"
#import "FeedDetailVC.h"
#import "HomepageFindCategoryVC.h"

@implementation TransitionAnimationEffect

- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    NSLog(@"transitionContext");
    UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;
    //开始vc
    MyViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    //跳转vc
    MyViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [transitionContext containerView].backgroundColor = [UIColor clearColor];
    
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    
    UIView *fromTargetView = [fromVC animationFromTargetView];
    UIView *toTargetView = [toVC animationFromTargetView];
    
    
    //截取首页图片
    UIImageView *feedView;
    for (UIView *subview in fromTargetView.subviews ) {
        if ([subview isKindOfClass:[HomepageFindView class]]) {
            feedView = [[UIImageView alloc] initWithImage:[subview toImage]];
            break;
        }
    }
    
    
    
    fromTargetView.hidden = YES;

    ((FeedDetailVC *)toVC).lastVCView = [[UIImageView alloc] initWithImage:[keyWindow toImage]];
    //截取详情页图片
    FeedDetailView *testView = [[FeedDetailView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    testView.model = ((FeedDetailVC *)toVC).model;
    UIView *tempView = [testView snapshotViewAfterScreenUpdates:YES];

    
    UIView *totalView = [[UIView alloc] init];
    [totalView addSubview:tempView];
    [totalView addSubview:feedView];
    totalView.clipsToBounds = YES;
    totalView.backgroundColor = [UIColor whiteColor];
    //判断是否为空
    if (!fromTargetView || !toTargetView) {
        [[transitionContext containerView] addSubview:fromView];
        [[transitionContext containerView] addSubview:testView];
        
        [transitionContext completeTransition:YES];
        return;
    }
    toView.alpha = 0;
    fromView.alpha = 1;
    //坐标转换
    
    CGPoint fromTargetPoint = [fromTargetView convertPoint:fromTargetView.frame.origin toView:keyWindow];
    CGPoint toTargetPoint = [toTargetView convertPoint:toTargetView.frame.origin toView:keyWindow];
    //view范围
    totalView.frame = CGRectMake(fromTargetPoint.x, fromTargetPoint.y, feedView.frame.size.width, feedView.frame.size.height);
    //前一个页面view
    feedView.frame = CGRectMake(0, 0, feedView.frame.size.width, feedView.frame.size.height);
    feedView.alpha = 1;
    //后一个页面view
    tempView.frame = CGRectMake(0, - ((NavBarHeight + StatusBarHeight) / SCREEN_WIDTH * feedView.width), feedView.frame.size.width, SCREEN_HEIGHT / SCREEN_WIDTH * feedView.width);
    tempView.alpha = 0.5;
    ((FeedDetailVC *)toVC).maskRect = CGRectMake(fromTargetPoint.x, fromTargetPoint.y, feedView.width, feedView.height);
    [[transitionContext containerView] addSubview:toView];

    [[transitionContext containerView] addSubview:totalView];
    
    
    [keyWindow addSubview:totalView];
    
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        feedView.frame = CGRectMake(0, 88, SCREEN_WIDTH, SCREEN_WIDTH / feedView.width * feedView.height);
        feedView.alpha = 0;
        tempView.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
        tempView.alpha = 1;
        totalView.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
        fromView.alpha = 1;
    } completion:^(BOOL finished) {
        fromView.alpha = 1;
        toView.alpha = 1.0;
        fromTargetView.hidden = NO;
        [totalView removeFromSuperview];
        [feedView removeFromSuperview];
        [tempView removeFromSuperview];
        [transitionContext containerView].backgroundColor = [UIColor clearColor];
        [transitionContext completeTransition:YES];
    }];
    
}



//动画持续时间
- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

- (void)dealloc
{
    
}

@end
