//
//  FeedDetailNavView.m
//  Demo3
//
//  Created by 江一川 on 2020/8/20.
//  Copyright © 2020 江一川. All rights reserved.
//

#import "FeedDetailNavView.h"

@interface FeedDetailNavView ()

/** 返回按钮 */
@property (nonatomic, strong) UIButton *btnBack;

@end



@implementation FeedDetailNavView

#pragma mark — 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}

#pragma mark — setupview
- (void)setupView {
}


#pragma mark — 懒加载



@end
