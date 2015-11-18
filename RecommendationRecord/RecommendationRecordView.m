//
//  RecommendationRecordView.m
//  RecommendationRecord
//
//  Created by xiaotei's on 15/11/18.
//  Copyright © 2015年 xiaotei's. All rights reserved.
//

#import "RecommendationRecordView.h"
#import "RecommendationRecordListView.h"

@interface RecommendationRecordView()<TopOptionsViewDelegate>

//顶部选项视图
@property (nonatomic,weak)TopOptionsView* topOptionsView;
//报备信息列表
@property (nonatomic,weak)RecommendationRecordListView* rrListView;

@end

@implementation RecommendationRecordView

-(instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}

-(void)willMoveToSuperview:(UIView *)newSuperview{
    self.topOptionsView.backgroundColor = [UIColor lightGrayColor];
    self.rrListView.backgroundColor = [UIColor greenColor];
    
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _topOptionsView.frame = CGRectMake(0, 0, self.frame.size.width, OptionItemHeight);
    _rrListView.frame = CGRectMake(0, OptionItemHeight, self.frame.size.width, self.frame.size.height - OptionItemHeight);
}

#pragma mark - getter
//顶部选项视图懒加载
-(TopOptionsView *)topOptionsView{
    if (!_topOptionsView) {
        TopOptionsView* topView = [[TopOptionsView alloc]init];
        
        topView.optionsArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14"];
        [self addSubview:topView];
        _topOptionsView = topView;
        _topOptionsView.delegate = self;
        
    }
    return _topOptionsView;
}

-(RecommendationRecordListView *)rrListView{
    if (!_rrListView) {
        RecommendationRecordListView* listView = [[RecommendationRecordListView alloc]init];
        
        listView.optionsArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14"];
        
        __weak typeof(self) weakSelf = self;
        listView.block = ^(NSInteger index){
            weakSelf.topOptionsView.currentIndex = index;
        };
        
        [self addSubview:listView];
        _rrListView = listView;
    }
    return _rrListView;
}

#pragma mark - topOptionsViewDelegate
-(void)topOptionsView:(TopOptionsView *)opView didSelectedOptions:(NSInteger)index{
    _rrListView.currentIndex = index;
}

@end
