//
//  PublicManager.m
//  Demo3
//
//  Created by 江一川 on 2020/8/14.
//  Copyright © 2020 江一川. All rights reserved.
//

#import "PublicManager.h"
#import "HomepageFindListModel.h"

@implementation PublicManager


+ (instancetype)shareManager {
    static PublicManager *_sharedSingleton = nil;
    static dispatch_once_t onceToken;
    //diapathconce 只执行一次
    dispatch_once(&onceToken, ^{
        //调用父类的allocWithZone方法
        _sharedSingleton = [[super allocWithZone:NULL] init];
    });
    return _sharedSingleton;
}

//防止外部调用alloc 或者new
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [PublicManager shareManager];
}

//防止外部调用copy
- (id)copyWithZone:(nullable NSZone *)zone {
    return [PublicManager shareManager];
}

- (id)mutableCopyWithZone:(nullable NSZone *)zone {
    return [PublicManager shareManager];
}

- (NSArray<HomepageFindListModel *> *)getDataFromJSONWithType:(NSString *)type page:(NSInteger)page{
    NSString *path=[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"homefeed%ld",page] ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    //设置model文件
    HomepageFindListDataModel *dataModel = [[HomepageFindListDataModel alloc] initWithData:data error:nil];
    
    return dataModel.data;
}

@end
