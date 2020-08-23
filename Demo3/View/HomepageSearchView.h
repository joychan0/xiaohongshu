//
//  HomepageSearchView.h
//  Demo3
//
//  Created by 江一川 on 2020/8/12.
//  Copyright © 2020 江一川. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//点击搜索的回调
typedef void(^THomePageSearchTapCallback)(void);


@interface HomepageSearchView : UICollectionReusableView

/** 搜索/放大镜 是否显示中心 (默认中心) */
@property (nonatomic, assign) BOOL showCenter;

@property (nonatomic,copy) THomePageSearchTapCallback callback;

@property (nonatomic, copy) NSString *placeholder;


@end

NS_ASSUME_NONNULL_END
