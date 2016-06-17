//
//  GoodCategory.m
//  购物车实例
//
//  Created by family on 16/6/7.
//  Copyright © 2016年 family. All rights reserved.
//

#import "GoodCategory.h"
#import "GoodsModel.h"
#import "MJExtension.h"
@implementation GoodCategory
+(NSDictionary *)mj_objectClassInArray
{
    return @{
             @"goodsCategoryGoods" : [GoodsModel class]
             };
}
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"goodsCategoryName" : @"name",
             @"goodsCategoryDesc" : @"desciption",
             @"goodsCategoryGoods" : @"goods"
             };
}
@end
