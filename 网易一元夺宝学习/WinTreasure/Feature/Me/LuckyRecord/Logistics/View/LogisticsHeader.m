//
//  LogisticsHeader.m
//  WinTreasure
//
//  Created by Apple on 16/6/28.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "LogisticsHeader.h"
#import "LogisticsModel.h"

#define kStatusViewDefaultHeight 84.0
#define kStatusViewMargin 8.0
#define kProductImgViewPadding 15.0
#define kProductImgViewWidth 45.0

@interface LogisticsHeader ()

@property (nonatomic, strong) UIImageView *productImgView;

@property (nonatomic, strong) UIImageView *addressImgView;

@property (nonatomic, strong) YYLabel *statusLabel;

@property (nonatomic, strong) YYLabel *logisticsIncLabel;

@property (nonatomic, strong) YYLabel *orderNumberLabel;

@property (nonatomic, strong) YYLabel *recieverLabel;

@property (nonatomic, strong) YYLabel *recieverPhoneLabel;

@property (nonatomic, strong) YYLabel *recieverAddressLabel;

@property (nonatomic, strong) UIView *recieverView;

@property (nonatomic, strong) UIView *statusView;


@end

@implementation LogisticsHeader

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorHex(0xE7E6E2);
        [self setupStatusView];
        [self setupRecieverView];

    }
    return self;
}

- (void)setupStatusView {
    _statusView = [UIView new];
    _statusView.origin = CGPointMake(0, 0);
    _statusView.size = CGSizeMake(kScreenWidth, kStatusViewDefaultHeight);
    _statusView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_statusView];
    
    _productImgView = [UIImageView new];
    _productImgView.origin = CGPointMake(kProductImgViewPadding, kProductImgViewPadding);
    _productImgView.size = CGSizeMake(kProductImgViewWidth, kProductImgViewWidth);
    _productImgView.backgroundColor = UIColorHex(0xeeeeee);
    [_statusView addSubview:_productImgView];
    
    _statusLabel = [YYLabel new];
    _statusLabel.origin = CGPointMake(_productImgView.right+kProductImgViewPadding, kProductImgViewPadding);
    _statusLabel.size = CGSizeMake(kScreenWidth-(_productImgView.right+kProductImgViewPadding*2), 16);
    _statusLabel.font = SYSTEM_FONT(16);
    _statusLabel.textColor = UIColorHex(333333);
    [_statusView addSubview:_statusLabel];
    
    _logisticsIncLabel = [YYLabel new];
    _logisticsIncLabel.origin = CGPointMake(_productImgView.right+kProductImgViewPadding, _statusLabel.bottom+kStatusViewMargin);
    _logisticsIncLabel.size = CGSizeMake(kScreenWidth-(_productImgView.right+kProductImgViewPadding*2), 15);
    _logisticsIncLabel.font = SYSTEM_FONT(15);
    _logisticsIncLabel.textColor = UIColorHex(666666);
    [_statusView addSubview:_logisticsIncLabel];
    
    _orderNumberLabel = [YYLabel new];
    _orderNumberLabel.origin = CGPointMake(_productImgView.right+kProductImgViewPadding, _logisticsIncLabel.bottom+kStatusViewMargin);
    _orderNumberLabel.size = CGSizeMake(kScreenWidth-(_productImgView.right+kProductImgViewPadding*2), 15);
    _orderNumberLabel.font = SYSTEM_FONT(15);
    _orderNumberLabel.textColor = UIColorHex(666666);
    [_statusView addSubview:_orderNumberLabel];
}

