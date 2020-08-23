//
//  Header.h
//  Demo3
//
//  Created by 江一川 on 2020/8/11.
//  Copyright © 2020 江一川. All rights reserved.
//

#ifndef Header_h
#define Header_h

/** 颜色 */
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
/** 当前屏幕宽度 */
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
/***  当前屏幕高度 */
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
/** 设置字体大小 */
#define Font(size) [UIFont systemFontOfSize: size]
/** 状态栏高度 */
#define StatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
/** 导航栏高度 */
#define NavBarHeight 44.0
/** 缩放比例 */
#define SCREEN_SCALE SCREEN_WIDTH / 375.0

#define kIs_iphone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define kIs_iPhoneX SCREEN_WIDTH >=375.0f && SCREEN_HEIGHT >=812.0f&& kIs_iphone


/** tabbar */
#define TabBarHeight (CGFloat)(kIs_iPhoneX?(49.0 + 34.0):(49.0))


#endif /* Header_h */
