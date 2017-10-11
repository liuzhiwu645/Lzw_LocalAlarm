//
//  LzwSettingViewController.m
//  YYTX_Demo
//
//  Created by pc37 on 2017/9/26.
//  Copyright © 2017年 Zhiwu. All rights reserved.
//

#import "LzwSettingViewController.h"
#import "LzwSettingView.h"

@interface LzwSettingViewController ()
<
LzwSettingViewDelegate,
CZPickerViewDataSource,
CZPickerViewDelegate
>

@property (nonatomic, strong) LzwSettingView *settingView;
@property(strong,nonatomic) NSArray *weeks;
//时间选择Arr
@property(strong,nonatomic)NSMutableArray *weeksArr;
@property(strong,nonatomic) CZPickerView *pickerWithImage;
@property (nonatomic, strong) NSMutableArray *arrayLeft;
@property (nonatomic, strong) NSMutableArray *arrayRigh;
@property (nonatomic, strong) NSString *leftString;
@property (nonatomic, strong) NSString *rightString;

@end

@implementation LzwSettingViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //判断是修改还是新建
    if (self.noticeId != nil) {
        LzwLocalNoticeModelDBTool *noticeDBTool = [LzwLocalNoticeModelDBTool shareInstance];
        self.noticeModel = [noticeDBTool selectLocalNoticeModelWithNoticeId:self.noticeId];
        
        NSInteger num = [self.noticeModel.noticeTime integerValue];
        
        _settingView.textDrugShow.text = [NSString stringWithFormat:@"%@", _noticeModel.noticeName];
        _settingView.labelRepetitionShow.text = [NSString stringWithFormat:@"%@", _noticeModel.noticeWeek];
        _settingView.labelTimeShow.text = [NSString stringWithFormat:@"%@", _noticeModel.noticeTime];
        _settingView.textViewRemark.text = [NSString stringWithFormat:@"%@", _noticeModel.noticeRemark];
        _settingView.labelEveryDosageShow.text = [NSString stringWithFormat:@"%@", _noticeModel.noticeeveryDosage];
        NSLog(@"%@", _noticeModel.noticeName);
        NSLog(@"%ld", num);

    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"服药提醒";
    self.weeks = @[@"周一", @"周二", @"周三", @"周四", @"周五",@"周六",@"周日"];
    
    self.arrayLeft = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"20",@"30",@"40",@"50",@"60",@"70",@"80",@"90",@"100",@"200", nil];
    self.arrayRigh = [NSMutableArray arrayWithObjects:@"mg",@"g",@"ml",@"片",@"粒",@"丸",@"贴",@"袋",@"滴",@"瓶",nil];
    
    //创建返回按钮
    [self creatReturnLeftBarItem];
    //创建子视图
    [self creatViewSubviews];
}
#pragma mark -- 创建子视图
- (void)creatViewSubviews
{
    self.settingView = [[LzwSettingView alloc]initWithFrame:CGRectMake(0, 64, Lzw_WIDTH, Lzw_HEIGHT - 64)];
    _settingView.backgroundColor = LzwColor(238, 238, 238);
    _settingView.mydelegate = self;
    [self.view addSubview:_settingView];
}
#pragma mark -- 每次用量按钮点击事件
-(void)lzwSettingViewEveryDosageButtonAction:(UIButton *)btn
{
    [LzwCustomPickView show:@[_arrayLeft, _arrayRigh] didLeftSelectBlock:^(NSInteger left) {
        
        _leftString = [NSString stringWithFormat:@"%@", _arrayLeft[left]];
        
    } didRighSelectBlock:^(NSInteger righ) {
        
        _rightString = [NSString stringWithFormat:@"%@", _arrayRigh[righ]];
        _settingView.labelEveryDosageShow.text = [NSString stringWithFormat:@"%@%@", _leftString, _rightString];
    }];
    
    
}
//重复
-(void)lzwSettingViewRepetiButtonAction:(UIButton *)btn
{
    CZPickerView *picker = [[CZPickerView alloc] initWithHeaderTitle:@"重复设置" cancelButtonTitle:@"取消" confirmButtonTitle:@"确认"];
    picker.delegate = self;
    picker.dataSource = self;
    picker.allowMultipleSelection = YES;
    [picker show];
}
#pragma mark -- CZPickerView 协议方法
- (NSAttributedString *)czpickerView:(CZPickerView *)pickerView
               attributedTitleForRow:(NSInteger)row{
    
    NSAttributedString *att = [[NSAttributedString alloc]
                               initWithString:self.weeks[row]
                               attributes:@{
                                            NSFontAttributeName:[UIFont fontWithName:@"Avenir-Light" size:18.0]
                                            }];
    return att;
}

