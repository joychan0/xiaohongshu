//
//  HomepageFindCategoryVC.m
//  Demo3
//
//  Created by 江一川 on 2020/8/12.
//  Copyright © 2020 江一川. All rights reserved.
//

#import "HomepageFindCategoryVC.h"
#import "UIView+Additions.h"
#import "Header.h"
#import "HomepageFindCell.h"
#import "HomepageFindLayout.h"
#import "HomepageFindListModel.h"
#import "PublicManager.h"
#import "MJRefresh.h"
#import "FeedDetailVC.h"
#import "MyNavigationController.h"
#import "MyNavigationController+TransitionAnimationExtension.h"

@interface HomepageFindCategoryVC ()<
UICollectionViewDelegate,
UICollectionViewDataSource,
HomepageFindLayoutDelegate
>

/** collectionView */
@property (nonatomic, strong) UICollectionView *collectionView;
/** layout */
@property (nonatomic, strong) HomepageFindLayout *layout;
/** type */
@property (nonatomic, copy) NSString *type;
/** 数据数组 */
@property (nonatomic, strong) NSMutableArray *dataArray;
/** 分页 */
@property (nonatomic, assign) NSInteger page;
/** 上拉加载 */
@property (nonatomic, strong) MJRefreshFooter *footer;
/** windowView */
@property (nonatomic, strong) UIView *windowView;
@end

@implementation HomepageFindCategoryVC {
    BOOL _isRequesting;
}

- (instancetype)initWithType:(NSString *)type {
    if (self = [super init]) {
        _type = type;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    [self setupView];
    
    MJWeakSelf;
    _footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page++;
        [weakSelf requestDataWithType:weakSelf.type];
    }];
    _isRequesting = NO;
    self.collectionView.mj_footer = _footer;
    [self requestDataWithType:_type];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
}
#pragma mark — 设置View
- (void)setupView {
    [self.view addSubview:self.collectionView];
}

#pragma mark — 请求数据
- (void)requestDataWithType:(NSString *)type{
    NSArray *array = [[PublicManager shareManager] getDataFromJSONWithType:type page:self.page];
    [self.collectionView.mj_header endRefreshing];
    [self.collectionView.mj_footer endRefreshing];
    if (self.page == 1) {
        [self.dataArray removeAllObjects];
        self.collectionView.mj_footer = _footer;
    }
    if (self.page == 10) {
        self.collectionView.mj_footer =nil;
    }
    [self.dataArray addObjectsFromArray:array];
    _layout.modelArray = _dataArray;
    [self.collectionView reloadData];
}

- (void)loadMoreData {
    if (self.page == 10) {
        return;
    }
    self.page++;
    [self requestDataWithType:_type];
}

#pragma mark —JXCategoryListContentViewDelegate
//这个方法必须实现 如果是view返回self，如果是vc返回self.view
- (UIView *)listView {
    return self.view;
}


#pragma mark — collectionViewDelegate
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomepageFindCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HomepageFindCell class]) forIndexPath:indexPath];
    cell.indexPath = indexPath;
    cell.layout = _layout;
    cell.selectedBackgroundView = nil;
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y >= 50) {
        if ([self.delegate respondsToSelector:@selector(HomepageFindCategoryScrollViewDidScroll:showCategory:)]) {
            [self.delegate HomepageFindCategoryScrollViewDidScroll:scrollView showCategory:NO];
        }
    }else if (scrollView.contentOffset.y < 50) {
        if ([self.delegate respondsToSelector:@selector(HomepageFindCategoryScrollViewDidScroll:showCategory:)]) {
            [self.delegate HomepageFindCategoryScrollViewDidScroll:scrollView showCategory:YES];
        }
    }
    
    if (scrollView.contentOffset.y >= [_layout getContentSize] - _collectionView.height - 300) {
        [self loadMoreData];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UIImageView *tempView = [[UIImageView alloc] initWithImage:[self.view toImage]];
    HomepageFindCell *cell = (HomepageFindCell *)[collectionView cellForItemAtIndexPath:indexPath];
    NSLog(@"click!!!");
    _clickedCell = cell;
    _targetView = cell.feedView;
    FeedDetailVC *vc = [FeedDetailVC new];
    vc.model = _layout.modelArray[indexPath.item];
//    UIView *tempView = [[UIApplication sharedApplication].keyWindow snapshotViewAfterScreenUpdates:YES];
//    [[UIApplication sharedApplication].keyWindow addSubview:tempView];
//    _targetView.hidden = YES;
//    vc.lastVCView = tempView;
//    [tempView removeFromSuperview];
    [(MyNavigationController *)self.navigationController Animation_pushViewController:vc animationType:KAnimationTransitionTypeScalePushMove];
//    cell.hidden = NO;
}

#pragma mark — 转场动画
- (UIView *)animationFromTargetView {
    return _targetView.superview;
}



#pragma mark — 懒加载
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        _layout = [[HomepageFindLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.height - NavBarHeight - StatusBarHeight - 37 - TabBarHeight ) collectionViewLayout:_layout];
        _collectionView.backgroundColor = UIColorFromRGB(0xF8F8F8);
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[HomepageFindCell class] forCellWithReuseIdentifier:NSStringFromClass([HomepageFindCell class])];
        MJWeakSelf;
        MJRefreshNormalHeader * mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weakSelf.page = 1;
            [weakSelf requestDataWithType:weakSelf.type];
        }];
        mj_header.lastUpdatedTimeLabel.hidden = YES;
        _collectionView.mj_header = mj_header;
        _collectionView.mj_header.isCollectionViewAnimationBug = YES;
        
    }
    return _collectionView;
}




- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}
@end
