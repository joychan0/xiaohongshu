//
//  FeedDetailView.h
//  Demo3
//
//  Created by 江一川 on 2020/8/20.
//  Copyright © 2020 江一川. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class HomepageFindListModel;

@protocol FeedDetailViewDelegate <NSObject>

@required // 必须实现的方法 默认

@optional // 可选实现的方法
- (void)clickBackBtn;

@end



@interface FeedDetailView : UIView
/** 代理 */
@property (nonatomic, weak) id<FeedDetailViewDelegate> delegate;
/** 模型 */
@property (nonatomic, strong) HomepageFindListModel *model;

@end

NS_ASSUME_NONNULL_END
