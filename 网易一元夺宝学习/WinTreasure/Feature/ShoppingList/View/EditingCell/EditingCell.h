//
//  EditingCell.h
//  GentlyLove
//
//  Created by Apple on 16/3/9.
//  Copyright © 2016年 com.linitial. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditingCell : UITableViewCell
{
@private
    UIImageView*	m_checkImageView;
    BOOL			m_checked;
}

- (void)setChecked:(BOOL)checked;

@end
