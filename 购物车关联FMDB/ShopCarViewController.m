//
//  ShopCarViewController.m
//  购物车实例
//
//  Created by family on 16/6/7.
//  Copyright © 2016年 family. All rights reserved.
//

#import "ShopCarViewController.h"
#import "MJExtension.h"
#import "GoodCategory.h"
#import "MenuTableViewCell.h"
#import "GoodsModel.h"
#import "YTKKeyValueStore.h"
#define XMWidth self.view.frame.size.width
#define XMHeight self.view.frame.size.height
#define XMColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
@interface ShopCarViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property(nonatomic,strong)UITableView *leftTableView;
@property(nonatomic,strong)UITableView *rightTableView;
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,assign)BOOL isRealte;
@property(nonatomic,strong)YTKKeyValueStore *store;
@end

@implementation ShopCarViewController
static NSString *const cellID = @"menuCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购物车";
    self.view.backgroundColor = [UIColor whiteColor];
    //懒加载的方式来加载tableView
    [self checkTable];
    [self leftTableView];
    [self rightTableView];

    self.isRealte = YES;
}
-(UITableView *)leftTableView
{
    if (_leftTableView == nil) {
        self.leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, XMWidth * 0.25, XMHeight - 64 - 50)];
        self.leftTableView.backgroundColor = [UIColor whiteColor];
        self.leftTableView.dataSource = self;
        self.leftTableView.delegate = self;
        [self.view addSubview:self.leftTableView];
    }
    return _leftTableView;
}
-(UITableView *)rightTableView
{
    if (_rightTableView == nil) {
        self.rightTableView = [[UITableView alloc]initWithFrame:CGRectMake(XMWidth * 0.25, 64, XMWidth * 0.75, XMHeight - 64 -50)];
        self.rightTableView.delegate = self;
        self.rightTableView.dataSource = self;
        self.rightTableView.backgroundColor = [UIColor whiteColor];
        [self.rightTableView registerNib:[UINib nibWithNibName:NSStringFromClass([MenuTableViewCell class]) bundle:nil] forCellReuseIdentifier:cellID];
        
        [self.view addSubview:self.rightTableView];
    }
    return _rightTableView;
}
-(void)checkTable
{
    YTKKeyValueStore *store = [[YTKKeyValueStore alloc]initDBWithName:@"test.db"];
    self.store = store;
    BOOL isStore = [store isTableExists:@"data_table"];
    if (isStore) {//数据库里面是否有这张表
        self.dataArray = [[NSArray alloc]init];
//        self.dataArray = [store getModelObjectById:@"name" className:[GoodCategory class] fromTable:@"data_table"];
        self.dataArray = [store getModelArrayByclassName:[GoodCategory class] fromTable:@"data_table" arrayCount:5];
        NSLog(@"数据库取出来的文件是%@",self.dataArray);
        
        
    }else {
        [self loadData];
    }
}
-(void)loadData
{
    self.dataArray = [[NSArray alloc]init];
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"goods" ofType:@"json"];
    NSData *data = [[NSData alloc]initWithContentsOfFile:filePath];
    NSError *error;
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSString *tableName = @"data_table";
    [self.store createTableWithName:tableName];
    self.dataArray = [GoodCategory mj_objectArrayWithKeyValuesArray:array];
    NSLog(@"我想要的数据是%@",self.dataArray);
    [self.store putModelObjectArray:self.dataArray intoTable:tableName];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftTableView) {
        return 40;
    }else if (tableView == self.rightTableView) {
        return 90;
    }else{
        return 50;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == self.rightTableView) {
        return 30;
    }else{
        return 0;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == self.rightTableView) {
        UIView *backView = [[UIView alloc]init];
        backView.backgroundColor = XMColor(240, 240, 240);
        backView.frame = CGRectMake(0, 0, tableView.frame.size.width, 30);
        backView.alpha = 0.7;
        UILabel *label = [[UILabel alloc]initWithFrame:backView.bounds];
        GoodCategory *category = self.dataArray[section];
        [label setText:category.goodsCategoryName];
        [backView addSubview:label];
        return backView;
    }else{
        return nil;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftTableView) {
            [self.leftTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionMiddle];
            _isRealte = NO;
            //点击右边,左边跟着滚动
            [self.rightTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:indexPath.row] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
}
-(void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section
{
    if (_isRealte) {
        NSInteger topCellSection = [[[tableView indexPathsForVisibleRows]firstObject]section];
        if (tableView == self.rightTableView) {
            [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:topCellSection inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        }
    }
}
-(void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section
{
    if (_isRealte) {
        NSInteger topCellSection = [[[tableView indexPathsForVisibleRows]firstObject]section];
        if (tableView == self.rightTableView) {
            [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:topCellSection inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        }
    }
}
#pragma mark - UISrcollViewDelegate
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    _isRealte = YES;
}
-(NSMutableArray *)orderArray
{
    if (!_orderArray) {
        _orderArray = [NSMutableArray array];
    }
    return _orderArray;
}


#pragma mark -UITableViewDataSource,UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.leftTableView) {
        return 1;
    }else if (tableView == self.rightTableView){
        return self.dataArray.count;
    }else{
        return 1;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    GoodCategory *goodsCategory = self.dataArray[section];
    
    if (tableView == self.leftTableView) {
        return self.dataArray.count;
    }else if (tableView == self.rightTableView){
        return goodsCategory.goodsCategoryGoods.count;
    }else{
        return self.orderArray.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftTableView) {
        static NSString *ID = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            UIView *backgroundView = [[UIView alloc]initWithFrame:cell.bounds];
            backgroundView.backgroundColor = [UIColor whiteColor];
            cell.selectedBackgroundView = backgroundView;
            cell.backgroundColor = XMColor(240, 240, 240);
            UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 6, 40)];
            lineView.backgroundColor = [UIColor orangeColor];
            [backgroundView addSubview:lineView];
        }
        GoodCategory *category = self.dataArray[indexPath.row];
        cell.textLabel.text = category.goodsCategoryName;
        return cell;
    }else if (tableView == self.rightTableView) {
        MenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        GoodCategory *goodCategory = self.dataArray[indexPath.section];
        cell.model = goodCategory.goodsCategoryGoods[indexPath.row];
        return cell;
    }else{
        return nil;
    }
}












@end
