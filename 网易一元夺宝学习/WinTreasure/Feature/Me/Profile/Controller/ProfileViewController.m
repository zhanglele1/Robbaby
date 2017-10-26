//
//  ProfileViewController.m
//  WinTreasure
//
//  Created by Apple on 16/6/22.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "ProfileViewController.h"
#import "AddressViewController.h"
#import "NicknameViewController.h"
#import "PhoneModifyViewController.h"
#import "ProfileCell.h"

@interface ProfileViewController () <UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet BaseTableView *tableView;

@property (nonatomic, strong) NSArray *titles;

@end

@implementation ProfileViewController

- (NSArray *)titles {
    if (!_titles) {
        _titles = @[@"头像",@"ID",@"昵称",@"手机号码",@"地址管理"];
    }
    return _titles;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人资料";
    _tableView.estimatedRowHeight = 60.0;
    _tableView.rowHeight = UITableViewAutomaticDimension;
}


- (void)showActionSheet {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍照",@"从相册选择",nil];
    [actionSheet showInView:self.view];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (![[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"取消"]) {
        UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
        pickerController.navigationBar.tintColor = [UIColor blackColor];
        if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"拍照"]) {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] && [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]) {
                [pickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
                [pickerController setCameraDevice:UIImagePickerControllerCameraDeviceRear];
            } else {
                [pickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            }
        } else if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"从手机相册选择"]) {
            [pickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        }
        [pickerController setDelegate:self];
        [pickerController setAllowsEditing:YES];
        [self presentViewController:pickerController animated:YES completion:nil];
    }
}

#pragma mark - UIImagePickerController delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    //    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Datasource Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) {
        ProfileCell *cell = [ProfileCell cellWithTableView:tableView];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    ProfileDetailCell *cell = [ProfileDetailCell cellWithTableView:tableView];
    cell.textLabel.text = self.titles[indexPath.row];
    if (indexPath.row==1) {
        cell.detailTextLabel.text = @"8500214";
    } else {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row==0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"本次修改头像免费" message:@"首次修改头像免费，之后每次修改将消耗1宝石" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
            if (buttonIndex==1) {
                [self showActionSheet];
            }
        }];
    } else if (indexPath.row==2) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"本次修改昵称免费" message:@"首次修改昵称免费，之后每次修改将消耗5宝石" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
            if (buttonIndex==1) {
                NicknameViewController *vc = [[NicknameViewController alloc]init];
                vc.nicknameBlock = ^(NSString *name) {
                    ProfileDetailCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                    cell.detailTextLabel.text = name;
                };
                [self hideBottomBarPush:vc];
            }
        }];
    } else if (indexPath.row==3) {
        PhoneModifyViewController *vc = [[PhoneModifyViewController alloc]init];
        vc.modifyBlock = ^(NSString *number) {
            ProfileDetailCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.detailTextLabel.text = number;
        };
        [self hideBottomBarPush:vc];
    } else if (indexPath.row==4) {
        AddressViewController *vc = [[AddressViewController alloc]init];
        [self hideBottomBarPush:vc];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}



@end
