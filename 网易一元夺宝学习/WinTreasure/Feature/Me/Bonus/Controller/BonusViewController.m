//
//  BonusViewController.m
//  WinTreasure
//
//  Created by Apple on 16/6/15.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "BonusViewController.h"
#import "TreasureDetailViewController.h"
#import "TSMenu.h"
#import "BonusCell.h"

@interface BonusViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
{
    BOOL _isUsedBonusLoad;
}
@property (nonatomic, strong) TSMenu *menu;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) NSMutableArray *userableData;

@property (nonatomic, strong) NSMutableArray *usedData;

@property (nonatomic, strong) BaseTableView *userableTable;

@property (nonatomic, strong) BaseTableView *usedTable;

@property (nonatomic, strong) NSArray *items;

@property (nonatomic, assign) BOOL isUsedBonusLoad;

@end

@implementation BonusViewController

- (NSMutableArray *)userableData {
    if (!_userableData) {
        _userableData = [NSMutableArray array];
    }
    return _userableData;
}

- (NSMutableArray *)usedData {
    if (!_usedData) {
        _usedData = [NSMutableArray array];
    }
    return _usedData;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:({
            CGRect rect = {0,kTSMenuHeight+kNavigationBarHeight,kScreenWidth,kScreenHeight-kNavigationBarHeight-kTSMenuHeight};
            rect;
        })];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(self.items.count*kScreenWidth, 0);
        [_scrollView addSubview:self.userableTable];
        [_scrollView addSubview:self.usedTable];
    }
    return _scrollView;
}

- (UITableView *)usedTable {
    if (!_usedTable) {
        _usedTable = [[BaseTableView alloc]initWithFrame:({
            CGRect rect = {kScreenWidth,0,self.scrollView.width,self.scrollView.height};
            rect;
        }) style:UITableViewStylePlain];
        _usedTable.dataSource = self;
        _usedTable.delegate = self;
        _usedTable.rowHeight = 125;
        [_usedTable setCustomSeparatorInset:UIEdgeInsetsZero];
    }
    return _usedTable;
}

- (UITableView *)userableTable {
    if (!_userableTable) {
        _userableTable = [[BaseTableView alloc]initWithFrame:({
            CGRect rect = {0,0,self.scrollView.width,self.scrollView.height};
            rect;
        }) style:UITableViewStylePlain];
        _userableTable.dataSource = self;
        _userableTable.delegate = self;
        _userableTable.rowHeight = 125;
        [_userableTable setCustomSeparatorInset:UIEdgeInsetsZero];
        
    }
    return _userableTable;
}

- (NSArray *)items {
    if (!_items) {
        _items = @[@"未使用",
                   @"已使用/过期"];
    }
    return _items;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的红包";
    [self setup];
    
    [_usedTable.mj_header beginRefreshing];
    @weakify(self);
    _userableTable.mj_header =  [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        @strongify(self);
        CGFloat delayTime = dispatch_time(DISPATCH_TIME_NOW, 2);
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            [self getUserableBonus];
            [self.userableTable.mj_header endRefreshing];
        });
    }];
    
    [_userableTable.mj_header beginRefreshing];
    _usedTable.mj_header =  [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        @strongify(self);
        CGFloat delayTime = dispatch_time(DISPATCH_TIME_NOW, 2);
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            [self getUsedBonus];
            [self.usedTable.mj_header endRefreshing];
        });
    }];
}

- (void)getUserableBonus {
    for (int i=0; i<2; i++) {
        BonusModel *model = [[BonusModel alloc]init];
        [self.userableData addObject:model];
    }
    [_userableTable reloadData];
}

- (void)getUsedBonus {
    self.isUsedBonusLoad = YES;
    for (int i=0; i<3; i++) {
        BonusModel *model = [[BonusModel alloc]init];
        model.bonusType = 1;
        [self.usedData addObject:model];
    }
    [self.usedTable reloadData];
}

- (void)setup {
    _menu = [[TSMenu alloc]initWithDataArray:self.items];
    _menu.origin = CGPointMake(0, kNavigationBarHeight);
    _menu.size = CGSizeMake(kScreenWidth, kTSMenuHeight);
    [self.view addSubview:_menu];

    @weakify(self);
    _menu.menuBlock  = ^(id object){
        @strongify(self);
        UIButton *sender = (UIButton *)object;
        [self.scrollView setContentOffset:CGPointMake((sender.tag-1)*kScreenWidth, 0) animated:YES];
        if (sender.tag==2 && !self.isUsedBonusLoad) {
            [self.usedTable.mj_header beginRefreshing];
        }
    };
    [self.view addSubview:self.scrollView];
}

#pragma mark - delegates 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView==_userableTable) {
        return self.userableData.count;
    }
    return self.usedData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BonusCell *cell = [BonusCell cellWithTableView:tableView];
    if (tableView==_usedTable) {
        BonusModel *model = _usedData[indexPath.row];
        cell.model = model;
    } else {
        BonusModel *model = _userableData[indexPath.row];
        cell.model = model;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.hidesBottomBarWhenPushed = YES;
    TreasureDetailViewController *vc = [[TreasureDetailViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    _menu.selectIndex = _scrollView.contentOffset.x/kScreenWidth;
    if (_menu.selectIndex==1 && !_isUsedBonusLoad) {
        [self.usedTable.mj_header beginRefreshing];
    }
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}


@end
