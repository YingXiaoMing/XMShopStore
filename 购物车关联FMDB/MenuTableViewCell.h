//
//  MenuTableViewCell.h
//  购物车实例
//
//  Created by family on 16/6/7.
//  Copyright © 2016年 family. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoodsModel,MenuTableViewCell;
@protocol MenuTableViewDelegate <NSObject>
-(void)menuItemCellDidClickAddbtn:(MenuTableViewCell *)itemCell;
-(void)menuItemCellDidClickMinusbtn:(MenuTableViewCell *)itemCell;

@end
@interface MenuTableViewCell : UITableViewCell
@property(nonatomic,strong)GoodsModel *model;
//下单数量
@property(nonatomic,assign)int orderCount;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property(nonatomic,weak)id<MenuTableViewDelegate> delegate;
@end
