//
//  ZHDatePickerView.m
//  ZHDatePickerViewDemo
//
//  Created by 曾浩 on 2016/12/21.
//  Copyright © 2016年 Lebronjames_zh. All rights reserved.
//
#define SCREEN_W [UIScreen mainScreen].bounds.size.width
#define SCREEN_H [UIScreen mainScreen].bounds.size.height
static float ToolbarH = 44;

#import "ZHDatePickerView.h"

@interface ZHDatePickerView ()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIToolbar *toolBar;
@property (nonatomic, strong) UIButton *hiddenButton;

@end

@implementation ZHDatePickerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H);
        self.tag   = 1001;
        self.alpha = 0.0;
        self.backgroundColor = [UIColor colorWithRed:0/255.0
                                               green:0/255.0
                                                blue:0/255.0
                                               alpha:0.25];
    }
    return self;
}

/**
 初始化ZHDatePickerView
 
 @param date 默认时间
 @param datePickerMode 时间显示格式
 @return ZHDatePickerView
 */
- (instancetype)initDatePickerWithDefaultDate:(NSDate *)date
                               datePickerMode:(UIDatePickerMode)datePickerMode
{
    self = [super init];
    
    if (self)
    {
        [self setupView];
        
        self.datePicker.datePickerMode = datePickerMode;
        if (date) [self.datePicker setDate:date];
    }
    return self;
}

#pragma mark -- 页面布局

/**
 页面界面
 */
- (void)setupView
{
    [self addSubview:self.hiddenButton];
    [self addSubview:self.containerView];
    
    [self.containerView addSubview:self.toolBar];
    [self.containerView addSubview:self.datePicker];
}

#pragma mark -- 内部方法

/**
 设置确定按钮颜色

 @param rightBarColor rightBarColor
 */
- (void)setRightBarColor:(UIColor *)rightBarColor
{
    _rightBarColor = rightBarColor;
    UIBarButtonItem *rightItem = (UIBarButtonItem *)self.toolBar.items[2];
    [rightItem setTintColor:rightBarColor];
}

/**
 设置toolbar背景色

 @param toolBarTintColor toolBarTintColor
 */
- (void)setToolBarTintColor:(UIColor *)toolBarTintColor
{
    _toolBarTintColor = toolBarTintColor;
    self.toolBar.barTintColor = toolBarTintColor;
}

/**
 确定
 */
- (void)doneClick
{
    NSDate *select = self.datePicker.date;
    NSDateFormatter *dateFormmater = [[NSDateFormatter alloc] init];
    [dateFormmater setDateFormat:@"yyyy-MM-dd"];
    NSString *resultString = [dateFormmater stringFromDate:select];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(pickerView:didSelectDateString:)])
    {
        [self.delegate pickerView:self didSelectDateString:resultString];
    }
    
    [self remove];
}

/**
 显示ZHPickerViewView
 */
- (void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    // container Y值
    CGFloat containerY = SCREEN_H - (self.datePicker.frame.size.height + ToolbarH);
    
    [UIView animateWithDuration:0.35 animations:^ {
        
        self.alpha = 1.0;
        self.containerView.frame = CGRectMake(0, containerY, SCREEN_W, self.datePicker.frame.size.height + ToolbarH);
        
    } completion:^(BOOL finished) {
        self.hiddenButton.userInteractionEnabled = YES;
    }];
}

/**
 移除ZHPickerViewView
 */
- (void)remove
{
    self.hiddenButton.userInteractionEnabled = NO;
    
    [UIView animateWithDuration:0.35 animations:^ {
        self.alpha = 0.0;
        self.containerView.frame = CGRectMake(0, SCREEN_H, SCREEN_W, self.datePicker.frame.size.height + ToolbarH);
        
    } completion:^(BOOL finished) {
        
        for (UIView *view in [[UIApplication sharedApplication].keyWindow subviews])
        {
            if (view.tag == 1001) [view removeFromSuperview];
        }
    }];
}

#pragma mark -- 懒加载

/**
 DatePicker
 */
- (UIDatePicker *)datePicker
{
    if (!_datePicker)
    {
        _datePicker   = [[UIDatePicker alloc] init];
        _datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        _datePicker.backgroundColor = [UIColor whiteColor];
        // UIDatePicker默认高度216
        _datePicker.frame = CGRectMake(0, ToolbarH , SCREEN_W, _datePicker.frame.size.height);
    }
    return _datePicker;
}

/**
 工具栏
 */
- (UIToolbar *)toolBar
{
    if (!_toolBar)
    {
        _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, ToolbarH)];
        _toolBar.barStyle = UIBarStyleBlackTranslucent;
        // 设置UIToolbar背景色
        _toolBar.barTintColor = [UIColor colorWithRed:239.0/255.0
                                                green:239.0/255.0
                                                 blue:244.0/255.0
                                                alpha:1.0];
        // 取消按钮
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"   取消"
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(remove)];
        
        [leftItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} forState:UIControlStateNormal];
        [leftItem setTintColor:[UIColor grayColor]];
        
        UIBarButtonItem *centerSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        // 确定按钮
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"确定   "
                                                                      style:UIBarButtonItemStyleDone
                                                                     target:self
                                                                     action:@selector(doneClick)];
        [rightItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} forState:UIControlStateNormal];
        rightItem.tag = 1002;
        // 设置字体颜色
        //[rightItem setTintColor:[UIColor colorWithRed:67.0/255.0 green:199.0/255.0 blue:203.0/255.0 alpha:1.0]];
        
        _toolBar.items = @[leftItem,centerSpace,rightItem];
    }
    return _toolBar;
}

/**
 容器View

 @return UIView
 */
- (UIView *)containerView
{
    if (!_containerView) {
        _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_H, SCREEN_W, self.datePicker.frame.size.height + ToolbarH)];
        _containerView.backgroundColor = [UIColor whiteColor];
    }
    return _containerView;
}

/**
 点击空白区域隐藏

 @return UIButton
 */
- (UIButton *)hiddenButton
{
    if (!_hiddenButton) {
        _hiddenButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H - self.datePicker.frame.size.height - ToolbarH)];
        _hiddenButton.backgroundColor = [UIColor clearColor];
        _hiddenButton.userInteractionEnabled = NO;
        [_hiddenButton addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
    }
    return _hiddenButton;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
