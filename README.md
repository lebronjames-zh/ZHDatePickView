# ZHDatePickView
#喜欢或有用请 Star 谢谢。 

本人写项目用的日历自定义View，简单实用。使用系统UIDatePicker集成，显示年月日，调用代理方法回调选择的时间。请批评指正。
1. 初始化方法
/**
 初始化ZHDatePickerView
 
 @param date 默认时间
 @param mode 时间显示格式
 @return ZHDatePickerView
 */
- (instancetype)initDatePickerWithDefaultDate:(NSDate *)date
                            andDatePickerMode:(UIDatePickerMode )mode;
                            
2. 回调方法
/**
 返回选择的时间字符串

 @param pickerView pickerView
 @param dateString 时间字符串
 */
- (void)pickerView:(ZHDatePickerView *)pickerView didSelectDateString:(NSString *)dateString;
