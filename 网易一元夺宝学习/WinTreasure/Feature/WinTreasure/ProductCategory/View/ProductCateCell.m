//
//  ProductCateCell.m
//  WinTreasure
//
//  Created by Apple on 16/6/3.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "ProductCateCell.h"

@implementation ProductCateCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    
}

+ (instancetype)cellWithTableView:(UITableView *)tableview {
    static NSString *cellID = @"ProductCateCell";
    ProductCateCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = (ProductCateCell *)[[[NSBundle mainBundle] loadNibNamed:@"ProductCateCell" owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)height {
    return 44.0;
}

@end


const CGFloat kProductImageViewWidth = 30.0;

@implementation ProductAllCateCell

+ (instancetype)cellWithTableView:(UITableView *)tableview {
    static NSString *cellID = @"ProductAllCateCell";
    ProductAllCateCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[ProductAllCateCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _imgView = [UIImageView new];
        _imgView.origin = CGPointMake(15, (self.height-kProductImageViewWidth)/2.0);
        _imgView.size = CGSizeMake(kProductImageViewWidth, kProductImageViewWidth);
        [self.contentView addSubview:_imgView];
        
        _allProductLabel = [YYLabel new];
        _allProductLabel.font = SYSTEM_FONT(17);
        _allProductLabel.textColor = UIColorHex(333333);
        _allProductLabel.origin = CGPointMake(_imgView.right+10, 0);
        _allProductLabel.size = CGSizeMake(self.width-(_imgView.right+10), 15);
        [self.contentView addSubview:_allProductLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _imgView.centerY = self.contentView.centerY;
    _allProductLabel.centerY = self.contentView.centerY;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+ (CGFloat)height {
    return 64.0;
}

@end

@implementation CategoryCell

+ (instancetype)cellWithTableView:(UITableView *)tableview {
    static NSString *cellID = @"CategoryCell";
    CategoryCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[CategoryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _imgView = [UIImageView new];
        _imgView.origin = CGPointMake(15, (self.height-kProductImageViewWidth)/2.0);
        _imgView.size = CGSizeMake(20, 20);
        [self.contentView addSubview:_imgView];
        
        _categoryLabel = [YYLabel new];
        _categoryLabel.textColor = UIColorHex(0x8A8A8A);
        _categoryLabel.origin = CGPointMake(_imgView.right+10, 0);
        _categoryLabel.size = CGSizeMake(self.width-(_imgView.right+10), 15);
        _categoryLabel.font = SYSTEM_FONT(10);
        [self.contentView addSubview:_categoryLabel];

    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _categoryLabel.centerY = self.contentView.centerY;
    _imgView.centerY = self.contentView.centerY;
}

+ (CGFloat)height {
    return 30.0;
}

@end
