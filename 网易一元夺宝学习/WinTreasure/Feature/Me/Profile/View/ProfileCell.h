//
//  ProfileCell.h
//  WinTreasure
//
//  Created by Apple on 16/6/22.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableview;
@property (weak, nonatomic) IBOutlet UIImageView *headImgView;

@end

@interface ProfileDetailCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableview;

@end
