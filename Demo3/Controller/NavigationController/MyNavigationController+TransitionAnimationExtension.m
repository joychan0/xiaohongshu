//
//  MyNavigationController+TransitionAnimationExtension.m
//  Demo3
//
//  Created by 江一川 on 2020/8/19.
//  Copyright © 2020 江一川. All rights reserved.
//

#import "MyNavigationController+TransitionAnimationExtension.h"

@implementation MyNavigationController (TransitionAnimationExtension)

- (void)Animation_pushViewController:(UIViewController *)vc animationType:(K_AnimationTransitionType)animation {
    if (animation == KAnimationTransitionTypeNone) {
        [self c_noneAnimationPushViewController:vc];
    }else if (animation == KAnimationTransitionTypeScalePushMove) {
        [self c_magicMoveAnimationPushViewController:vc];
    }
}

- (void)Animation_popViewController:(UIViewController *)vc animationType:(K_AnimationTransitionType)animation {
    if (animation == KAnimationTransitionTypeScalePopMove) {
        [self c_magicMoveAnimationPopViewController];
    } else if (animation == KAnimationTransitionTypeNone) {
        [self c_noneAnimationPopViewController];
    }

}

- (void)c_magicMoveAnimationPushViewController:(UIViewController *)vc {
    self.type = KAnimationTransitionTypeScalePushMove;
    [self pushViewController:vc animated:YES];
}

- (void)c_noneAnimationPushViewController:(UIViewController *)vc {
    [self pushViewController:vc animated:YES];
}

- (void)c_magicMoveAnimationPopViewController {
    self.type = KAnimationTransitionTypeScalePopMove;
    [self popViewControllerAnimated:YES];
}

- (void)c_noneAnimationPopViewController {
    [self popViewControllerAnimated:YES];
}
@end
