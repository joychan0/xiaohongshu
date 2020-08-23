//
//  FeedDetailView.m
//  Demo3
//
//  Created by 江一川 on 2020/8/20.
//  Copyright © 2020 江一川. All rights reserved.
//

#import "FeedDetailView.h"
#import "Header.h"
#import "FeedDetailNavView.h"
#import "FeedDetailBottomView.h"
#import "FeedDetailMainView.h"
#import "Masonry.h"
#import "UIView+Additions.h"


@interface FeedDetailView ()
/** 中间内容部分 */
@property (nonatomic, strong) FeedDetailMainView *MainView;
/** 顶部自定义导航了 */
@property (nonatomic, strong) UIView *navView;
/** 返回按钮 */
@property (nonatomic, strong) UIButton *backBtn;
/** 底部评论栏 */
@property (nonatomic, strong) FeedDetailBottomView *BottomView;
@end



@implementation FeedDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}


#pragma mark — setupview
- (void)setupView {
    [self addSubview:self.MainView];
    [self addSubview:self.BottomView];
    [self addSubview:self.navView];
    
    
    _BottomView.width = self.width;
    _BottomView.height = TabBarHeight;
    _BottomView.left = 0;
    _BottomView.top = self.height - TabBarHeight;
    _BottomView.backgroundColor = [UIColor whiteColor];
    
    _MainView.left = 0;
    _MainView.width = self.width;
    _MainView.top = CGRectGetMaxY(_navView.frame);
    _MainView.height = self.height - StatusBarHeight - NavBarHeight -TabBarHeight;
    _MainView.backgroundColor = [UIColor whiteColor];
}



#pragma mark — setter
- (void)setModel:(HomepageFindListModel *)model {
    _model = model;
    _MainView.model = _model;
    
    
}



#pragma mark — action
- (void)actionBack {
    if ([self.delegate respondsToSelector:@selector(clickBackBtn)]) {
        [self.delegate clickBackBtn];
    }
}

#pragma mark — 懒加载


- (UIView *)navView{
    if (!_navView) {
        _navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, StatusBarHeight + NavBarHeight)];
        _navView.backgroundColor = [UIColor whiteColor];
        
        UIView *containView = [[UIView alloc] init];
        [_navView addSubview:containView];
        [containView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(self.navView);
            make.height.mas_equalTo(44);
        }];
        
        [containView addSubview:self.backBtn];
        [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(36);
            make.centerY.mas_equalTo(containView);
            make.left.mas_equalTo(containView).offset(16);
        }];
    }
    return _navView;
}

- (FeedDetailMainView *)MainView{
    if (!_MainView) {
        _MainView = [[FeedDetailMainView alloc] init];
    }
    return _MainView;
}


- (FeedDetailBottomView *)BottomView{
    if (!_BottomView) {
        _BottomView = [[FeedDetailBottomView alloc] init];
    }
    return _BottomView;
}


- (UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn = [UIButton new];
        _backBtn.contentMode = UIViewContentModeScaleAspectFit;
        [_backBtn addTarget:self action:@selector(actionBack) forControlEvents:UIControlEventTouchUpInside];
        [_backBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    }
    return _backBtn;
}


@end
