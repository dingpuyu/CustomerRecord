//
//  ViewController.m
//  RecommendationRecord
//
//  Created by xiaotei's on 15/11/18.
//  Copyright © 2015年 xiaotei's. All rights reserved.
//

#import "ViewController.h"
#import "RecommendationRecordView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initRecommendationRecordView];
}
/**
 *  初始化报备记录视图
 */
-(void)initRecommendationRecordView{
    RecommendationRecordView* rrView = [[RecommendationRecordView alloc]init];
    rrView.frame = CGRectMake(0, 64, [[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height - 64 - 49);
    [self.view addSubview:rrView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
