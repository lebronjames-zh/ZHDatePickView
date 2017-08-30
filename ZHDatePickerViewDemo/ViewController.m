//
//  ViewController.m
//  ZHDatePickerViewDemo
//
//  Created by 曾浩 on 2016/12/21.
//  Copyright © 2016年 Lebronjames_zh. All rights reserved.
//

#import "ViewController.h"
#import "ZHDatePickerView.h"

@interface ViewController () <ZHDatePickerViewDelegate>

@property (nonatomic, strong) UIButton *dateButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
}

- (void)setupView
{
    UIButton *dateButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 120, 120)];
    dateButton.center = CGPointMake(self.view.center.x, 100);
    dateButton.layer.cornerRadius  = 3;
    dateButton.layer.masksToBounds = YES;
    [dateButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [dateButton setTitle:@"2016-12-15" forState:UIControlStateNormal];
    [dateButton addTarget:self action:@selector(showPickViewerAction) forControlEvents:UIControlEventTouchUpInside];
    self.dateButton = dateButton;
    
    [self.view addSubview:dateButton];
}

- (void)showPickViewerAction
{
    ZHDatePickerView *pickerView = [[ZHDatePickerView alloc] initDatePickerWithDefaultDate:nil datePickerMode:UIDatePickerModeDate];
    //pickerView.rightBarColor = [UIColor orangeColor];
    //pickerView.toolBarTintColor = [UIColor whiteColor];
    pickerView.delegate = self;
    [pickerView show];
}

/**
 选择时间回调方法

 @param pickerView pickerView
 @param dateString dateString 
 */
- (void)pickerView:(ZHDatePickerView *)pickerView didSelectDateString:(NSString *)dateString
{
    [self.dateButton setTitle:dateString forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
