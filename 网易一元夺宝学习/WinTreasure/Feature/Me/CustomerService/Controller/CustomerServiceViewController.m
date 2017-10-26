//
//  CustomerServiceViewController.m
//  WinTreasure
//
//  Created by Apple on 16/7/6.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "CustomerServiceViewController.h"
#import "ServiceDetailViewController.h"
#import "CustomerServiceCell.h"


@interface CustomerServiceViewController () <UITableViewDataSource,UITableViewDelegate, DZNEmptyDataSetDelegate, DZNEmptyDataSetSource>

@property (nonatomic, strong) BaseTableView *tableView;

@property (nonatomic, strong) NSMutableArray *datasource;

@end

@implementation CustomerServiceViewController

- (NSMutableArray *)datasource {
    if (!_datasource) {
        _datasource = [NSMutableArray array];
    }
    return _datasource;
}

- (BaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[BaseTableView alloc]initWithFrame:({
            CGRect rect = {0,0,kScreenWidth,kScreenHeight};
            rect;
        }) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.emptyDataSetDelegate = self;
        _tableView.emptyDataSetSource= self;
        _tableView.separatorColor = UIColorHex(0xeeeeee);
        _tableView.backgroundColor = UIColorHex(0xf5f5f5);
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"夺宝客服";
    [self.view addSubview:self.tableView];
    [self getData];
}

- (void)getData {
    for (int i=0; i<3; i++) {
        CustomerServiceModel *model = [[CustomerServiceModel alloc]init];
        [self.datasource addObject:model];
    }
    [_tableView reloadData];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasource.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        ServiceCell *cell = [ServiceCell cellWithTableView:tableView];
        return cell;
    }
    CustomerServiceCell *cell = [CustomerServiceCell cellWithTableView:tableView];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ServiceDetailViewController *vc = [[ServiceDetailViewController alloc]init];
    [self hideBottomBarPush:vc];
}

#pragma mark - DZNEmptyDataSetDelegate, DZNEmptyDataSetSource


@end
