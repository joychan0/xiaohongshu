//
//  FeedDetailVC.m
//  Demo3
//
//  Created by 江一川 on 2020/8/18.
//  Copyright © 2020 江一川. All rights reserved.
//

#import "FeedDetailVC.h"
#import "Header.h"
#import "FeedDetailNavView.h"
#import "FeedDetailBottomView.h"
#import "FeedDetailMainView.h"
#import "Masonry.h"
#import "UIView+Additions.h"
#import "FeedDetailView.h"
#import "HomepageFindListModel.h"
#import "MyNavigationController+TransitionAnimationExtension.h"

@interface FeedDetailVC () <FeedDetailViewDelegate>

/** 整体view */
@property (nonatomic, strong) FeedDetailView *totalView;
/** 手势 */
@property (nonatomic, strong) UIPanGestureRecognizer *panGestureReconizer;

@end

@implementation FeedDetailVC

#pragma mark — 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    _lastPoint = CGPointMake(0, 0);
    _lastRect = self.view.frame;
    [self.view addGestureRecognizer:self.panGestureReconizer];
    [self setupView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view.superview bringSubviewToFront:self.view];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}


#pragma mark — setupview
- (void)setupView {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.totalView];
    
}


- (UIView *)animationFromTargetView {
    return self.totalView;
}


- (void)pan:(UIPanGestureRecognizer *)gestur{
    CGPoint clickPosition = [gestur translationInView:self.view];
    NSLog(@"%d::%d",(int)clickPosition.x,(int)clickPosition.y);
    UIView *tempView = [[UIView alloc] init];
    if (gestur.state == UIGestureRecognizerStateBegan) {
        NSLog(@"began");
        
        [tempView addSubview:_lastVCView];
        
        [self.view.superview insertSubview:tempView atIndex:0];

        _lastPoint = CGPointMake(0, 0);

    } else if (gestur.state == UIGestureRecognizerStateChanged) {
        NSLog(@"changed");
        tempView.left = tempView.left + clickPosition.x;
        tempView.top = tempView.top + clickPosition.y;
        CGFloat scale = 0.5;
        self.view.left += (clickPosition.x  - _lastPoint.x) * scale;
        self.view.top += (clickPosition.y - _lastPoint.y) *scale;

        _lastPoint = clickPosition;
    } else if (gestur.state == UIGestureRecognizerStateEnded) {
        NSLog(@"END");
        _lastPoint = clickPosition;
        _lastRect = self.view.frame;
        [_lastVCView removeFromSuperview];
        [tempView removeAllSubViews];
        [tempView removeFromSuperview];
        if (self.view.left > 50) {
            [self clickBackBtn];
        } else  {
            _lastPoint = CGPointMake(0, 0);
            self.view.left = 0;
            self.view.top = 0;
        }
    }
}


#pragma mark — setter
- (void)setModel:(HomepageFindListModel *)model {
    _model = model;
    _totalView.model = _model;
    
}

#pragma mark — action
- (void)clickBackBtn {
    [((MyNavigationController *)self.navigationController) Animation_popViewController:self animationType:KAnimationTransitionTypeScalePopMove];
}


#pragma mark — 懒加载
- (FeedDetailView *)totalView{
    if (!_totalView) {
        _totalView = [[FeedDetailView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
        _totalView.delegate = self;
        _totalView.model = _model;
    }
    return _totalView;
}



- (UIPanGestureRecognizer *)panGestureReconizer{
    if (!_panGestureReconizer) {
        _panGestureReconizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    }
    return _panGestureReconizer;
}

- (void)dealloc
{
    
}

@end
