//
//  MenuTableViewCell.m
//  购物车实例
//
//  Created by family on 16/6/7.
//  Copyright © 2016年 family. All rights reserved.
//

#import "MenuTableViewCell.h"
#import "GoodsModel.h"
@interface MenuTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *diskName;
@property (weak, nonatomic) IBOutlet UILabel *originPrice;
@property (weak, nonatomic) IBOutlet UILabel *price;

@property (weak, nonatomic) IBOutlet UILabel *goodsCount;
@property (weak, nonatomic) IBOutlet UIButton *minusBtn;

@end

@implementation MenuTableViewCell


-(void)setModel:(GoodsModel *)model
{
    _model = model;
    self.imageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",model.goodsIcon]];
    self.diskName.text = [NSString stringWithFormat:@"%@",model.goodsName];
    self.originPrice.text = [NSString stringWithFormat:@"原价:  %.2f",model.goodsOriginalPrice];
    self.price.text = [NSString stringWithFormat:@"¥ %.2f",model.goodsSalePrice];
    self.goodsCount.text = [NSString stringWithFormat:@"%zd",model.orderCount];
    if (model.orderCount > 0) {
        self.goodsCount.hidden = NO;
        self.minusBtn.hidden = NO;
    }else {
        self.goodsCount.hidden = YES;
        self.minusBtn.hidden = YES;
    }
    
}
- (IBAction)addBtnClick:(UIButton *)sender {
    
    //修改模型
    _model.orderCount++;
    _model.goodsStock--;
    self.goodsCount.text = [NSString stringWithFormat:@"%i",self.model.orderCount];
     NSLog(@"%@",self.goodsCount.text);
    if (_model.orderCount > 0) {
        self.goodsCount.hidden = NO;
        self.minusBtn.hidden = NO;
    }
    if ([self.delegate respondsToSelector:@selector(menuItemCellDidClickAddbtn:)]) {
        [self.delegate menuItemCellDidClickAddbtn:self];
    }
}
- (IBAction)minusBtnClick:(UIButton *)sender {
    //修改模型
    self.model.orderCount--;
    self.model.goodsStock++;
    if (self.model.orderCount <= 0) {
        self.minusBtn.hidden = YES;
        self.goodsCount.hidden = YES;
    }
    self.goodsCount.text = [NSString stringWithFormat:@"%i",self.model.orderCount];
    if ([self.delegate respondsToSelector:@selector(menuItemCellDidClickMinusbtn:)]) {
        [self.delegate menuItemCellDidClickMinusbtn:self];
    }
}

@end
