//
//  TreasureRecordLayout.m
//  WinTreasure
//
//  Created by Apple on 16/6/2.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "TreasureRecordLayout.h"

@implementation TreasureRecordLayout

- (instancetype)initWithModel:(TreasureRecordModel *)model {
    self = [super init];
    if (self) {
        _model = model;
        [self layout];
    }
    return self;
}

- (void)layout {
    _marginTop = kProductNameLabelPadding;
    _nameHeight = 0;
    _periodNumberHeight = 0;
    _participateHeight = 0;
    _imgHeight = kProductImgViewWidth;
    _descriptionHeight = kDescriptionViewHeight;
    [self layoutName];
    [self layoutPeriodNumber];
    [self layoutPaticipateTimes];
    
    _productViewHeight = _imgHeight>(_nameHeight+_periodNumberHeight+_participateHeight+kProductNameLabelPadding*2) ? (_imgHeight+kProductImgViewPadding*2) : (_nameHeight+_periodNumberHeight+_participateHeight+kProductNameLabelPadding*2)+kProductImgViewPadding*2;
    _height += _marginTop;
    _height += _productViewHeight;
    _height += _descriptionHeight;
    _containerHeight = _height-kProductNameLabelPadding;
}

- (void)layoutName {
    _nameHeight = 0;
    _nameLayout = nil;
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:_model.productName];
    if (attrStr.length==0) {
        return;
    }
    attrStr.lineBreakMode = NSLineBreakByCharWrapping;
    attrStr.font = SYSTEM_FONT(15);
    attrStr.color = UIColorHex(333333);
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kProductNameLabelWidth, 16)];
    container.size = CGSizeMake(kProductNameLabelWidth, HUGE);
    _nameLayout = [YYTextLayout layoutWithContainer:container text:attrStr];
    if (!_nameLayout) {
        return;
    }
    _nameHeight = 16 * _nameLayout.rowCount;
}

- (void)layoutPeriodNumber {
    _periodNumberHeight = 0;
    _periodNumberLayout = nil;
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"期号：%@",_model.periodNumber]];
    if (attrStr.length==0) {
        return;
    }
    attrStr.lineBreakMode = NSLineBreakByCharWrapping;
    attrStr.font = SYSTEM_FONT(13);
    attrStr.color = UIColorHex(666666);
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kProductNameLabelWidth, 16)];
    container.size = CGSizeMake(kProductNameLabelWidth, HUGE);
    _periodNumberLayout = [YYTextLayout layoutWithContainer:container text:attrStr];
    if (!_periodNumberLayout) {
        return;
    }
    _periodNumberHeight = 16 * _periodNumberLayout.rowCount;
}

- (void)layoutPaticipateTimes {
    _participateHeight = 0;
    _participateLayout = nil;
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"我已参与：%@人次",_model.partInTimes]];
    if (attrStr.length==0) {
        return;
    }
    attrStr.lineBreakMode = NSLineBreakByCharWrapping;
    attrStr.font = SYSTEM_FONT(13);
    attrStr.color = UIColorHex(666666);
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kParticipateLabelWidth, 16)];
    container.size = CGSizeMake(kParticipateLabelWidth, HUGE);
    _participateLayout = [YYTextLayout layoutWithContainer:container text:attrStr];
    if (!_participateLayout) {
        return;
    }
    _participateHeight = 16 * _participateLayout.rowCount;
}


@end
