//
//  HomepageFindLayout.h
//  Demo3
//
//  Created by 江一川 on 2020/8/13.
//  Copyright © 2020 江一川. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class HomepageFindListModel;

@protocol HomepageFindLayoutDelegate <NSObject>

@required // 必须实现的方法 默认


@optional // 可选实现的方法

@end

@interface HomepageFindFeedHeight : NSObject

/** 图片高度 */
@property (nonatomic, assign) CGFloat imgHeight;
/** 文本高度 */
@property (nonatomic, assign) CGFloat textHeight;
/** 头像高度 */
@property (nonatomic, assign) CGFloat avaterHeight;
/** 整体高度 */
@property (nonatomic, assign) CGFloat cardHeight;

@end




@interface HomepageFindLayout : UICollectionViewLayout

/** 代理 */
@property (nonatomic, weak) id<HomepageFindLayoutDelegate> delegate;
/** 模型 */
@property (nonatomic, copy) NSArray<HomepageFindListModel *> *modelArray;


/// 获取单个卡片整体高度
/// @param indexPath 序号
- (CGFloat)getCardViewHeightAtIndex:(NSIndexPath *)indexPath;

/// 获取单个卡片图片的高度
/// @param indexPath 序号
- (CGFloat)getImageHeightAtIndex:(NSIndexPath *)indexPath;

/// 获取单个卡片文本的高度
/// @param indexPath 序号
- (CGFloat)getTextHeightAtIndex:(NSIndexPath *)indexPath;

/// 获取单个卡片的宽度
- (CGFloat)getCardViewWidth;

/// 获取卡片大图的url
/// @param indexPath 序号
- (NSURL *)getImageURLAtIndex:(NSIndexPath *)indexPath;

/// 获取标题
/// @param indexPath 序号
- (NSString *)getTitleAtIndex:(NSIndexPath *)indexPath;

/// 获取头像url
/// @param indexPath 序号
- (NSURL *)getAvatarURLAtIndex:(NSIndexPath *)indexPath;

/// 获取昵称
/// @param indexPath 序号
- (NSString *)getNickNameAtIndex:(NSIndexPath *)indexPath;

- (CGFloat)getContentSize;

@end

NS_ASSUME_NONNULL_END
