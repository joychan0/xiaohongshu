//
//  HomepageFindCell.h
//  Demo3
//
//  Created by 江一川 on 2020/8/12.
//  Copyright © 2020 江一川. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class HomepageFindView, HomepageFindLayout;

@interface HomepageFindCell : UICollectionViewCell

/** view */
@property (nonatomic, strong) HomepageFindView *feedView;
/** layout */
@property (nonatomic, strong) HomepageFindLayout *layout;
/** index */
@property (nonatomic, strong) NSIndexPath *indexPath;

@end

NS_ASSUME_NONNULL_END
