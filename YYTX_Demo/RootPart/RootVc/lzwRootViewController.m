//
//  lzwRootViewController.m
//  YYTX_Demo
//
//  Created by pc37 on 2017/9/26.
//  Copyright © 2017年 Zhiwu. All rights reserved.
//

#import "lzwRootViewController.h"
#import "LzwRootTableViewCell.h"
#import "LzwSettingViewController.h"

@interface lzwRootViewController ()
<UITableViewDelegate,
UITableViewDataSource,
LzwRootTableViewCellDelegate
>

@property (nonatomic, strong) UITableView *tableViewRoot;

@end

@implementation lzwRootViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_arrayRoot removeAllObjects];
    //开始请求数据(从数据库中读取)
    [self requestData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"用药提醒列表";
    self.arrayRoot = [NSMutableArray array];
    //创建表格
    [self creatRootTableViewSubviews];
    //创建添加用药提醒按钮
    [self addAlarmButton];
    
    //创建返回按钮
    
    
}
#pragma mark -- 返回按钮点击事件
- (void)onlyLeftbtnAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- 创建按钮添加用药提醒
- (void)addAlarmButton
{
    UIButton *buttonAdd = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonAdd setImage:[UIImage imageNamed:@"allWhite"] forState:UIControlStateNormal];
    [buttonAdd setImage:[UIImage imageNamed:@"allWhite"] forState:UIControlStateHighlighted];
    buttonAdd.frame = CGRectMake(0, 0, 40, 20);
    [buttonAdd setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithCustomView:buttonAdd];
    self.navigationItem.rightBarButtonItem = rightBtn;
    [buttonAdd addTarget:self action:@selector(addUserMecchileTip:) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark -- 跳转到添加提醒页面
- (void)addUserMecchileTip:(UIButton *)btn
{
    LzwSettingViewController *settingVc = [[LzwSettingViewController alloc]init];
    [self.navigationController pushViewController:settingVc animated:YES];
}

#pragma mark -- 创建表格视图
- (void)creatRootTableViewSubviews
{
    self.tableViewRoot = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Lzw_WIDTH, Lzw_HEIGHT) style:UITableViewStylePlain];
    _tableViewRoot.delegate = self;
    _tableViewRoot.dataSource = self;
    _tableViewRoot.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableViewRoot];
    
    [self.tableViewRoot registerClass:[LzwRootTableViewCell class] forCellReuseIdentifier:@"cellRoot"];
    
}
#pragma mark -- 从数据库中取数据
- (void)requestData
{
    LzwLocalNoticeModelDBTool *noticeModelDBTool = [LzwLocalNoticeModelDBTool shareInstance];
    NSMutableArray *arr = [NSMutableArray arrayWithArray:[noticeModelDBTool selectAllModel]];
    for (NSDictionary *dict in arr) {
        LzwRootModel *model = [[LzwRootModel alloc]init];
        model.noticeId = [dict valueForKey:@"noticeId"];
        model.noticeTime = [dict valueForKey:@"noticeTime"];
        model.noticeWeek = [dict valueForKey:@"noticeWeek"];
        model.isOpen = [dict valueForKey:@"isOpen"];
        model.noticeName = [dict valueForKey:@"noticeName"];
        model.noticeRemark = [dict valueForKey:@"noticeRemark"];
        model.noticeeveryDosage = [dict valueForKey:@"noticeeveryDosage"];
        //设置通知的时间
        [self setUpLocalNotification:model.noticeTime noticeID:model.noticeId repetition:model.noticeWeek];
        [self.arrayRoot addObject:model];
    }
    [self.tableViewRoot reloadData];
}
#pragma mark -- 表格协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_arrayRoot count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LzwRootTableViewCell *cellRoot = [tableView dequeueReusableCellWithIdentifier:@"cellRoot"];
    cellRoot.selectionStyle = UITableViewCellSelectionStyleNone;
    cellRoot.rootDelegate = self;
    cellRoot.modelRoot = _arrayRoot[indexPath.row];
    return cellRoot;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85.0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LzwSettingViewController *settingVc = [[LzwSettingViewController alloc]init];
    LzwRootModel *modelRoot = _arrayRoot[indexPath.row];
    settingVc.noticeId = modelRoot.noticeId;
    [self.navigationController pushViewController:settingVc animated:YES];
    
}
//允许编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TRUE;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle ==UITableViewCellEditingStyleDelete) {//如果编辑样式为删除样式
        
        if (indexPath.row<[self.arrayRoot count]) {
            LzwRootModel *noticeModel = self.arrayRoot[indexPath.row];
            LzwLocalNoticeModelDBTool *noticeDBTool = [LzwLocalNoticeModelDBTool shareInstance];
            [noticeDBTool deleteModelWithkey:@"Id" value:noticeModel.noticeId];
            [self cancelLocalNotificationWithKey:noticeModel.noticeId];
            [self.arrayRoot removeObject:noticeModel];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableViewRoot reloadData];
        }
    }
}


