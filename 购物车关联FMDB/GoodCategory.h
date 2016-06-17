//
//  GoodCategory.h
//  购物车实例
//
//  Created by family on 16/6/7.
//  Copyright © 2016年 family. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodCategory : NSObject
@property(nonatomic,copy)NSString *goodsCategoryName;
@property(nonatomic,copy)NSString *goodsCatgotyDesc;
@property(nonatomic,strong)NSMutableArray *goodsCategoryGoods;

@end
