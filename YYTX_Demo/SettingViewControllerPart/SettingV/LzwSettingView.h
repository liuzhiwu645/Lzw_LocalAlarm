//
//  LzwSettingView.h
//  YYTX_Demo
//
//  Created by pc37 on 2017/9/26.
//  Copyright © 2017年 Zhiwu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LzwSettingViewDelegate <NSObject>

//用量按钮协议方法
- (void)lzwSettingViewEveryDosageButtonAction:(UIButton *)btn;
//重复按钮协议方法
- (void)lzwSettingViewRepetiButtonAction:(UIButton *)btn;
//时间按钮协议方法
- (void)lzwSettingViewTimeButtonAction:(UIButton *)btn;
//保存按钮协议方法
- (void)lzwSettingViewSaveButtonAction:(NSString *)drugName everyDosage:(NSString *)everyDosage repetition:(NSString *)repetition niticeTime:(NSString *)niticeTime remark:(NSString *)remark;

@end

@interface LzwSettingView : UIView

@property (nonatomic, strong) UITextField *textDrugShow;//药品名
@property (nonatomic, strong) UILabel *labelEveryDosageShow;//每次用量
@property (nonatomic, strong) UILabel *labelRepetitionShow;//重复
@property (nonatomic, strong) UILabel *labelTimeShow;//时间
@property (nonatomic, strong) UITextView *textViewRemark;//个人备注

@property (nonatomic, assign) id<LzwSettingViewDelegate>mydelegate;

@end
