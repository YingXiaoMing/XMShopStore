//
//  ShopCarViewController.h
//  购物车实例
//
//  Created by family on 16/6/7.
//  Copyright © 2016年 family. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopCarViewController : UIViewController
//订单的总数量
@property(nonatomic,assign)NSInteger totalOrderCount;
//订单的总价
@property(nonatomic,assign)double totalPrice;
//订单数据
@property(nonatomic,strong)NSMutableArray *orderArray;
@end
