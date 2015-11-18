//
//  TopOptionsView.h
//  RecommendationRecord
//
//  Created by xiaotei's on 15/11/18.
//  Copyright © 2015年 xiaotei's. All rights reserved.
//

#import <UIKit/UIKit.h>

#define OptionItemWidth 80
#define OptionItemHeight 40

@class TopOptionsView;

@protocol TopOptionsViewDelegate <NSObject>

/**
 *  选中了某个标签选项
 */
-(void)topOptionsView:(TopOptionsView*)opView didSelectedOptions:(NSInteger)index;

@end

@interface TopOptionsView : UIView

/**顶部分类选项按钮*/
@property (nonatomic,strong)NSArray* optionsArray;

//当前选中的标签
@property (nonatomic,assign)NSInteger currentIndex;

- (instancetype)initWithOptionsArray:(NSArray*)options;

+ (instancetype)optionsViewWithArray:(NSArray*)options;

//顶部标签栏的代理
@property (nonatomic,weak)id<TopOptionsViewDelegate> delegate;

@end
