//
//  HomepageFindListModel.h
//  Demo3
//
//  Created by 江一川 on 2020/8/13.
//  Copyright © 2020 江一川. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@class HomepageFindListUser, HomepageFindListImage, HomepageFindListModel;

@protocol HomepageFindListModel


@end

@protocol HomepageFindListImage


@end



@interface HomepageFindListDataModel : JSONModel

/** data */
@property (nonatomic, copy) NSArray<HomepageFindListModel> *data;

@end

@interface HomepageFindListModel : JSONModel

/** 创建时间 */
@property (nonatomic, assign) NSInteger timestamp;
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 描述 */
@property (nonatomic, copy) NSString *desc;
/** 图片 */
@property (nonatomic, copy) NSArray<HomepageFindListImage> *images_list;
/** 作者 */
@property (nonatomic, strong) HomepageFindListUser *user;
/** 点赞数 */
@property (nonatomic, assign) NSInteger likes;

@end

@interface HomepageFindListImage : JSONModel

/** 高 */
@property (nonatomic, assign) NSInteger height;
/** 宽 */
@property (nonatomic, assign) NSInteger width;
/** url */
@property (nonatomic, copy) NSString *url;
/** 大图url */
@property (nonatomic, copy) NSString *url_size_large;

@end

@interface HomepageFindListUser : JSONModel
/** 昵称 */
@property (nonatomic, copy) NSString *nickname;
/** 头像 */
@property (nonatomic, copy) NSString *images;

@end


NS_ASSUME_NONNULL_END
