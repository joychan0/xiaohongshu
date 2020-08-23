//
//  HomepageFindView.h
//  Demo3
//
//  Created by 江一川 on 2020/8/12.
//  Copyright © 2020 江一川. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class HomepageFindLayout;

@interface HomepageFindView : UIView

/** layout */
@property (nonatomic, strong) HomepageFindLayout *layout;
/** indexPath */
@property (nonatomic, strong) NSIndexPath *indexPath;

@end

NS_ASSUME_NONNULL_END
