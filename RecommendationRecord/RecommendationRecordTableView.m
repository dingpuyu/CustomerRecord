//
//  RecommendationRecordTableView.m
//  RecommendationRecord
//
//  Created by xiaotei's on 15/11/18.
//  Copyright © 2015年 xiaotei's. All rights reserved.
//

#import "RecommendationRecordTableView.h"



@interface RecommendationRecordTableView()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation RecommendationRecordTableView

-(instancetype)init{
    if (self = [super init]) {
        self.dataSource = self;
        self.delegate = self;
        self.direction = TableViewAnimationDirectionNone;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

#pragma mark - datasource
-(NSInteger)numberOfSections{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = _optionTitle;
    cell.detailTextLabel.text = _optionTitle;
    CGFloat offsetX = 0;
    cell.contentView.transform = CGAffineTransformMakeTranslation(offsetX, 0);
    [UIView animateWithDuration:indexPath.row * 0.2 animations:^{
        cell.contentView.transform =CGAffineTransformIdentity;
    }];
    cell.contentView.backgroundColor = [self randomColor];
    return cell;
}

-(void)setOptionTitle:(NSString *)optionTitle{
    _optionTitle = optionTitle;
    [self reloadData];
    self.contentOffset = CGPointZero;
}

-(UIColor*)randomColor{
    CGFloat hue = ( arc4random() % 256 / 256.0 ); //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

@end
