//
//  WTSystemInfo.h
//  WinTreasure
//
//  Created by Apple on 16/5/31.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef kScreenBounds
#define kScreenBounds [UIScreen mainScreen].bounds
#endif

#ifndef kDefaultColor
#define kDefaultColor [UIColor colorWithHexString:@"D02346"]
#endif

#ifndef kNavigationBarHeight
#define kNavigationBarHeight 64.0
#endif

#ifndef kTabBarHeight
#define kTabBarHeight 49.0
#endif

#ifndef SYSTEM_FONT
#define SYSTEM_FONT(__fontsize__)\
[UIFont systemFontOfSize:__fontsize__]
#endif

#ifndef IMAGE_NAMED
#define IMAGE_NAMED(__imageName__)\
[UIImage imageNamed:__imageName__]
#endif

#ifndef NIB_NAMED
#define NIB_NAMED(__nibName__)\
[UINib nibWithNibName:__nibName__ bundle:nil]
#endif

#ifndef kTreasureIsLogined
#define kTreasureIsLogined @"kTreasureIsLogined"
#endif

/**
 * 手机号码
 * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
 * 联通：130,131,132,152,155,156,185,186
 * 电信：133,134,153,180,189
 */
// NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";

/**
 * 中国移动：China Mobile
 * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
 */
// NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";

/**
 * 中国联通：China Unicom
 * 130,131,132,152,155,156,185,186
 */
// NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$"; http://code.662p.com/view/4860.html

/**
 * 中国电信：China Telecom
 * 133,1349,153,180,189
 */
// NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";

/**
 * 大陆地区固话及小灵通
 * 区号：010,020,021,022,023,024,025,027,028,029
 * 号码：七位或八位
 */
// NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";

@interface WTSystemInfo : NSObject
/**手机号码
 */
+ (BOOL)validateMobile:(NSString *)mobile;

/**密码
 */
+ (BOOL)validatePassword:(NSString *)passWord;

/**验证码
 */
+ (BOOL)validateVerifyCode:(NSString *)verifyCode;

/**昵称
 */
+ (BOOL)validateNickname:(NSString *)nickname;

@end
