//
//  PublicManager.h
//  Demo3
//
//  Created by 江一川 on 2020/8/14.
//  Copyright © 2020 江一川. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomepageFindListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PublicManager : NSObject

+ (instancetype)shareManager;

- (NSArray<HomepageFindListModel *> *)getDataFromJSONWithType:(NSString *)type page:(NSInteger)page;


@end

NS_ASSUME_NONNULL_END
