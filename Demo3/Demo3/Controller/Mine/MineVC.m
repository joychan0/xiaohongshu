//
//  MineVC.m
//  Demo3
//
//  Created by 江一川 on 2020/8/11.
//  Copyright © 2020 江一川. All rights reserved.
//

#import "MineVC.h"
#import "Header.h"

@interface MineVC ()

@end

@implementation MineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我";
    [self.navigationController setNavigationBarHidden:YES];
    self.view.backgroundColor = UIColorFromRGB(0xFFFFFF);
}


@end
