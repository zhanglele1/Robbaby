//
//  PhoneModifyViewController.h
//  WinTreasure
//
//  Created by Apple on 16/6/22.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^PhoneModifyBlock)(NSString *number);

@interface PhoneModifyViewController : BaseViewController

@property (copy, nonatomic) PhoneModifyBlock modifyBlock;

@end
