//
//  MyNavigationController.h
//  Demo3
//
//  Created by 江一川 on 2020/8/18.
//  Copyright © 2020 江一川. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, K_AnimationTransitionType) {
    KAnimationTransitionTypeNone = 1,       //不自定义动画,使用系统的
    KAnimationTransitionTypeScalePushMove = 2,      //放大动画
    KAnimationTransitionTypeScalePopMove = 3,      //缩小动画
};


@interface MyNavigationController : UINavigationController

/** 动画类型 */
@property (nonatomic, assign) K_AnimationTransitionType type;
@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;


@end

NS_ASSUME_NONNULL_END
