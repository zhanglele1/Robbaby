//
//  PurchaseRecordModel.m
//  WinTreasure
//
//  Created by Apple on 16/6/27.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "PurchaseRecordModel.h"

@implementation PurchaseRecordModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.productImgUrl = @"https://tse4-mm.cn.bing.net/th?id=OIP.M9271c634f71d813901afbc9e69602dcfo2&pid=15.1";
        self.productName = @"斯嘉丽·约翰逊(Scarlett Johansson),1984年11月22日生于纽约，美国女演员。";
        self.purchaseTime = @"2016:06:10 19:00";
        self.productPrice = @"999999";
        self.productQuantity = @"1";
        self.paidAmount = @"999999";
        self.purchaseStatus = 0;
    }
    return self;
}

@end
