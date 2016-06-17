//
//  ViewController.m
//  购物车关联FMDB
//
//  Created by family on 16/6/16.
//  Copyright © 2016年 family. All rights reserved.
//

#import "ViewController.h"
#import "ShopCarViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [[UIButton alloc]init];
    btn.frame = CGRectMake(0, 0, 100, 40);
    btn.backgroundColor = [UIColor redColor];
    btn.center = self.view.center;
    [btn setTitle:@"打开购物车" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
-(void)btnClick
{
    ShopCarViewController *shopVc = [[ShopCarViewController alloc]init];
    [self.navigationController pushViewController:shopVc animated:YES];
}

@end
