//
//  HomepageFindCategoryVC.h
//  Demo3
//
//  Created by 江一川 on 2020/8/12.
//  Copyright © 2020 江一川. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXCategoryListContainerView.h"
#import "MyViewController.h"

NS_ASSUME_NONNULL_BEGIN
@class HomepageFindCell;

@protocol HomepageFindCategoryDelegate <NSObject>

@required // 必须实现的方法 默认

@optional // 可选实现的方法
- (void)HomepageFindCategoryScrollViewDidScroll:(UIScrollView *)scrollView showCategory:(BOOL)showCategory;
@end


@interface HomepageFindCategoryVC : MyViewController<JXCategoryListContentViewDelegate>
/** 代理 */
@property(nonatomic, weak) id<HomepageFindCategoryDelegate> delegate;
/** 用于动画的view */
@property (nonatomic, strong, readonly, nullable) UIView *targetView;
/** 点击的cell */
@property (nonatomic, strong) HomepageFindCell *clickedCell;
- (instancetype)initWithType:(NSString *)type;

@end

NS_ASSUME_NONNULL_END