- (NSString *)czpickerView:(CZPickerView *)pickerView
               titleForRow:(NSInteger)row{
    return self.weeks[row];
}



- (NSInteger)numberOfRowsInPickerView:(CZPickerView *)pickerView{
    return self.weeks.count;
}

- (void)czpickerView:(CZPickerView *)pickerView didConfirmWithItemAtRow:(NSInteger)row{
    NSLog(@"www%@", self.weeks[row]);
}

-(void)czpickerView:(CZPickerView *)pickerView didConfirmWithItemsAtRows:(NSArray *)rows{
    self.weeksArr = [[NSMutableArray alloc]initWithCapacity:self.weeks.count];
    NSMutableString *weeksStr = [[NSMutableString alloc]initWithString:@""];
    
    for(NSNumber *n in rows){
        NSInteger row = [n integerValue];
        NSLog(@"eee%@", self.weeks[row]);
        //加载所选重复时间
        [self.weeksArr addObject:self.weeks[row]];
        //拼接字符串
        [weeksStr appendFormat:@" %@",self.weeks[row]];
        
    }

    _settingView.labelRepetitionShow.text = weeksStr;
    
}

- (void)czpickerViewDidClickCancelButton:(CZPickerView *)pickerView{
    NSLog(@"Canceled.");
}

#pragma mark -- 设置时间按钮点击事件
-(void)lzwSettingViewTimeButtonAction:(UIButton *)btn
{
    __weak typeof(self) weakSelf = self;
    WSDatePickerView *datePickView = [[WSDatePickerView alloc]initWithDateStyle:DateStyleShowHourMinute CompleteBlock:^(NSDate *data) {
        NSString *date = [data stringWithFormat:@"HH:mm"];
        weakSelf.settingView.labelTimeShow.text = date;
    }];
    [datePickView show];
    [self.view addSubview:datePickView];
}
#pragma mark -- 保存按钮点击事件
-(void)lzwSettingViewSaveButtonAction:(NSString *)drugName everyDosage:(NSString *)everyDosage repetition:(NSString *)repetition niticeTime:(NSString *)niticeTime remark:(NSString *)remark
{
    NSLog(@"保存 = %@--%@--%@--%@--%@", drugName, everyDosage, repetition, niticeTime, remark);

    LzwLocalNoticeModelDBTool *noticeDBTool = [LzwLocalNoticeModelDBTool shareInstance];
    [noticeDBTool createTable];
    //在这里判断是修改还是新建,修改就更新数据
    if (self.noticeId != nil) {
        //说明是修改更新数据
        [noticeDBTool updateModelWithkey:@"nTime" value:niticeTime nId:self.noticeId];
        [noticeDBTool updateModelWithkey:@"nWeek" value:repetition nId:self.noticeId];
        [noticeDBTool updateModelWithkey:@"nName" value:drugName nId:self.noticeId];
        [noticeDBTool updateModelWithkey:@"nRemark" value:remark nId:self.noticeId];
        [noticeDBTool updateModelWithkey:@"nIsOpen" value:@"1" nId:self.noticeId];
        [noticeDBTool updateModelWithkey:@"nDosage" value:everyDosage nId:self.noticeId];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        //判断数据完整性
        if (drugName ==nil || everyDosage == nil || repetition == nil || niticeTime == nil) {
            [self.view makeToast:@"数据不完全!" duration:1.0 position:CSToastPositionCenter];
        }
        else
        {
            //说明是新建
            NSDictionary *noticeDic = @{@"noticeTime":niticeTime,@"noticeWeek":repetition,@"isOpen":@"1", @"noticeName":drugName, @"noticeRemark":remark, @"noticeeveryDosage":everyDosage};
            LzwRootModel *noticeModel =[[LzwRootModel alloc]initWithDictionary:noticeDic];
            [noticeDBTool insertModel:noticeModel vc:self];
        }
    }
}

#pragma mark -- 创建返回按钮
- (void)creatReturnLeftBarItem
{
    UIButton *buttonReturn = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonReturn setImage:[UIImage imageNamed:@"btn_back_normal"] forState:UIControlStateNormal];
    buttonReturn.frame = CGRectMake(0, 0, 40, 20);
    UIBarButtonItem *returnBtn = [[UIBarButtonItem alloc]initWithCustomView:buttonReturn];
    self.navigationItem.leftBarButtonItem = returnBtn;
    [buttonReturn addTarget:self action:@selector(returnButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark -- 返回按钮点击事件
- (void)returnButtonAction:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
