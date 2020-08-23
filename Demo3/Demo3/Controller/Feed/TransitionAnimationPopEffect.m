//// TransitionAnimationPopEffect.m
// Demo3
//
// Copyright © 2020 江一川. All rights reserved.
//


#import "TransitionAnimationPopEffect.h"
#import "MyViewController.h"
#import "HomepageFindView.h"
#import "Header.h"
#import "UIView+Additions.h"
#import "FeedDetailView.h"
#import "FeedDetailVC.h"

@implementation TransitionAnimationPopEffect

- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    NSLog(@"transitionContext");
    //开始vc
    MyViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    //跳转vc
    MyViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIColor *containViewColor = [transitionContext containerView].backgroundColor;
    
    CGRect tempRect = ((FeedDetailVC *)fromVC).lastRect;
    
    
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    
    UIView *fromTargetView = [fromVC animationFromTargetView];
    UIView *toTargetView = [toVC animationFromTargetView];
    
    UIImageView *feedView;
    for (UIView *subview in toTargetView.subviews ) {
        if ([subview isKindOfClass:[HomepageFindView class]]) {
//            feedView = [subview snapshotViewAfterScreenUpdates:YES];
//            feedView = (HomepageFindView *)[subview resizableSnapshotViewFromRect:CGRectMake(0, 0, subview.width, subview.height) afterScreenUpdates:YES withCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
//            feedView = (HomepageFindView *)subview;
            feedView = [[UIImageView alloc] initWithImage:[subview toImage]];
            break;
        }
    }
    
    fromTargetView.hidden = YES;
    toTargetView.hidden = YES;
    FeedDetailView *testView = [[FeedDetailView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    testView.model = ((FeedDetailVC *)fromVC).model;
//    UIView *tempView = [testView snapshotViewAfterScreenUpdates:YES];
//    UIView *tempView = [testView resizableSnapshotViewFromRect:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) afterScreenUpdates:YES withCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
//    UIView *tempView = testView;
//    UIView *tempView = (UIView *)[testView toImage];
    UIImageView *tempView = [[UIImageView alloc] initWithImage:[testView toImage]];
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
    
//    [[transitionContext containerView] addSubview:toView];
//    [[transitionContext containerView] addSubview:totalView];
//    toView.alpha = 0;

    //坐标转换
    UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;
    CGPoint fromTargetPoint = [fromTargetView convertPoint:fromTargetView.frame.origin toView:keyWindow];
    CGPoint toTargetPoint = [toTargetView convertPoint:toTargetView.frame.origin toView:keyWindow];
    CGFloat w = feedView.width;
    CGFloat h = feedView.height;
    //view范围
    totalView.frame = CGRectMake(tempRect.origin.x, tempRect.origin.y, tempRect.size.width, tempRect.size.height);
    //前一个页面view
    feedView.frame = CGRectMake(0,88, SCREEN_WIDTH, SCREEN_WIDTH / w * h);
    feedView.alpha = 0.5;
    //后一个页面view
    tempView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    tempView.alpha = 1;
    
    [[transitionContext containerView] addSubview:toView];
    [[transitionContext containerView] addSubview:totalView];
    [keyWindow addSubview:totalView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        feedView.frame = CGRectMake(0, 0, w, h);
        feedView.alpha = 1;
        tempView.frame = CGRectMake(0, - ((NavBarHeight + StatusBarHeight) / SCREEN_WIDTH * w), w, SCREEN_HEIGHT / SCREEN_WIDTH * w);
        tempView.alpha = 0;
        totalView.frame = CGRectMake(toTargetPoint.x, toTargetPoint.y, w,h);
    } completion:^(BOOL finished) {
        fromTargetView.hidden = NO;
        toTargetView.hidden = NO;
        [totalView removeFromSuperview];
        [testView removeFromSuperview];
        [feedView removeFromSuperview];
        [tempView removeFromSuperview];
        [transitionContext containerView].backgroundColor = containViewColor;
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