#pragma mark -- 开关按钮协议方法
-(void)userActionSwitchOn_Off:(UISwitch *)noticeSwitch
{
    NSString *isOpen = noticeSwitch.on?@"1":@"0";
    LzwLocalNoticeModelDBTool *noticeDBTool = [LzwLocalNoticeModelDBTool shareInstance];
    NSString *nId = [NSString stringWithFormat:@"%ld",(noticeSwitch.tag - 1000)];
    [noticeDBTool updateModelWithkey:@"nIsOpen" value:isOpen nId:nId];
}

#pragma mark -- 设置本地推送时间
- (void)setUpLocalNotification:(NSString *)dateStr noticeID:(NSString *)noticeID repetition:(NSString *)repetitionWay {
    
    NSLog(@"ddddd = %@", dateStr);
    
    
    //格式化时间, 自动补充八小时
    NSDate                    *dato = [NSDate date];
    NSDateFormatter      *formattero = [[NSDateFormatter alloc] init];
    [formattero setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString            *timeStringo = [formattero stringFromDate:dato];
    
    NSString *noticetime = [timeStringo.xh_format_yyyy_MM_dd stringByAppendingString:[NSString stringWithFormat:@" %@", dateStr]];
    
    //    self.lblShow.text = timeStringo;
    //    一路上有你  14:19:01
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: currentDate];
    NSDate *localeDate = [currentDate  dateByAddingTimeInterval: interval];
    //时间转成时间戳
    NSString *timePp = [NSString stringWithFormat:@"%ld", (long)[currentDate timeIntervalSince1970]];
    NSLog(@"ddddd = %@", timePp);
    
    //没加八小时  这个对
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[localeDate timeIntervalSince1970]];
    NSLog(@"ddddd = %@", timeSp);
    
    
    
    //将字符串转化成时间
    NSDate *newdate = [self stringToDate:noticetime withDateFormat:@"yyyy-MM-dd HH:mm"];
    NSLog(@"wwwww = %@", newdate);
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    if (localNotification == nil) {
        return;
    }
    //设置UILocalNotification
    [localNotification setTimeZone:[NSTimeZone defaultTimeZone]];//设置时区
    localNotification.fireDate = newdate;//设置触发时间
    //设置重复间隔
    if ([repetitionWay isEqualToString:@"不重复"]) {
        localNotification.repeatInterval = 0;
    }
    else if ([repetitionWay isEqualToString:@"每天"])
    {
        localNotification.repeatInterval = NSCalendarUnitDay;
    }
    else if ([repetitionWay isEqualToString:@"每周"])
    {
        localNotification.repeatInterval = NSCalendarUnitWeekday;
    }
    else
    {
        localNotification.repeatInterval = NSCalendarUnitMonth;
    }
    
    localNotification.alertBody = @"用药提醒";
    localNotification.alertTitle = @"网要送";
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    
    //当然你也可以调取当前的气泡,并且设置.也可以设置一个userInfo进行传递信息
    //     [localNotification setApplicationIconBadgeNumber:66];
    //     localNotification.applicationIconBadgeNumber += 1;
    localNotification.userInfo = @{@"NOTICE" : noticeID};
    
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

//字符串转日期格式
- (NSDate *)stringToDate:(NSString *)dateString withDateFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    
    NSDate *date = [dateFormatter dateFromString:dateString];
    //    return [self worldTimeToChinaTime:date];
    return date;
}
//将世界时间转化为中国区时间
//- (NSDate *)worldTimeToChinaTime:(NSDate *)date
//{
////    NSTimeZone *timeZone = [NSTimeZone defaultTimeZone];
////    NSInteger interval = [timeZone secondsFromGMTForDate:date];
//    NSDate *localeDate = [date  dateByAddingTimeInterval:interval];
//    return localeDate;
//}

#pragma mark -- 删除通知
-(void)cancelLocalNotificationWithKey:(NSString *)key {
    // 获取所有本地通知数组
    NSArray *localNotifications = [UIApplication sharedApplication].scheduledLocalNotifications;
    NSLog(@"sssss = %ld", [localNotifications count]);
    for (UILocalNotification *notification in localNotifications) {
        NSDictionary *userInfo = notification.userInfo;
        
        if (userInfo) {
            // 根据设置通知参数时指定的key来获取通知参数
            NSString *info = userInfo[@"NOTICE"];
            
            // 如果找到需要取消的通知，则取消
            if (info != nil) {
                if ([info isEqualToString:key]) {
                    [[UIApplication sharedApplication] cancelLocalNotification:notification];
                    NSLog(@"取消成功!!!");
                }
                break;
            }
        }
    }
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
