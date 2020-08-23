//
//  FeedDetailMainView.m
//  Demo3
//
//  Created by 江一川 on 2020/8/20.
//  Copyright © 2020 江一川. All rights reserved.
//

#import "FeedDetailMainView.h"
#import "UIView+Additions.h"
#import "HomepageFindListModel.h"
#import "Header.h"
#import "UIImageView+WebCache.h"
@interface FeedDetailMainView ()

/** 图片 */
@property (nonatomic, strong) UIImageView *imageView;

@end


@implementation FeedDetailMainView

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
    [self addSubview:self.imageView];
}

#pragma mark — setter
- (void)setModel:(HomepageFindListModel *)model {
    _model = model;
    NSString *urlStr = ((HomepageFindListImage *)_model.images_list[0]).url;
    NSURL *url = [NSURL URLWithString:urlStr];
    CGFloat width = ((HomepageFindListImage *)_model.images_list[0]).width;
    CGFloat height = ((HomepageFindListImage *)_model.images_list[0]).height;
    _imageView.width = self.width;
    _imageView.height = height / width * self.width;
    [_imageView sd_setImageWithURL:url];
    
}



#pragma mark — 懒加载
- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}
@end
