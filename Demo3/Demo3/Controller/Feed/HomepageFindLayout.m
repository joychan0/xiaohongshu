//
//  HomepageFindLayout.m
//  Demo3
//
//  Created by 江一川 on 2020/8/13.
//  Copyright © 2020 江一川. All rights reserved.
//



#import "HomepageFindLayout.h"
#import "Header.h"
#import "HomepageFindListModel.h"
#import "CoreText/CoreText.h"

//默认行间距
#define DefaultRowMargin 5
//默认列间距
#define DefaultColumnMargin 5
//默认列数
#define DefaultColumsCounts 2
//默认item宽度
#define DefaultWidth SCREEN_WIDTH
//间距
#define DefaultEdgeInsets UIEdgeInsetsMake(0, 5, 5, 5)

@implementation HomepageFindFeedHeight

@end





@interface HomepageFindLayout()
/** 每一列的最大Y值 */
@property (nonatomic, strong) NSMutableArray *columnMaxYs;
/** 存放所有cell的布局属性 */
@property (nonatomic, strong) NSMutableArray *attrsArray;
/** 高度 */
@property (nonatomic, strong) NSMutableArray<HomepageFindFeedHeight *> *heightArray;
/** cell宽度 */
@property (nonatomic, assign) CGFloat cellWidth;
@end


@implementation HomepageFindLayout {
    CGFloat TotalHeight;
}

#pragma mark — 实现内部的方法
- (CGSize)collectionViewContentSize {
    //最长一列的y值
    CGFloat destMaxY = [self.columnMaxYs[0] doubleValue];
    for (NSUInteger i = 1; i < _columnMaxYs.count; i++) {
        CGFloat columnMaxY = [_columnMaxYs[i] doubleValue];
        if (destMaxY < columnMaxY) {
            destMaxY = columnMaxY;
        }
    }
    return CGSizeMake(0, destMaxY + DefaultEdgeInsets.bottom);
}

- (void)prepareLayout {
    [super prepareLayout];
    
    //重置最大Y值
    [self.columnMaxYs removeAllObjects];
    for (int i = 0; i < DefaultColumsCounts; i++) {
        [self.columnMaxYs addObject:@(DefaultEdgeInsets.top)];
    }
    //重制cell布局属性
    [self.attrsArray removeAllObjects];
    NSUInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArray addObject:attrs];
    }
    
    
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attrsArray;
}




- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    /** 计算cell的布局属性 */
    //cell宽度
    CGFloat cellW = _cellWidth;
    //cell高度
    CGFloat cellH = ((HomepageFindFeedHeight *)_heightArray[indexPath.item]).cardHeight;
    
    //获取最短那一列序号 和 Y值
    CGFloat destMaxY = [self.columnMaxYs[0] doubleValue];
    NSUInteger destColumn = 0;
    for (int i = 0; i < self.columnMaxYs.count; i++) {
        if (destMaxY > [self.columnMaxYs[i] doubleValue]) {
            destMaxY = [self.columnMaxYs[i] doubleValue];
            destColumn = i;
        }
    }
    
    //cell的x值
    CGFloat cellX = DefaultEdgeInsets.left + destColumn * (cellW + DefaultColumnMargin);;
    //cell的y值
    CGFloat cellY = destMaxY + DefaultRowMargin;
    //cell的frame
    attrs.frame = CGRectMake(cellX, cellY, cellW, cellH);
    
    //更新最大Y值
    self.columnMaxYs[destColumn] = @(CGRectGetMaxY(attrs.frame));
    
    return attrs;
}


//计算图片高度
- (CGFloat)_layoutImageHeightWithModel:(HomepageFindListModel *)model {
    CGFloat ImageHeight = _cellWidth / ((HomepageFindListImage *)model.images_list[0]).width * ((HomepageFindListImage *)model.images_list[0]).height;
    return ImageHeight;
}

//计算文本高度
- (CGFloat)_layoutTextHeightWithModel:(HomepageFindListModel *) model {
    CGFloat textHeight = 0;
    NSString *textStr = model.title;
    if ([textStr isEqualToString:@""]) {
        return textHeight;
    }
    CGSize lblSize = [textStr boundingRectWithSize:CGSizeMake(_cellWidth - 10, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14]} context:nil].size;
    textHeight = ceilf(lblSize.height) + 2;
    return textHeight;
}


