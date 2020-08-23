//
//  MyTabbarVC.m
//  Demo3
//
//  Created by 江一川 on 2020/8/11.
//  Copyright © 2020 江一川. All rights reserved.
//

#import "MyTabbarVC.h"

@interface MyTabbarVC ()<UITabBarDelegate>

/** 记录当前所选的tabbaritem */
@property (nonatomic, assign) NSInteger indexFlag;

@end

@implementation MyTabbarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.indexFlag = 0;
    // Do any additional setup after loading the view.
}



#pragma mark — 代理
//点击tabBarItem触发
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    //放大效果
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    //速度控制函数，控制动画运行的节奏
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = 0.2;       //执行时间
    animation.repeatCount = 1;      //执行次数
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;           //保证动画效果延续
    animation.fromValue = [NSNumber numberWithFloat:1.0];   //初始伸缩倍数
    animation.toValue = [NSNumber numberWithFloat:1.2];     //结束伸缩倍数
    
    //缩小
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    //速度控制函数，控制动画运行的节奏
    animation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation2.duration = 0.2;       //执行时间
    animation2.repeatCount = 1;      //执行次数
    animation2.removedOnCompletion = NO;
    animation2.fillMode = kCAFillModeForwards;           //保证动画效果延续
    animation2.fromValue = [NSNumber numberWithFloat:1.2];   //初始伸缩倍数
    animation2.toValue = [NSNumber numberWithFloat:1];     //结束伸缩倍数
    
    NSInteger index = [self.tabBar.items indexOfObject:item];
    
    NSMutableArray *arry = [NSMutableArray array];
    for (UIView *btn in self.tabBar.subviews) {
        if ([btn isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
             [arry addObject:btn];
        }
    }

    if (index != self.indexFlag) {
        [[arry[self.indexFlag] layer] addAnimation:animation2 forKey:@"animation2"];
        [[arry[index] layer] addAnimation:animation forKey:@"animation"];
    }
    
    
    self.indexFlag = index;
}



@end
