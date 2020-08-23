//
//  HomepageFindCell.m
//  Demo3
//
//  Created by 江一川 on 2020/8/12.
//  Copyright © 2020 江一川. All rights reserved.
//

#import "HomepageFindCell.h"
#import "HomepageFindView.h"
#import "UIView+Additions.h"
#import "HomepageFindLayout.h"

@implementation HomepageFindCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    _feedView = [[HomepageFindView alloc] init];
    [self.contentView addSubview:_feedView];
    
}

- (void)setLayout:(HomepageFindLayout *)layout {
    _layout = layout;
    self.height = [_layout getCardViewHeightAtIndex:_indexPath];
    self.contentView.height = [_layout getCardViewHeightAtIndex:_indexPath];
    _feedView.width = self.width;
    _feedView.height = self.height;
    _feedView.layout = _layout;
}

- (void)setIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
    _feedView.indexPath = _indexPath;
}

@end
