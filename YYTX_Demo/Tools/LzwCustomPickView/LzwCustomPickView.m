//
//  LzwCustomPickView.m
//  YYTX_Demo
//
//  Created by pc37 on 2017/9/26.
//  Copyright © 2017年 Zhiwu. All rights reserved.
//

#import "LzwCustomPickView.h"

@interface LzwCustomPickView ()
<UIPickerViewDelegate,
UIPickerViewDataSource
>
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *toolBar;
@property (nonatomic, copy) lzwRighPickerDidSelectBlock didRighSelectBlock;
@property (nonatomic, copy) lzwLeftPickerDidSelectBlock didLeftSelectBlock;
@property (nonatomic, strong) NSArray<NSArray<NSString *> *> *datas;
@property (nonatomic, assign) NSInteger indexPathLeft;
@property (nonatomic, assign) NSInteger indexPathRigh;

@end

@implementation LzwCustomPickView
- (UIView *)bgView
{
    if (_bgView==nil) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Lzw_WIDTH, Lzw_HEIGHT)];
        _bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)];
        [_bgView addGestureRecognizer:tap];
        
        [_bgView addSubview:self];
        [_bgView addSubview:self.toolBar];
        
        
    }
    return _bgView;
}
- (UIView *)toolBar
{
    if (_toolBar==nil) {
        _toolBar = [[UIView alloc] initWithFrame:CGRectMake(0, Lzw_HEIGHT-self.bounds.size.height-34, Lzw_WIDTH, 34)];
        _toolBar.backgroundColor = [UIColor whiteColor];
        
        UIButton *finishBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [finishBtn setTitle:@"完成" forState:UIControlStateNormal];
        finishBtn.frame = CGRectMake(Lzw_WIDTH-60, 0, 60, _toolBar.bounds.size.height);
        [finishBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        finishBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [finishBtn addTarget:self action:@selector(finishClick:) forControlEvents:UIControlEventTouchUpInside];
        [_toolBar addSubview:finishBtn];
        
        UILabel *labelTip = [[UILabel alloc]init];
        labelTip.font = [UIFont systemFontOfSize:13.0];
        labelTip.textAlignment = NSTextAlignmentCenter;
        labelTip.textColor = [UIColor darkGrayColor];
        labelTip.text = @"请选择服药剂量";
        [_toolBar addSubview:labelTip];
        
        [labelTip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_toolBar);
            make.top.equalTo(_toolBar).offset(10);
            make.height.equalTo(@20);
            make.width.mas_greaterThanOrEqualTo(@120);
        }];
        
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        cancelBtn.frame = CGRectMake(0, 0, 60, _toolBar.bounds.size.height);
        [cancelBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [cancelBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        [_toolBar addSubview:cancelBtn];
    }
    return _toolBar;
}
- (void)finishClick:(UIButton *)btn
{
    if (self.didLeftSelectBlock) {
        if (self.datas.count) {
            self.didLeftSelectBlock(self.indexPathLeft);
        }
    }
    if (self.didRighSelectBlock) {
        if (self.datas.count) {
            self.didRighSelectBlock(self.indexPathRigh);
        }
    }
    [self close];
}

- (void)close
{
    [self.bgView removeFromSuperview];
    [self removeFromSuperview];
    [self.toolBar removeFromSuperview];
    self.toolBar = nil;
    self.bgView = nil;
}

- (void)show
{
    //设置默认值
    self.indexPathLeft = 0;
    self.indexPathRigh = 4;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.bgView];
}

+ (void)show:(NSArray<NSArray<NSString *> *> *)datas didLeftSelectBlock:(lzwLeftPickerDidSelectBlock)didLeftSelectBlock didRighSelectBlock:(lzwRighPickerDidSelectBlock)didRifhSelectBlock
{
    LzwCustomPickView *pickerView = [[LzwCustomPickView alloc] initWithFrame:CGRectMake(0, Lzw_HEIGHT-220, Lzw_WIDTH, 220)];
    pickerView.didLeftSelectBlock = didLeftSelectBlock;
    pickerView.didRighSelectBlock = didRifhSelectBlock;
    pickerView.datas = datas;
    pickerView.backgroundColor = [UIColor whiteColor];
    pickerView.delegate = pickerView;
    pickerView.dataSource = pickerView;
    pickerView.showsSelectionIndicator = YES;
    //设置默认选中的位置
    [pickerView selectRow:4 inComponent:1 animated:YES];
    [pickerView show];
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.datas.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.datas[component].count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.datas[component][row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        self.indexPathLeft = row;
    }
    else if (component == 1)
    {
        self.indexPathRigh = row;
    }
    else
    {
        
    }
    
//    self.indexPath = [NSIndexPath indexPathForRow:row inSection:component];
}


@end
