//
//  SearchView.h
//  WinTreasure
//
//  Created by Apple on 16/6/24.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SearchViewBlock)(void);

@protocol SearchViewDelegate;

@interface SearchView : UIView

@property (nonatomic, strong) UISearchBar *searchBar;

@property (nonatomic, copy) SearchViewBlock cancelBlock;

@property (nonatomic, weak) id<SearchViewDelegate>delegate;

@property (nonatomic, copy) NSString *text;

- (void)beginSearch;

@end

@protocol SearchViewDelegate <NSObject>

@optional;
- (BOOL)searchViewShouldBeginEditing:(SearchView *)searchView;                      // return NO to not become first responder
- (void)searchViewTextDidBeginEditing:(SearchView *)searchView;                     // called when text starts editing
- (BOOL)searchViewShouldEndEditing:(SearchView *)searchView;                        // return NO to not resign first responder
- (void)searchViewTextDidEndEditing:(SearchView *)searchView;                       // called when text ends editing
- (void)searchView:(SearchView *)searchView textDidChange:(NSString *)searchText;

- (void)searchViewSearchButtonClicked:(SearchView *)searchView;

@end
