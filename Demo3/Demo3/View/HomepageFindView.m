//
//  HomepageFindView.m
//  Demo3
//
//  Created by 江一川 on 2020/8/12.
//  Copyright © 2020 江一川. All rights reserved.
//

#import "HomepageFindView.h"
#import "Masonry.h"
#import "UIView+Additions.h"
#import "HomepageFindLayout.h"
#import "UIImageView+WebCache.h"

@interface HomepageFindView ()

/** image */
@property (nonatomic, strong) UIImageView *ImageView;
/** title */
@property (nonatomic, strong) UILabel *titleLabel;
/** 作者头像 */
@property (nonatomic, strong) UIImageView *authorAvatar;
/** 作者昵称 */
@property (nonatomic, strong) UILabel *authorNickName;
@end

@implementation HomepageFindView

- (instancetype)init {
    if (self = [super init]) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    self.backgroundColor = [UIColor whiteColor];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 8;
    [self addSubview:self.ImageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.authorAvatar];
    [self addSubview:self.authorNickName];
}


- (void)layoutSubviews {
    [super layoutSubviews];
}


- (void)setLayout:(HomepageFindLayout *)layout {
    _layout = layout;
    _ImageView.height = [_layout getImageHeightAtIndex:_indexPath];
    _ImageView.width = self.width;
    [_ImageView sd_setImageWithURL: [_layout getImageURLAtIndex:_indexPath]];
    
    _titleLabel.width = [_layout getCardViewWidth] - 10;
    _titleLabel.left = 5;
    _titleLabel.height = [_layout getTextHeightAtIndex:_indexPath];
    _titleLabel.top = _ImageView.height + 5;
    _titleLabel.text = [_layout getTitleAtIndex:_indexPath];
    
    
    _authorAvatar.width = 20;
    _authorAvatar.height = 20;
    _authorAvatar.left = 5;
    _authorAvatar.top = _titleLabel.height + _titleLabel.top + 2;
    [_authorAvatar sd_setImageWithURL:[_layout getAvatarURLAtIndex:_indexPath]];
    
    _authorNickName.left = CGRectGetMaxX(self.authorAvatar.frame) + 5;
    _authorNickName.width = [_layout getCardViewWidth] - 30;
    _authorNickName.height = 20;
    _authorNickName.top = _titleLabel.height + _titleLabel.top + 2;
    _authorNickName.text = [_layout getNickNameAtIndex:_indexPath];
    
}

- (void)setIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
}

- (UIImageView *)ImageView{
    if (!_ImageView) {
        _ImageView = [[UIImageView alloc] init];
        _ImageView.backgroundColor = [UIColor grayColor];
    }
    return _ImageView;
}

- (UIImageView *)authorAvatar{
    if (!_authorAvatar) {
        _authorAvatar = [[UIImageView alloc] init];
        _authorAvatar.layer.masksToBounds = YES;
        _authorAvatar.layer.cornerRadius = 10;
    }
    return _authorAvatar;
}

- (UILabel *)authorNickName{
    if (!_authorNickName) {
        _authorNickName = [[UILabel alloc] init];
        _authorNickName.textColor = [UIColor blackColor];
        _authorNickName.font = [UIFont systemFontOfSize:12];
        _authorNickName.textAlignment = NSTextAlignmentLeft;
    }
    return _authorNickName;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:14];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}
@end
