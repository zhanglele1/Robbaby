//
//  PersonalCenterMenuHeader.m
//  WinTreasure
//
//  Created by Apple on 16/6/14.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "PersonalCenterMenuHeader.h"
#import "TSMenu.h"

@interface PersonalCenterMenuHeader ()

@property (nonatomic, strong) NSArray *selectItems;

@property (nonatomic, strong) TSMenu *menu;


@end



@implementation PersonalCenterMenuHeader
- (NSArray *)selectItems {
    if (!_selectItems) {
        _selectItems = @[@"夺宝记录",@"幸运记录",@"晒单记录"];
//        _selectItems = @[@"夺宝记录",@"幸运记录",@"心愿单",@"晒单记录"];

    }
    return _selectItems;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _menu = [[TSMenu alloc]initWithDataArray:self.selectItems];
        _menu.origin = CGPointMake(0, 0);
        _menu.size = CGSizeMake(kScreenWidth, kTSMenuHeight);
        [self addSubview:_menu];
        
        
        CAShapeLayer *lineLayer = [CAShapeLayer layer];
        lineLayer.origin = CGPointMake(0, kTSMenuHeight-CGFloatFromPixel(0.5));
        lineLayer.size = CGSizeMake(self.width, CGFloatFromPixel(0.5));
        lineLayer.backgroundColor = UIColorHex(0xeeeeee).CGColor;
        [self.layer addSublayer:lineLayer];
    }
    return self;
}

+ (CGFloat)menuHeight {
    return kTSMenuHeight;
}

- (void)selectAMenu:(PersonalCenterMenuHeaderBlock)block {
    _block = block;
    @weakify(self);
    _menu.menuBlock = ^(UIButton *sender) {
        @strongify(self);
        if (self.block) {
            self.block(sender);
        }
    };
}

@end
