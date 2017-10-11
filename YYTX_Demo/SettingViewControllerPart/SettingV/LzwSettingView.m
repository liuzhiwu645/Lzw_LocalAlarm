//
//  LzwSettingView.m
//  YYTX_Demo
//
//  Created by pc37 on 2017/9/26.
//  Copyright © 2017年 Zhiwu. All rights reserved.
//

#import "LzwSettingView.h"

@interface LzwSettingView ()<UITextViewDelegate>

@property (nonatomic, strong) UIView *viewDrugName;
@property (nonatomic, strong) UIView *viewDosage;
@property (nonatomic, strong) UIView *viewRepetition;
@property (nonatomic, strong) UIView *viewTime;

@property (nonatomic, strong) UILabel *labelDrug;//药品名
@property (nonatomic, strong) UILabel *labelEveryDosage;//每次用量
@property (nonatomic, strong) UILabel *labelPeriod;//服用周期
@property (nonatomic, strong) UILabel *labelRepetition;//重复
@property (nonatomic, strong) UILabel *labelTime;//时间
@property (nonatomic, strong) UILabel *labelRemark;//个人备注

@end

@implementation LzwSettingView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatLzwSettingViewSubViews];
    }
    return self;
}

- (void)creatLzwSettingViewSubViews
{
    //第一个View
    self.viewDrugName = [[UIView alloc]init];
    _viewDrugName.backgroundColor = [UIColor whiteColor];
    [self addSubview:_viewDrugName];
    
    [_viewDrugName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@15);
        make.left.equalTo(@0);
        make.width.equalTo(@(Lzw_WIDTH));
        make.height.equalTo(@50);
    }];
    self.labelDrug = [[UILabel alloc]init];
    _labelDrug.font = [UIFont systemFontOfSize:15.0];
    _labelDrug.backgroundColor = [UIColor clearColor];
    _labelDrug.text = @"药品名:";
    _labelDrug.textAlignment = NSTextAlignmentLeft;
    _labelDrug.textColor = [UIColor darkGrayColor];
    [_viewDrugName addSubview:_labelDrug];
    
    [_labelDrug mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_viewDrugName);
        make.left.equalTo(_viewDrugName.mas_left).offset(10);
        make.height.equalTo(@30);
        make.width.mas_greaterThanOrEqualTo(80);
    }];
    
    self.textDrugShow = [[UITextField alloc]init];
    _textDrugShow.font = [UIFont systemFontOfSize:15.0];
    _textDrugShow.backgroundColor = [UIColor clearColor];
    _textDrugShow.placeholder = @"请输入药品名称";
    _textDrugShow.clearButtonMode = UITextFieldViewModeAlways;
    _textDrugShow.textAlignment = NSTextAlignmentLeft;
    _textDrugShow.textColor = [UIColor darkGrayColor];
    [_viewDrugName addSubview:_textDrugShow];
    
    [_textDrugShow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_viewDrugName);
        make.left.equalTo(_labelDrug.mas_right).offset(5);
        make.height.equalTo(_labelDrug);
        make.right.equalTo(_viewDrugName.mas_right).offset(-5);
    }];
    
    //第二个View
    self.viewDosage = [[UIView alloc]init];
    _viewDosage.backgroundColor = [UIColor whiteColor];
    [self addSubview:_viewDosage];
    
    [_viewDosage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_viewDrugName.mas_bottom).offset(3);
        make.left.equalTo(@0);
        make.width.equalTo(@(Lzw_WIDTH));
        make.height.equalTo(@50);
    }];
    self.labelEveryDosage = [[UILabel alloc]init];
    _labelEveryDosage.font = [UIFont systemFontOfSize:15.0];
    _labelEveryDosage.backgroundColor = [UIColor clearColor];
    _labelEveryDosage.text = @"每次用量:";
    _labelEveryDosage.textAlignment = NSTextAlignmentLeft;
    _labelEveryDosage.textColor = [UIColor darkGrayColor];
    [_viewDosage addSubview:_labelEveryDosage];
    
    [_labelEveryDosage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_viewDosage);
        make.left.equalTo(_viewDosage.mas_left).offset(10);
        make.height.equalTo(@30);
        make.width.mas_greaterThanOrEqualTo(100);
    }];
    
    self.labelEveryDosageShow = [[UILabel alloc]init];
    _labelEveryDosageShow.font = [UIFont systemFontOfSize:15.0];
    _labelEveryDosageShow.backgroundColor = [UIColor clearColor];
    _labelEveryDosageShow.textAlignment = NSTextAlignmentRight;
    _labelEveryDosageShow.textColor = [UIColor darkGrayColor];
    //_labelEveryDosageShow.text = @"1片";//默认
    [_viewDosage addSubview:_labelEveryDosageShow];
    
    [_labelEveryDosageShow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_viewDosage);
        make.left.equalTo(_labelEveryDosage.mas_right).offset(5);
        make.height.equalTo(_labelEveryDosage);
        make.right.equalTo(_viewDosage.mas_right).offset(-50);
    }];
    
    
    UIButton *buttonDosage = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonDosage setBackgroundImage:[UIImage imageNamed:@"all"] forState:UIControlStateNormal];
    [buttonDosage setBackgroundImage:[UIImage imageNamed:@"all"] forState:UIControlStateHighlighted];
    [buttonDosage setEnlargeEdgeWithTop:15 right:10 bottom:15 left:375];
    [_viewDosage addSubview:buttonDosage];
    
    [buttonDosage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_viewDosage);
        make.right.equalTo(_viewDosage.mas_right).offset(-10);
        make.width.height.equalTo(@20);
    }];
    [buttonDosage addTarget:self action:@selector(everyHowMuchDosageButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //服用周期
    self.labelPeriod = [[UILabel alloc]init];
    _labelPeriod.font = [UIFont systemFontOfSize:15.0];
    _labelPeriod.backgroundColor = [UIColor clearColor];
    _labelPeriod.text = @"服用周期";
    _labelPeriod.textAlignment = NSTextAlignmentLeft;
    _labelPeriod.textColor = [UIColor darkGrayColor];
    [self addSubview:_labelPeriod];
    
    [_labelPeriod mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_viewDosage.mas_bottom).offset(10);
        make.left.equalTo(@10);
        make.width.mas_greaterThanOrEqualTo(100);
        make.height.equalTo(@30);
    }];
    
    //第三个View
    self.viewRepetition = [[UIView alloc]init];
    _viewRepetition.backgroundColor = [UIColor whiteColor];
    [self addSubview:_viewRepetition];
    
    [_viewRepetition mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_labelPeriod.mas_bottom).offset(10);
        make.left.equalTo(@0);
        make.width.equalTo(@(Lzw_WIDTH));
        make.height.equalTo(@50);
    }];
    self.labelRepetition= [[UILabel alloc]init];
    _labelRepetition.font = [UIFont systemFontOfSize:15.0];
    _labelRepetition.backgroundColor = [UIColor clearColor];
    _labelRepetition.text = @"重复:";
    _labelRepetition.textAlignment = NSTextAlignmentLeft;
    _labelRepetition.textColor = [UIColor darkGrayColor];
    [_viewRepetition addSubview:_labelRepetition];
    
    [_labelRepetition mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_viewRepetition);
        make.left.equalTo(_viewRepetition.mas_left).offset(10);
        make.height.equalTo(@30);
        make.width.mas_greaterThanOrEqualTo(100);
    }];
    
    self.labelRepetitionShow = [[UILabel alloc]init];
    _labelRepetitionShow.font = [UIFont systemFontOfSize:15.0];
    _labelRepetitionShow.backgroundColor = [UIColor clearColor];
    _labelRepetitionShow.textAlignment = NSTextAlignmentRight;
    _labelRepetitionShow.textColor = [UIColor darkGrayColor];
    [_viewRepetition addSubview:_labelRepetitionShow];
    
    [_labelRepetitionShow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_viewRepetition);
        make.left.equalTo(_labelRepetition.mas_right).offset(5);
        make.height.equalTo(_labelRepetition);
        make.right.equalTo(_viewRepetition.mas_right).offset(-50);
    }];
    
    UIButton *buttonRepetition = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonRepetition setBackgroundImage:[UIImage imageNamed:@"all"] forState:UIControlStateNormal];
    [buttonRepetition setBackgroundImage:[UIImage imageNamed:@"all"] forState:UIControlStateHighlighted];
    [buttonRepetition setEnlargeEdgeWithTop:15 right:10 bottom:10 left:375];
    [_viewRepetition addSubview:buttonRepetition];
    
    [buttonRepetition mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_viewRepetition);
        make.right.equalTo(_viewRepetition.mas_right).offset(-10);
        make.width.height.equalTo(@20);
    }];
    [buttonRepetition addTarget:self action:@selector(buttonRepetitionAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //第4个View
    self.viewTime = [[UIView alloc]init];
    _viewTime.backgroundColor = [UIColor whiteColor];
    [self addSubview:_viewTime];
    
    [_viewTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_viewRepetition.mas_bottom).offset(3);
        make.left.equalTo(@0);
        make.width.equalTo(@(Lzw_WIDTH));
        make.height.equalTo(@50);
    }];
    self.labelTime= [[UILabel alloc]init];
    _labelTime.font = [UIFont systemFontOfSize:15.0];
    _labelTime.backgroundColor = [UIColor clearColor];
    _labelTime.text = @"时间:";
    _labelTime.textAlignment = NSTextAlignmentLeft;
    _labelTime.textColor = [UIColor darkGrayColor];
    [_viewTime addSubview:_labelTime];
    
    [_labelTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_viewTime);
        make.left.equalTo(_viewTime.mas_left).offset(10);
        make.height.equalTo(@30);
        make.width.mas_greaterThanOrEqualTo(100);
    }];
    
    self.labelTimeShow = [[UILabel alloc]init];
    _labelTimeShow.font = [UIFont systemFontOfSize:15.0];
    _labelTimeShow.backgroundColor = [UIColor clearColor];
    _labelTimeShow.textAlignment = NSTextAlignmentRight;
    _labelTimeShow.textColor = [UIColor darkGrayColor];
    [_viewTime addSubview:_labelTimeShow];
    
    [_labelTimeShow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_viewTime);
        make.left.equalTo(_labelTime.mas_right).offset(5);
        make.height.equalTo(_labelTime);
        make.right.equalTo(_viewTime.mas_right).offset(-50);
    }];
    
    
    UIButton *buttonTime = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonTime setImage:[UIImage imageNamed:@"all"] forState:UIControlStateNormal];
    [buttonTime setImage:[UIImage imageNamed:@"all"] forState:UIControlStateHighlighted];
    [buttonTime setEnlargeEdgeWithTop:15 right:10 bottom:15 left:375];
    [_viewTime addSubview:buttonTime];
    
    [buttonTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_viewTime);
        make.right.equalTo(_viewTime.mas_right).offset(-10);
        make.width.height.equalTo(@20);
    }];
    [buttonTime addTarget:self action:@selector(buttonTimeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //个人备注
    self.labelRemark = [[UILabel alloc]init];
    _labelRemark.font = [UIFont systemFontOfSize:15.0];
    _labelRemark.backgroundColor = [UIColor clearColor];
    _labelRemark.text = @"个人备注";
    _labelRemark.textAlignment = NSTextAlignmentLeft;
    _labelRemark.textColor = [UIColor darkGrayColor];
    [self addSubview:_labelRemark];
    
    [_labelRemark mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_viewTime.mas_bottom).offset(10);
        make.left.equalTo(@10);
        make.width.mas_greaterThanOrEqualTo(100);
        make.height.equalTo(@30);
    }];

    self.textViewRemark = [[UITextView alloc]init];
    _textViewRemark.backgroundColor = [UIColor whiteColor];
    _textViewRemark.textColor = [UIColor darkGrayColor];
    _textViewRemark.delegate = self;
    _textViewRemark.text = @"点击在此添加备注";
    [self addSubview:_textViewRemark];
    
    [_textViewRemark mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_labelRemark.mas_bottom).offset(10);
        make.left.equalTo(@0);
        make.width.equalTo(@(Lzw_WIDTH));
        make.height.equalTo(@100);
    }];
    
    UIButton *buttonSave = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonSave setTitle:@"保存" forState:UIControlStateNormal];
    buttonSave.backgroundColor = LzwColor(116, 206, 246);
    buttonSave.layer.cornerRadius = 5.0;
    [self addSubview:buttonSave];
    
    [buttonSave mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_textViewRemark.mas_bottom).offset(50);
        make.centerX.equalTo(self);
        make.width.equalTo(@200);
        make.height.equalTo(@30);
    }];
    
    [buttonSave addTarget:self action:@selector(saveButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
}
#pragma mark -- 保存按钮点击事件
- (void)saveButtonAction:(UIButton *)button
{
    NSLog(@"保存");
    [self.mydelegate lzwSettingViewSaveButtonAction:_textDrugShow.text everyDosage:_labelEveryDosageShow.text repetition:_labelRepetitionShow.text niticeTime:_labelTimeShow.text remark:_textViewRemark.text];
}
#pragma mark -- 每次用量按钮点击事件
- (void)everyHowMuchDosageButtonAction:(UIButton *)button
{
    [_textDrugShow resignFirstResponder];
    [_textViewRemark resignFirstResponder];
    NSLog(@"每次用量");
    [self.mydelegate lzwSettingViewEveryDosageButtonAction:button];
}
#pragma mark -- 重复按钮点击事件
- (void)buttonRepetitionAction:(UIButton *)button
{
    [_textDrugShow resignFirstResponder];
    [_textViewRemark resignFirstResponder];
    NSLog(@"重复");
    [self.mydelegate lzwSettingViewRepetiButtonAction:button];
}
#pragma mark -- 时间按钮点击事件
- (void)buttonTimeAction:(UIButton *)button
{
    [_textDrugShow resignFirstResponder];
    [_textViewRemark resignFirstResponder];
    NSLog(@"时间");
    [self.mydelegate lzwSettingViewTimeButtonAction:button];
}

#pragma mark - UITextViewDelegate
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if(textView.text.length < 1){
        textView.text = @"点击在此添加备注";
        textView.textColor = [UIColor grayColor];
    }
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if([textView.text isEqualToString:@"点击在此添加备注"]){
        textView.text=@"";
        textView.textColor=[UIColor blackColor];
    }
}

//回收键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_textDrugShow resignFirstResponder];
    [_textViewRemark resignFirstResponder];
}

@end
