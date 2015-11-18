//
//  RecommendationRecordTableView.h
//  RecommendationRecord
//
//  Created by xiaotei's on 15/11/18.
//  Copyright © 2015年 xiaotei's. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  动画方向
 */
typedef NS_ENUM(NSInteger,TableViewAnimationDirection) {
    /**
     *  没有
     */
    TableViewAnimationDirectionNone,
    /**
     *  向左动画
     */
    TableViewAnimationDirectionLeft,
    /**
     *  向右动画
     */
    TableViewAnimationDirectionRight
};

@interface RecommendationRecordTableView : UITableView

//动画方向
@property (nonatomic,assign)TableViewAnimationDirection direction;

@property (nonatomic,copy)NSString* optionTitle;

@end
