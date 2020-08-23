//
//  FeedDetailVC.h
//  Demo3
//
//  Created by 江一川 on 2020/8/18.
//  Copyright © 2020 江一川. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyViewController.h"

NS_ASSUME_NONNULL_BEGIN
@class HomepageFindListModel;

@interface FeedDetailVC : MyViewController
/** 模型 */
@property (nonatomic, strong) HomepageFindListModel *model;
/** 上一个页面View */
@property (nonatomic, strong) UIImageView *lastVCView;
/**  */
@property (nonatomic, strong) UIView *maskView;
/** mask位置 */
@property (nonatomic, assign) CGRect maskRect;
/** point */
@property (nonatomic, assign) CGPoint lastPoint;
/** cgrect */
@property (nonatomic, assign) CGRect lastRect;
@end

NS_ASSUME_NONNULL_END