- (void)setModelArray:(NSArray<HomepageFindListModel *> *)modelArray {
    //清空数组
    [self.heightArray removeAllObjects];
    _modelArray = modelArray;
    
    CGFloat xTotalMargin = DefaultEdgeInsets.left + DefaultEdgeInsets.right + (DefaultColumsCounts - 1) * DefaultColumnMargin;
    
    _cellWidth = (DefaultWidth - xTotalMargin) / DefaultColumsCounts;
    
    
    for (int i = 0; i < _modelArray.count; i++) {
        HomepageFindFeedHeight *feed = [HomepageFindFeedHeight new];
        CGFloat imgHeight = [self _layoutImageHeightWithModel:_modelArray[i]];
        CGFloat textHeight = [self _layoutTextHeightWithModel:_modelArray[i]];
        CGFloat avaterHeight = 35;
        feed.imgHeight = imgHeight;
        feed.textHeight = textHeight;
        feed.avaterHeight = avaterHeight;
        feed.cardHeight = imgHeight + textHeight +avaterHeight;
        [_heightArray addObject:feed];
    }
}

#pragma mark — public
//获取整体高度
- (CGFloat)getCardViewHeightAtIndex:(NSIndexPath *)indexPath {
    return ((HomepageFindFeedHeight *)_heightArray[indexPath.item]).cardHeight;;
}
//获取图片高度
- (CGFloat)getImageHeightAtIndex:(NSIndexPath *)indexPath {
    return ((HomepageFindFeedHeight *)_heightArray[indexPath.item]).imgHeight;
}
//获取卡片宽度
- (CGFloat)getCardViewWidth {
    return _cellWidth;
}
//获取文本高度
- (CGFloat)getTextHeightAtIndex:(NSIndexPath *)indexPath {
    return ((HomepageFindFeedHeight *)_heightArray[indexPath.item]).textHeight;
}

//获取图片url
- (NSURL *)getImageURLAtIndex:(NSIndexPath *)indexPath {
    NSString *urlStr = ((HomepageFindListImage *)_modelArray[indexPath.item].images_list[0]).url;
    NSURL *url = [NSURL URLWithString:urlStr];
    return url;
}
//获取头像url
- (NSURL *)getAvatarURLAtIndex:(NSIndexPath *)indexPath {
    NSString *urlStr = ((HomepageFindListUser *)_modelArray[indexPath.item].user).images;
    NSURL *url = [NSURL URLWithString:urlStr];
    return url;
}

//获取title
- (NSString *)getTitleAtIndex:(NSIndexPath *)indexPath {
    NSString *titleStr = _modelArray[indexPath.item].title;
    return titleStr;
}

//获取昵称
- (NSString *)getNickNameAtIndex:(NSIndexPath *)indexPath {
    NSString *nickName = ((HomepageFindListUser *)_modelArray[indexPath.item].user).nickname;
    return nickName;
}

- (CGFloat)getContentSize {
    CGFloat destMaxY = [self.columnMaxYs[0] doubleValue];
    for (NSUInteger i = 1; i < _columnMaxYs.count; i++) {
        CGFloat columnMaxY = [_columnMaxYs[i] doubleValue];
        if (destMaxY < columnMaxY) {
            destMaxY = columnMaxY;
        }
    }
    return destMaxY + DefaultEdgeInsets.bottom;
}
#pragma mark — 懒加载
- (NSMutableArray *)columnMaxYs{
    if (!_columnMaxYs) {
        _columnMaxYs = [[NSMutableArray alloc] init];
    }
    return _columnMaxYs;
}

- (NSMutableArray *)attrsArray{
    if (!_attrsArray) {
        _attrsArray = [[NSMutableArray alloc] init];
    }
    return _attrsArray;
}


- (NSMutableArray *)heightArray{
    if (!_heightArray) {
        _heightArray = [[NSMutableArray alloc] init];
    }
    return _heightArray;
}



@end
