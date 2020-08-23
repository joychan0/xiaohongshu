//
//  HomepageVC.m
//  Demo3
//
//  Created by 江一川 on 2020/8/11.
//  Copyright © 2020 江一川. All rights reserved.
//


/** 首页
 * 首页vc
 */





#import "HomepageVC.h"
#import "Header.h"
#import "JXCategoryView.h"
#import "UIView+Additions.h"
#import "HomepageSearchView.h"
#import "HomepageFindVC.h"
#import "HomepageFollowVC.h"
#import "HomepageCityVC.h"
#import "FeedDetailVC.h"

@interface HomepageVC ()<
UICollectionViewDelegate,
UICollectionViewDataSource,
JXCategoryViewDelegate
>

/** 顶部导航栏 */
@property (nonatomic, strong) UIView *navView;
/** 分页指示器 */
@property (nonatomic, strong) JXCategoryTitleView *categoryView;
/** scrollerview */
@property (nonatomic, strong) UIScrollView *scrollView;
/** 搜索栏 */
@property (nonatomic, strong) HomepageSearchView *searchView;
/** 关注vc */
@property (nonatomic, strong) HomepageFollowVC *homepageFollowVC;
/** 发现vc */
@property (nonatomic, strong) HomepageFindVC *homepageFindVC;
/** 城市vc */
@property (nonatomic, strong) HomepageCityVC *homepageCityVC;
/** 当前所在的vc */
@property (nonatomic, assign) NSInteger selectedVCIndex;
@end

@implementation HomepageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    self.view.backgroundColor = UIColorFromRGB(0xFFFFFF);
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}




#pragma mark — 设置view
- (void)setupUI {
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.navView];
    
    [self.navView addSubview:self.categoryView];

    _categoryView.contentScrollView = self.scrollView;
    
    self.searchView.frame = CGRectMake(16, StatusBarHeight + NavBarHeight + 3, SCREEN_WIDTH - 16 * 2, 30);
    [self.navView addSubview:self.searchView];
    
    _homepageFollowVC = [[HomepageFollowVC alloc] init];
    _homepageFollowVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - (StatusBarHeight + NavBarHeight + 37));
    [_scrollView addSubview:_homepageFollowVC.view];
    [self addChildViewController:_homepageFollowVC];
    
    _homepageFindVC = [[HomepageFindVC alloc] init];
    _homepageFindVC.view.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT - (StatusBarHeight + NavBarHeight + 37));
    [_scrollView addSubview:_homepageFindVC.view];
    [self addChildViewController:_homepageFindVC];
    
    _homepageCityVC = [[HomepageCityVC alloc] init];
    _homepageCityVC.view.frame = CGRectMake(SCREEN_WIDTH * 2, 0, SCREEN_WIDTH, SCREEN_HEIGHT - (StatusBarHeight + NavBarHeight + 37));
    [_scrollView addSubview:_homepageCityVC.view];
    [self addChildViewController:_homepageCityVC];
    
    self.selectedVCIndex = self.categoryView.selectedIndex;
}


#pragma mark — 代理
//点击
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    self.selectedVCIndex = index;
}

//滚动
- (void)categoryView:(JXCategoryBaseView *)categoryView didScrollSelectedItemAtIndex:(NSInteger)index {
    self.selectedVCIndex = index;
}

#pragma mark — 懒加载
- (UIView *)navView{
    if (!_navView) {
        _navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NavBarHeight + StatusBarHeight + 37)];
//        _navView.backgroundColor = [UIColor grayColor];
    }
    return _navView;
}

- (JXCategoryTitleView *)categoryView{
    if (!_categoryView) {
        _categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 200) / 2, StatusBarHeight + 5, 200, 30)];
        _categoryView.delegate = self;
        _categoryView.defaultSelectedIndex = 1;
        // 2、添加并配置指示器
        // 标题
        _categoryView.titles = @[@"关注",@"发现",@"武汉"];
        // 颜色是否渐变
        _categoryView.titleColorGradientEnabled = NO;
        // 是否有放大缩小效果
        _categoryView.titleLabelZoomEnabled = NO;
        // titleLabel缩放比例
        _categoryView.titleLabelZoomScale = 1.4;
        // titleLabel未选中颜色
        _categoryView.titleColor = UIColorFromRGB(0x999999);
        // titleLabel选中颜色
        _categoryView.titleSelectedColor = UIColorFromRGB(0x000000);
        // titleLabel的字体大小
        _categoryView.titleFont = [UIFont systemFontOfSize:16];;
        _categoryView.titleSelectedFont = [UIFont boldSystemFontOfSize:16];
        //title颜色渐变
        _categoryView.titleColorGradientEnabled = YES;
        
        JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
        // 风格：普通、京东、爱奇艺等
        lineView.lineStyle = JXCategoryIndicatorLineStyle_LengthenOffset;
        // 指示器的位置：默认bottom
        lineView.componentPosition = JXCategoryComponentPosition_Bottom;
        // 手势滚动，点击切换的时候，是否允许滚动，默认YES
        lineView.scrollEnabled = YES;
        // 爱奇艺效果专用，line滚动时x的偏移量，默认为10
        lineView.lineScrollOffsetX = 20;
        // 指示器线宽，默认与cellWidth相等(JXCategoryViewAutomaticDimension)
        lineView.indicatorWidth = 25;
        // 指示器线高，默认3
        lineView.indicatorHeight = 2;
        // 指示器线圆角，默认为高度的一半
        lineView.indicatorCornerRadius = 2;
        // 指示器线颜色
        lineView.indicatorColor = [UIColor redColor];
        
        _categoryView.indicators = @[lineView];
        
    }
    return _categoryView;
}

- (UIView *)animationFromTargetView {
    if (self.selectedVCIndex == 1) {
        return [_homepageFindVC animationFromTargetView];
    }
    return nil;
}



#pragma mark — 懒加载

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, StatusBarHeight + NavBarHeight + 37, SCREEN_WIDTH, SCREEN_HEIGHT - (StatusBarHeight + NavBarHeight + 37))];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.pagingEnabled = YES;  // 这个很关键
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 3, 0);
        _scrollView.bounces = NO;
    }
    return _scrollView;
}


- (HomepageSearchView *)searchView{
    if (!_searchView) {
        _searchView = [[HomepageSearchView alloc] initWithFrame:CGRectZero];
        _searchView.showCenter = YES;
    }
    return _searchView;
}
@end
