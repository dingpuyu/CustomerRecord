//
//  RecommendationRecordListView.m
//  RecommendationRecord
//
//  Created by xiaotei's on 15/11/18.
//  Copyright © 2015年 xiaotei's. All rights reserved.
//

#import "RecommendationRecordListView.h"
#import "RecommendationRecordTableView.h"

@interface RecommendationRecordListView()<UIScrollViewDelegate>

@property (nonatomic,strong)NSArray* threeTableView;
//列表展示
@property (nonatomic,weak)RecommendationRecordTableView* listTableView;

@end

@implementation RecommendationRecordListView

-(instancetype)init{
    if (self = [super init]) {
        self.pagingEnabled = YES;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.bounces = NO;
        self.delegate = self;
    }
    return self;
}

-(void)didMoveToSuperview{
    
//    NSInteger index = self.contentOffset.x / self.frame.size.width;
//    self.currentIndex = ;
}

-(void)reloadView{
    self.contentSize = CGSizeMake(_optionsArray.count * self.frame.size.width, 0);
    for (int i = 0;i < 3;i++) {
        UITableView* listTableView = self.threeTableView[i];
        NSInteger trueIndex = _currentIndex;
        if (i == 0) {
            trueIndex = _currentIndex - 1;
        }else if(i == 1){
            trueIndex = _currentIndex;
        }else if(i == 2){
            trueIndex = _currentIndex + 1;
        }
        listTableView.frame = CGRectMake(trueIndex * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
        //        [listTableView reloadData];
    }
}

-(void)setOptionsArray:(NSArray *)optionsArray{
    _optionsArray = optionsArray;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    NSLog(@"%f",scrollView.contentOffset.x);
    
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    NSLog(@"%f",scrollView.contentOffset.x);
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger index = self.contentOffset.x / self.frame.size.width;
//    NSLog(@"%ld",index);
    if (_currentIndex == index) return;
    [self directionWithNewIndex:index];
    
    
    self.currentIndex = index;
    
//    _listTableView.optionTitle = _optionsArray[index];
    if (_block) {
        _block(index);
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self reloadView];
}

#pragma mark - getter

-(RecommendationRecordTableView *)listTableView{
    if (!_listTableView) {
        RecommendationRecordTableView* listView = [[RecommendationRecordTableView alloc]init];
        [self addSubview:listView];
        
        _listTableView = listView;
        _listTableView.optionTitle = _optionsArray[_currentIndex!=0?_currentIndex:0];
    }
    return _listTableView;
}

-(NSArray *)threeTableView{
    if (!_threeTableView) {
        
        RecommendationRecordTableView* listView2 = [[RecommendationRecordTableView alloc]init];
        [self addSubview:listView2];
        listView2.optionTitle = _optionsArray[_currentIndex != 0?_currentIndex:0];
        
        RecommendationRecordTableView* listView1 = nil;
        listView1 = [[RecommendationRecordTableView alloc]init];
        [self addSubview:listView1];
        listView1.optionTitle = _optionsArray[_currentIndex > 0?_currentIndex - 1:0];
        
        
        RecommendationRecordTableView* listView3 = [[RecommendationRecordTableView alloc]init];
        [self addSubview:listView3];
        listView3.optionTitle = _optionsArray[_optionsArray.count-1 > _currentIndex?_currentIndex+1:0];
        
        _threeTableView = @[listView1,listView2,listView3];
    
//        _listTableView = listView;
    }
    return _threeTableView;
}

-(void)setCurrentIndex:(NSInteger)currentIndex{
    if (_currentIndex == currentIndex)return;
    self.contentOffset = CGPointMake(currentIndex * self.frame.size.width, 0);
    _currentIndex = currentIndex;
//    _listTableView.optionTitle = _optionsArray[currentIndex];
    
    if (_threeTableView.count > 0) {
        for (int i = 0; i < 3; i++) {
            RecommendationRecordTableView* listTableView = self.threeTableView[i];
            NSInteger trueIndex = _currentIndex;
            if (i == 0) {
                trueIndex = (_currentIndex - 1) >= 0?(_currentIndex - 1):0;
            }else if(i == 1){
                trueIndex = _currentIndex;
                NSLog(@"%@",_optionsArray[trueIndex]);
            }else if(i == 2){
                trueIndex = (_currentIndex + 1) <= _optionsArray.count - 1?(_currentIndex + 1):_currentIndex;
            }
            listTableView.optionTitle = _optionsArray[trueIndex];
        }
    }
//    RecommendationRecordTableView* listTableView = self.threeTableView[1];
    [self reloadView];
}

//动画方向，根据新的index
-(void)directionWithNewIndex:(NSInteger)newIndex{
    TableViewAnimationDirection direction = TableViewAnimationDirectionNone;
    if (newIndex > _currentIndex) {
        direction = TableViewAnimationDirectionLeft;
    }else if(newIndex < _currentIndex){
        direction = TableViewAnimationDirectionRight;
    }
    
    _listTableView.direction = direction;
}
@end
