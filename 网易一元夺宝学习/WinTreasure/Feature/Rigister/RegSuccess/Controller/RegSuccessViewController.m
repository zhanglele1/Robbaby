//
//  RegSuccessViewController.m
//  WinTreasure
//
//  Created by Apple on 16/6/24.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "RegSuccessViewController.h"

@interface RegSuccessViewController ()

@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@end

@implementation RegSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"快速注册";
    self.navigationItem.hidesBackButton = YES;
    _infoLabel.text = [NSString stringWithFormat:@"恭喜您已注册成功，账号为：\n%@\n请返回登录界面。",_number];
}


- (IBAction)popToLogin {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