- (void)setupRecieverView {
    _recieverView = [UIView new];
    _recieverView.origin = CGPointMake(0, _statusView.bottom+kStatusViewMargin);
    _recieverView.size = CGSizeMake(kScreenWidth, kStatusViewDefaultHeight);
    _recieverView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_recieverView];
    
    _addressImgView = [UIImageView new];
    _addressImgView.origin = CGPointMake(kProductImgViewPadding, kProductImgViewPadding);
    _addressImgView.size = CGSizeMake(20, 20);
    _addressImgView.backgroundColor = UIColorHex(0xeeeeee);
    [_recieverView addSubview:_addressImgView];
    
    _recieverLabel = [YYLabel new];
    _recieverLabel.origin = CGPointMake(_addressImgView.right+kProductImgViewPadding, kProductImgViewPadding);
    _recieverLabel.size = CGSizeMake(kScreenWidth-(_addressImgView.right+kProductImgViewPadding*2), 15);
    _recieverLabel.font = SYSTEM_FONT(15);
    _recieverLabel.textColor = UIColorHex(333333);
    [_recieverView addSubview:_recieverLabel];
    
    _recieverPhoneLabel = [YYLabel new];
    _recieverPhoneLabel.origin = CGPointMake(_recieverLabel.right+kProductImgViewPadding, kProductImgViewPadding);
    _recieverPhoneLabel.size = CGSizeMake(kScreenWidth-(_addressImgView.right+kProductImgViewPadding*2), 15);
    _recieverPhoneLabel.font = SYSTEM_FONT(15);
    _recieverPhoneLabel.textColor = UIColorHex(333333);
    [_recieverView addSubview:_recieverPhoneLabel];
    
    _recieverAddressLabel = [YYLabel new];
    _recieverAddressLabel.origin = CGPointMake(_addressImgView.right+kProductImgViewPadding, _recieverLabel.bottom+kProductImgViewPadding);
    _recieverAddressLabel.size = CGSizeMake(kScreenWidth-(_addressImgView.right+kProductImgViewPadding*2), 15);
    _recieverAddressLabel.font = SYSTEM_FONT(15);
    _recieverAddressLabel.textColor = UIColorHex(666666);
    _recieverAddressLabel.numberOfLines = 0;
    [_recieverView addSubview:_recieverAddressLabel];
    
}

- (void)setModel:(LogisticsModel *)model {
    _model = model;
    [_productImgView setImageWithURL:[NSURL URLWithString:_model.imgUrl] options:YYWebImageOptionShowNetworkActivity];
    NSString *statusStr = [NSString stringWithFormat:@"物流状态：%@",_model.logisticsStatus];
    NSMutableAttributedString *attributStatus = [[NSMutableAttributedString alloc]initWithString:statusStr];
    [attributStatus addAttributes:@{NSForegroundColorAttributeName:UIColorHex(0x22A44E)} range:NSMakeRange(5, _model.logisticsStatus.length)];
    _statusLabel.attributedText = attributStatus;
    _statusLabel.font = SYSTEM_FONT(16);
    
    _logisticsIncLabel.text = [NSString stringWithFormat:@"物流公司：%@",_model.logisticsInc];
    _orderNumberLabel.text = [NSString stringWithFormat:@"运单编号：%@",_model.orderNumber];
    _statusView.height = _orderNumberLabel.bottom+kProductImgViewPadding;
    
    _recieverView.top = _statusView.bottom+kStatusViewMargin;
    _recieverLabel.text = _model.reciever;
    [_recieverLabel sizeToFit];
    _recieverPhoneLabel.text = _model.recieverPhone;
    _recieverPhoneLabel.left = _recieverLabel.right+kProductImgViewPadding;
    
    _recieverAddressLabel.height = [_model.recieverAddress sizeWithAttributes:@{NSFontAttributeName:SYSTEM_FONT(15)}].height;
    NSMutableAttributedString *attAddress = [[NSMutableAttributedString alloc]initWithString:_model.recieverAddress];
    attAddress.lineBreakMode = NSLineBreakByCharWrapping;
    attAddress.font = SYSTEM_FONT(15);
    attAddress.color = UIColorHex(999999);
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kScreenWidth-(_addressImgView.right+kProductImgViewPadding*2), HUGE)];
    container.maximumNumberOfRows = 0;
    container.size = CGSizeMake(kScreenWidth-(_addressImgView.right+kProductImgViewPadding*2), HUGE);
    YYTextLayout *addressLayout = [YYTextLayout layoutWithContainer:container text:attAddress];
    _recieverAddressLabel.textLayout = addressLayout;
    _recieverAddressLabel.top = _recieverLabel.bottom+kProductImgViewPadding;
    _recieverAddressLabel.height = 18*addressLayout.rowCount;
    _recieverView.height = _recieverAddressLabel.bottom+kProductImgViewPadding;
    
    self.height = _recieverView.bottom+kStatusViewMargin;
}

@end
