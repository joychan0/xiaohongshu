//
//  MyNavigationController+TransitionAnimationExtension.h
//  Demo3
//
//  Created by 江一川 on 2020/8/19.
//  Copyright © 2020 江一川. All rights reserved.
//

#import "MyNavigationController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyNavigationController (TransitionAnimationExtension)

- (void)Animation_pushViewController:(UIViewController *)vc animationType:(K_AnimationTransitionType)animation;
- (void)Animation_popViewController:(UIViewController *)vc animationType:(K_AnimationTransitionType)animation;

@end

NS_ASSUME_NONNULL_END
