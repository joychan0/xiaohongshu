//
//  HomepageSearchView.m
//  Demo3
//
//  Created by 江一川 on 2020/8/12.
//  Copyright © 2020 江一川. All rights reserved.
//

#import "HomepageSearchView.h"
#import "UIView+Additions.h"
#import "Header.h"

@interface HomepageSearchView()

@property (nonatomic,strong)UILabel *searchText;      //搜索

@property (nonatomic,strong)UIImageView *searchImageView;   //放大镜

@property (nonatomic,strong)UIView *bottomView;       //底图

@end

@implementation HomepageSearchView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.showCenter = YES;
        [self initUI];
    }
    return self;
}


- (void)initUI {
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.bottomView];
    [self.bottomView addSubview:self.searchImageView];
    [self.bottomView addSubview:self.searchText];
    
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    [self.bottomView addGestureRecognizer:ges];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.bottomView.frame = self.bounds;
    
    if (self.showCenter) {
        CGFloat maxWidth = self.bottomView.width - (13 + 15 + 5 + 13);
        
        CGSize size = [self.searchText sizeThatFits:CGSizeZero];
        
        CGFloat width = size.width<maxWidth ? size.width : maxWidth;
        self.searchImageView.frame = CGRectMake(self.bottomView.width / 2.f - (width/2) - 10, self.bottomView.height / 2.f - 15 / 2.f, 15, 15);
        self.searchText.frame = CGRectMake(self.searchImageView.right + 5, 0, width, self.bottomView.height);
        
    }else {
        self.searchImageView.frame = CGRectMake(13, self.bottomView.height / 2.f - 15 / 2.f, 15, 15);
        self.searchText.frame = CGRectMake(self.searchImageView.right + 5, 0, self.bottomView.width - (self.searchImageView.right + 5 + 26), self.bottomView.height);
    }
    
    
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    self.searchText.text = _placeholder;
}


//点击回调
- (void)tapClick {
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = UIColorFromRGB(0xEFEFEF);
        _bottomView.layer.cornerRadius = 16;
        _bottomView.layer.masksToBounds = YES;
    }
    return _bottomView;
}

- (UILabel *)searchText {
    if (!_searchText) {
        _searchText = [[UILabel alloc] init];
//        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"搜索" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size: 14],NSForegroundColorAttributeName: UIColorFromRGB(0xB2B2B2)}];
        
//        _searchText.attributedText = string;
        _searchText.text = @"搜索";
        _searchText.textColor = UIColorFromRGB(0x999999);
        _searchText.font = [UIFont systemFontOfSize:16];
    }
    return  _searchText;
}

- (UIImageView *)searchImageView {
    if (!_searchImageView) {
        _searchImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_search"]];
    }
    return _searchImageView;
}


@end
