//
//  RecommendationRecordListView.h
//  RecommendationRecord
//
//  Created by xiaotei's on 15/11/18.
//  Copyright © 2015年 xiaotei's. All rights reserved.
//

#import <UIKit/UIKit.h>


@class RecommendationRecordListView;

typedef void(^RecommendationRecordListBlock)(NSInteger index);

@interface RecommendationRecordListView : UIScrollView

@property (nonatomic,strong)NSArray* optionsArray;

/**
 *  当前标签索引
 */
@property (nonatomic,assign)NSInteger currentIndex;

@property (nonatomic,copy)RecommendationRecordListBlock block;
@end
