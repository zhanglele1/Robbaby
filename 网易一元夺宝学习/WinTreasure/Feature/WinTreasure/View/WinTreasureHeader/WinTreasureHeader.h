//
//  WinTreasureHeader.h
//  WinTreasure
//
//  Created by Apple on 16/6/1.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MenuControllerType) {
    ProductCategoryType,
    CategoryDetailType,
    ShareType,
    QuestionType,
};

@class WinTreasureHeader;
@protocol WinTreasureHeaderDelegate;

@interface AdvertisingView : UIScrollView

@end




typedef void(^TreasureMenuViewSelectItemBlock)(id object);

@interface TreasureMenuView : UIView

@property (nonatomic, weak) WinTreasureHeader *header;

@property (nonatomic, copy)TreasureMenuViewSelectItemBlock block;

@end





typedef void(^TreasureNoticeViewBlock)(id object);

@interface TreasureNoticeView : UIView

@property (nonatomic, copy) NSArray *titles;

@property (nonatomic, copy)TreasureNoticeViewBlock block;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles;

@end





typedef void(^WinTreasureHeaderSelectItemBlock)(id object);
typedef void(^WinTreasureHeaderSelectNoticeBlock)(NSUInteger index);

@protocol WinTreasureHeaderDelegate <NSObject>
/**点击图片
 */
- (void)selectImageView:(WinTreasureHeader *)header currentIndex:(NSInteger)index;

/**点击菜单
 */
- (void)selectItem:(WinTreasureHeader *)header currentIndex:(NSInteger)index;

/**点击通知信息
 */
- (void)selectNotice:(WinTreasureHeader *)header;
@end


@interface WinTreasureHeader : UIView

@property (nonatomic, strong) TreasureMenuView *menuView;

@property (nonatomic, strong) TreasureNoticeView *noticeView;

@property (nonatomic, copy) WinTreasureHeaderSelectItemBlock menuBlock;

@property (nonatomic, copy) WinTreasureHeaderSelectNoticeBlock noticeBlock;

/**点击图片
 */
@property (nonatomic, copy) WinTreasureHeaderSelectItemBlock imageBlock;

+ (CGFloat)height;

- (void)selectItem:(WinTreasureHeaderSelectItemBlock)block;
- (void)selectNotice:(WinTreasureHeaderSelectNoticeBlock)block;

@end
