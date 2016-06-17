//
//  GoodsModel.m
//  购物车实例
//
//  Created by family on 16/6/7.
//  Copyright © 2016年 family. All rights reserved.
//

#import "GoodsModel.h"
#import "MJExtension.h"
@implementation GoodsModel
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return  @{
              @"goodsId" : @"id",
              @"goodsIcon" : @"icon",
              @"goodsName" : @"name",
              @"goodsOriginalPrice" : @"originalPrice",
              @"goodsSalePrice" : @"salePrice",
              @"goodsStock" : @"stock",
              @"goodsDesc" : @"desc"
              };
}
@end
