//
//  HomepageFindVC.m
//  Demo3
//
//  Created by 江一川 on 2020/8/12.
//  Copyright © 2020 江一川. All rights reserved.
//

#import "HomepageFindVC.h"
#import "JXCategoryView.h"
#import "HomepageFindCategoryVC.h"
#import "Header.h"
#import "UIView+Additions.h"
#import "FeedDetailVC.h"

@interface HomepageFindVC ()<
JXCategoryViewDelegate,
JXCategoryListContainerViewDelegate,
HomepageFindCategoryDelegate
>

/** 分页指示器 */
@property (nonatomic, strong) JXCategoryTitleView *categoryView;
/** 列表容器 */
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;
/** 标题数字 */
@property (nonatomic, copy) NSArray<NSString *> *titleList;
@end

@implementation HomepageFindVC{
    BOOL _showCategoryView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    _showCategoryView = YES;
    _titleList = @[@"推荐",@"视频",@"直播",@"影视综艺",@"体育",@"游戏",@"知识",@"搞笑",@"Vlog",@"音乐",@"学习",@"萌宠",@"美食",@"护肤",@"摄影",@"穿搭",@"家居家装",@"科技数码",@"汽车",@"潮鞋",@"发型",@"旅游",@"运动健身"];
    [self setupView];
    [self loadAllData];
}

#pragma mark — 添加view
- (void)setupView {
    [self.view addSubview:self.categoryView];
    [self.view addSubview:self.listContainerView];
    
}

#pragma mark — 请求数据
- (void)loadAllData {
    [self.categoryView reloadData];
}


#pragma mark — 代理
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    HomepageFindCategoryVC *vc = [[HomepageFindCategoryVC alloc] initWithType:@" "];
    [self addChildViewController:vc];
    vc.delegate = self;
    return vc;
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return 23;
}
    

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    //侧滑手势处理

}


#pragma mark — HomepageCategoryDelegate
- (void)HomepageFindCategoryScrollViewDidScroll:(UIScrollView *)scrollView showCategory:(BOOL)showCategory{
    if (showCategory) {
        [self dismissCategory];
    } else {
        [self showCategory];
    }
    
}
#pragma mark — 重写
- (UIView *)animationFromTargetView {
    return [[self currentFeedListVC] animationFromTargetView];
}

#pragma mark — 设置category是否显示
- (void)showCategory {
    if (_showCategoryView) {
        _showCategoryView = NO;
        self.listContainerView.scrollView.scrollEnabled = NO;
        [UIView animateWithDuration:0.25 animations:^{
            self.categoryView.frame = CGRectMake( 0, -40, SCREEN_WIDTH, 40);
            self.listContainerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.view.height - 40);
        }completion:^(BOOL finished) {
            
        }];
    }

}

- (void)dismissCategory {
    if (!_showCategoryView) {
        _showCategoryView = YES;
        self.listContainerView.scrollView.scrollEnabled = YES;
        [UIView animateWithDuration:0.25 animations:^{
            self.categoryView.frame = CGRectMake( 0, 0, SCREEN_WIDTH, 40);
            self.listContainerView.frame = CGRectMake(0, 40, SCREEN_WIDTH, self.view.height - 40);
        }completion:^(BOOL finished) {
            
        }];
    }

}

//返回当前显示的vc
- (HomepageFindCategoryVC *)currentFeedListVC {
    HomepageFindCategoryVC *vc = [self.listContainerView.validListDict objectForKey:[NSNumber numberWithInteger:self.categoryView.selectedIndex]];
    return vc;
}

#pragma mark — 懒加载
- (JXCategoryTitleView *)categoryView{
    if (!_categoryView) {
        _categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        _categoryView.delegate = self;
        _categoryView.defaultSelectedIndex = 0;
        // 2、添加并配置指示器
        // 标题 共23个分类
        _categoryView.titles = _titleList;
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
        _categoryView.titleFont = [UIFont systemFontOfSize:14];;
        _categoryView.titleSelectedFont = [UIFont boldSystemFontOfSize:14];
        //title颜色渐变
        _categoryView.titleColorGradientEnabled = YES;
        _categoryView.contentEdgeInsetLeft = 16.f;
        _categoryView.contentEdgeInsetRight = 16.f;
        _categoryView.cellSpacing = 28.f;
        _categoryView.listContainer = self.listContainerView;
    }
    return _categoryView;
}

- (JXCategoryListContainerView *)listContainerView{
    if (!_listContainerView) {
        _listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_CollectionView delegate:self];
        _listContainerView.frame = CGRectMake(0, 40, SCREEN_WIDTH, self.view.height - 40);
    }
    return _listContainerView;
}
@end
