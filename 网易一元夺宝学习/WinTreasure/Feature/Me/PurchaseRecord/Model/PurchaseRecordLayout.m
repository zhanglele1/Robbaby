//
//  PurchaseRecordLayout.m
//  WinTreasure
//
//  Created by Apple on 16/6/27.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "PurchaseRecordLayout.h"

@implementation PurchaseRecordLayout

- (instancetype)initWithModel:(PurchaseRecordModel *)model {
    self = [super init];
    if (self) {
        _model = model;
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    
}

@end
