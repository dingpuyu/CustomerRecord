//
//  TopOptionsView.m
//  RecommendationRecord
//
//  Created by xiaotei's on 15/11/18.
//  Copyright © 2015年 xiaotei's. All rights reserved.
//

#import "TopOptionsView.h"
#import "RecommendationRecordTableView.h"

@interface TopOptionsView()

//承载滚动视图
@property (nonatomic,weak)UIScrollView* contentView;

@property (nonatomic,weak)UIButton* currentBtn;

@end

@implementation TopOptionsView

+ (instancetype)optionsViewWithArray:(NSArray *)options{
    return [[self alloc]initWithOptionsArray:options];
}

- (instancetype)initWithOptionsArray:(NSArray *)options{
    if (self = [super init]) {
        _optionsArray = options;
    }
    return self;
}


- (void)willMoveToSuperview:(UIView *)newSuperview{
    
    
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    for (UIView* itemView in self.subviews) {
        [itemView removeFromSuperview];
    }
    
    CGFloat OptionItemX = 0;
    CGFloat OptionItemY = 0;
    
    for (int i = 0; i < _optionsArray.count; i++) {
        UIButton* item = [UIButton buttonWithType:UIButtonTypeCustom];
        OptionItemX = i * OptionItemWidth;
        OptionItemY = 0;
        item.frame = CGRectMake(OptionItemX, OptionItemY, OptionItemWidth, OptionItemHeight);
        
        [item setTitle:_optionsArray[i] forState:UIControlStateNormal];
        [item setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [self.contentView addSubview:item];
        
        [item addTarget:self action:@selector(itemTouch:) forControlEvents:UIControlEventTouchUpInside];
        
        item.tag = i;
        if (i == _currentIndex) {
            item.selected = YES;
            _currentBtn = item;
        }
    }
    
    _contentView.frame = CGRectMake(0, 0, self.frame.size.width, OptionItemHeight);
    _contentView.contentSize = CGSizeMake(OptionItemWidth * _optionsArray.count, 0);
}

-(void)itemTouch:(UIButton*)btn{
//    NSLog(@"%ld",btn.tag);
    if (btn.tag == _currentBtn.tag)return;
    _currentBtn.selected = NO;
    btn.selected = YES;
    self.currentIndex = btn.tag;
    _currentBtn = btn;
    if ([_delegate respondsToSelector:@selector(topOptionsView:didSelectedOptions:)]) {
        [_delegate topOptionsView:self didSelectedOptions:btn.tag];
    }
    
    
}

#pragma mark - setter 
//在赋予新值后，刷新视图
- (void)setOptionsArray:(NSArray *)optionsArray{
    _optionsArray = optionsArray;
//    [self setNeedsLayout];
}

#pragma mark - getter

-(UIScrollView *)contentView{
    if (!_contentView) {
        UIScrollView* contentView = [[UIScrollView alloc]init];
        contentView.showsVerticalScrollIndicator = NO;
        contentView.showsHorizontalScrollIndicator = NO;
//        contentView.bounces = NO;
        _contentView = contentView;
        [self addSubview:contentView];
    }
    return _contentView;
}

-(void)setCurrentIndex:(NSInteger)currentIndex{
    UIButton* selectedBtn = nil;
    for (UIButton* btn in _contentView.subviews) {
        
        if([btn isKindOfClass:[UIButton class]]) {
            if (btn.tag == currentIndex) {
                selectedBtn = btn;
            }
        }
    }
//    NSLog(@"%ld",currentIndex);
    if (_currentBtn.tag == selectedBtn.tag || _currentIndex < 0 || _currentIndex > _optionsArray.count - 1) return;
    _currentBtn.selected = NO;
    selectedBtn.selected = YES;
    _currentBtn = selectedBtn;
    _currentIndex = currentIndex;
    
    CGFloat offsetX = 0;
    
    if ( CGRectGetMaxX(selectedBtn.frame) > self.frame.size.width) {
        offsetX = _contentView.contentOffset.x + CGRectGetMaxX(selectedBtn.frame) - _contentView.contentOffset.x - self.frame.size.width;
    }
//    当当前item不是最后一个时，把下一个也推出展示
    if (currentIndex < _optionsArray.count - 1 && currentIndex > self.frame.size.width / OptionItemWidth - 1) {
        offsetX += OptionItemWidth;
    }
//    NSLog(@"%f",offsetX);
    [UIView animateWithDuration:0.1 animations:^{
        self.contentView.contentOffset = CGPointMake(offsetX, 0);
    }];
    
}

@end
