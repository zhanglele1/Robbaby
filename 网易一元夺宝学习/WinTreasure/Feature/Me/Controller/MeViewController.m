//
//  MeViewController.m
//  WinTreasure
//
//  Created by Apple on 16/5/31.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "MeViewController.h"
#import "TreasureRecordViewController.h"
#import "LuckyRecordViewController.h"
#import "BonusViewController.h"
#import "ShareViewController.h"
#import "TopupViewRecordController.h"
#import "MyDiamondViewController.h"
#import "DreamListViewController.h"
#import "PurchaseRecordViewController.h"
#import "MyShareViewController.h"
#import "ProfileViewController.h"
#import "SettingViewController.h"
#import "NoticeViewController.h"
#import "TopupViewController.h"
#import "CustomerServiceViewController.h"
#import "MeCell.h"
#import "MeHeader.h"

@interface MeViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (strong, nonatomic) NSMutableArray *textData;

@property (strong, nonatomic) NSMutableArray *imageData;

@property (strong, nonatomic) NSDictionary *dictionary;

@property (strong, nonatomic) MeHeader *header;

@end

@implementation MeViewController

- (NSDictionary *)dictionary {
    if (!_dictionary) {
        _dictionary = @{@"全部夺宝记录":@"TreasureRecordViewController",
                        @"幸运纪录":@"LuckyRecordViewController",
                        @"购买纪录":@"PurchaseRecordViewController",
                        @"红包":@"BonusViewController",
                        @"心愿单":@"DreamListViewController",
                        @"晒单":@"ShareViewController",
                        @"我的宝石":@"MyDiamondViewController",
                        @"充值记录":@"TopupViewRecordController",};
    }
    return _dictionary;
}

- (NSMutableArray *)textData {
    if (!_textData) {
        _textData = ({
            NSMutableArray *array = [NSMutableArray
                                        arrayWithArray:
                                        @[@[@"全部夺宝记录",@"幸运纪录"],
//                                          @[@"购买纪录"],
                                          @[@"红包",@"晒单",@"我的宝石",@"充值记录"],
                                          @[@"夺宝客服"]]];
            array;
        });
    }
    return _textData;
}

- (NSMutableArray *)imageData {
    if (!_imageData) {
        _imageData = ({
            NSMutableArray *array = [NSMutableArray
                                     arrayWithArray:
                                     @[@[@"personal_duobao_record_35x35_",@"personal_win_record_35x35_"],
//                                       @[@"personal_buy_record_35x35_"],
                                       
                                       @[@"personal_bonus_35x35_",@"personal_show_35x35_",@"personal_baoshi_35x35_",@"personal_charge_record_35x35_"],
                                       @[@"personal_kefu_35x35_"]]];
            array;
        });
    }
    return _imageData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人中心";
    [self setupHeader];
    [self setupNavItems];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getTopupResult:) name:@"kTopupNotification" object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setNavigationBarBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]]
                                tintColor:[UIColor clearColor]
                                textColor:[UIColor clearColor]
                           statusBarStyle:UIStatusBarStyleLightContent];
}

- (void)setupNavItems {
    [self setupRightItems:@[@"install",@"news"]];
    @weakify(self);
    self.block = ^(NSInteger index) {
        @strongify(self);
        switch (index) {
            case 1:{
                SettingViewController *vc = [[SettingViewController alloc]init];
                [self pushController:vc];
            }
                break;
            case 2:{
                NoticeViewController *vc = [[NoticeViewController alloc]init];
                [self pushController:vc];
            }
                break;
            default:
                break;
        }
    };
}

- (void)setupHeader {
    _header = [[MeHeader alloc]initWithFrame:({
        CGRect rect = {0, 0, kScreenWidth, 282};
        rect;
    })];
    _tableview.tableHeaderView = _header;
    @weakify(self);
    _header.menuBlock = ^(NSInteger index){
        @strongify(self);
        TreasureRecordViewController *vc = [[TreasureRecordViewController alloc]init];
        vc.recordType = index;
        [self pushController:vc];
    };
    
    _header.headImgBlock = ^{
        @strongify(self);
        ProfileViewController *vc = [[ProfileViewController alloc]init];
        [self pushController:vc];
    };
    
    _header.topupBlock = ^{
        @strongify(self);
        TopupViewController *vc = [[TopupViewController alloc]init];
        [self pushController:vc];
    };
    
    _header.diamondBlock = ^{
        @strongify(self);
        MyDiamondViewController *vc = [[MyDiamondViewController alloc]init];
        [self pushController:vc];
    };
}

#pragma mark - notice 
- (void)getTopupResult:(NSNotification *)notice {
    NSNumber *remainSum = (NSNumber *)notice.object;
    _header.remainSum = remainSum;
}

#pragma mark - delegates
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.textData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *rowsArray = self.textData[section];
    return rowsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MeCell *cell = [MeCell cellWithTableView:tableView];
    cell.menuLabel.text = self.textData[indexPath.section][indexPath.row];
    cell.menuImgView.image = IMAGE_NAMED(self.imageData[indexPath.section][indexPath.row]);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==0) {
        switch (indexPath.row) {
            case 0: {
                TreasureRecordViewController *vc = [[TreasureRecordViewController alloc]init];
                vc.recordType = TreasureRecordTypePaticipated;
                [self pushController:vc];
            }
                break;
            case 1: {
                LuckyRecordViewController *vc = [[LuckyRecordViewController alloc]init];
                [self pushController:vc];
            }
                break;
            default:
                break;
        }
    } else if (indexPath.section==1) {
        switch (indexPath.row) {
            case 0: {
                BonusViewController *vc = [[BonusViewController alloc]init];
                [self pushController:vc];
            }
                break;
//            case 1: {
//                DreamListViewController *vc = [[DreamListViewController alloc]init];
//                [self.navigationController pushViewController:vc animated:YES];
//            }
//                break;
            case 1: {
                MyShareViewController *vc = [[MyShareViewController alloc]init];
                [self pushController:vc];
            }
                break;
            case 2: {
                MyDiamondViewController *vc = [[MyDiamondViewController alloc]init];
                [self pushController:vc];
            }
                break;
            case 3: {
                TopupViewRecordController *vc = [[TopupViewRecordController alloc]init];
                [self pushController:vc];
            }
                break;
            default:
                break;
        }
    } else if (indexPath.section==2) {
        CustomerServiceViewController *vc = [[CustomerServiceViewController alloc]init];
        [self pushController:vc];
    }
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
////    if (scrollView.contentOffset.y < 0) {
////        [_header makeScaleForScrollView:scrollView];;
////    }
//    //导航栏渐变
//    CGFloat offsetY = scrollView.contentOffset.y;
//    if (offsetY > 50) {
//        CGFloat alpha = MIN(1, 1 - ((50 + 64 - offsetY) / 64));
//        [self.navigationController.navigationBar setCoverViewBackgroundColor:[[UIColor clearColor] colorWithAlphaComponent:alpha]];
//    } else {
//        [self.navigationController.navigationBar setCoverViewBackgroundColor:[[UIColor clearColor] colorWithAlphaComponent:0]];
//    }
//     
//}



@end
