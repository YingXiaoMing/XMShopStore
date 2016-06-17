//
//  GoodsModel.h
//  购物车实例
//
//  Created by family on 16/6/7.
//  Copyright © 2016年 family. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsModel : NSObject
@property(nonatomic,copy)NSString *goodsId;
@property(nonatomic,copy)NSString *goodsIcon;
@property(nonatomic,assign)double goodsOriginalPrice;
@property(nonatomic,assign)double goodsSalePrice;
//商品的库存数量
@property(nonatomic,assign)int goodsStock;
//商品的订单数量
@property(nonatomic,assign)int orderCount;

@property(nonatomic,copy)NSString *goodsDesc;
@property(nonatomic,copy)NSString *goodsName;

@end
