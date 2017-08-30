//
//  ZHDatePickerView.h
//  ZHDatePickerViewDemo
//
//  Created by 曾浩 on 2016/12/21.
//  Copyright © 2016年 Lebronjames_zh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZHDatePickerView;

@protocol ZHDatePickerViewDelegate <NSObject>

@optional
/**
 返回选择的时间字符串

 @param pickerView pickerView
 @param dateString 时间字符串
 */
- (void)pickerView:(ZHDatePickerView *)pickerView didSelectDateString:(NSString *)dateString;

@end

@interface ZHDatePickerView : UIView

@property (nonatomic, weak) id <ZHDatePickerViewDelegate> delegate;

/**
 设置确定按钮颜色
 */
@property (nonatomic, strong) UIColor *rightBarColor;

/**
 设置toolbar背景色
 */
@property (nonatomic, strong) UIColor *toolBarTintColor;

/**
 初始化ZHDatePickerView
 
 @param date 默认时间
 @param datePickerMode 时间显示格式
 @return ZHDatePickerView
 */
- (instancetype)initDatePickerWithDefaultDate:(NSDate *)date
                               datePickerMode:(UIDatePickerMode)datePickerMode;

/**
 移除ZHPickerViewView
 */
- (void)remove;

/**
 显示ZHPickerViewView
 */
- (void)show;

@end
