//
//  LzwLocalNoticeModelDBTool.m
//  YYTX_Demo
//
//  Created by pc37 on 2017/9/26.
//  Copyright © 2017年 Zhiwu. All rights reserved.
//

#import "LzwLocalNoticeModelDBTool.h"

@interface LzwLocalNoticeModelDBTool ()

@property (strong , nonatomic) DataBaseTool *dbTool;

@end

static id _instance;
@implementation LzwLocalNoticeModelDBTool

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    
    return _instance;
}
- (instancetype)init
{
    if (self = [super init]) {
        NSString *dbName = @"fundingSys.db";
        NSString *directory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString *dbPath = [directory stringByAppendingPathComponent:dbName];
        NSLog(@"%@",dbPath);
        _dbTool = [[DataBaseTool alloc] initWithPath:dbPath];
    }
    return self;
}

- (void)createTable
{
    NSString *sql = @"CREATE TABLE 'LocalNoticeModel' ('Id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE, 'nTime' TEXT, 'nWeek' TEXT, 'nIsOpen' TEXT, 'nName' TEXT, 'nRemark' TEXT, 'nDosage' TEXT);";
    if (![_dbTool tableExists:@"LocalNoticeModel"]) {
        [_dbTool executeUpdate:sql param:nil];
    }
    else
    {
        NSLog(@"表已经存在");
    }
    
    
}

- (void)insertModel:(LzwRootModel *)noticeModel vc:(UIViewController *)viewController
{
    NSString *sql = @"insert into LocalNoticeModel( nTime, nWeek, nIsOpen, nName, nRemark, nDosage) values(?,?,?,?,?,?)";
    NSArray *param = @[noticeModel.noticeTime,noticeModel.noticeWeek,noticeModel.isOpen, noticeModel.noticeName, noticeModel.noticeRemark, noticeModel.noticeeveryDosage];
    if([_dbTool executeUpdate:sql param:param]){
        NSLog(@"插入数据成功");
        [viewController.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        NSLog(@"插入数据失败");
    }
}

-(void)deleteModelWithkey:(NSString *)key value:(NSString *)value{
    NSString *sql = [NSString stringWithFormat:@"delete from LocalNoticeModel where %@ = %@",key,value];
    if ([_dbTool executeUpdate:sql param:nil]) {
        NSLog(@"删除成功");
    }
    else
    {
        NSLog(@"删除失败");
    }
}

-(void)updateModelWithkey:(NSString *)key value:(NSString *)value nId:(NSString *)nId{
    NSString *sql = [NSString stringWithFormat:@"update LocalNoticeModel set %@ = '%@' where Id = %@",key,value,nId];
    if ([_dbTool executeUpdate:sql param:nil]) {
        NSLog(@"修改成功");
    }
    else
    {
        NSLog(@"修改失败");
    }
}

- (NSArray *)selectAllModel
{
    return [_dbTool executeQuery:@"select * from LocalNoticeModel" withArgumentsInArray:nil modelClass:[LzwRootModel class]];
}

- (LzwRootModel *)selectLocalNoticeModelWithNoticeId:(NSString *)noticeId
{
    NSString *sql = [NSString stringWithFormat:@"select * from LocalNoticeModel where Id = %@",noticeId];
    NSArray *arr = [_dbTool executeQuery:sql withArgumentsInArray:nil modelClass:[LzwRootModel class]];
    LzwRootModel *model = [[LzwRootModel alloc]init];
    NSDictionary *dict = arr[0];
    model.noticeId = [dict valueForKey:@"noticeId"];
    model.noticeTime = [dict valueForKey:@"noticeTime"];
    model.noticeWeek = [dict valueForKey:@"noticeWeek"];
    model.isOpen = [dict valueForKey:@"isOpen"];
    model.noticeName = [dict valueForKey:@"noticeName"];
    model.noticeRemark = [dict valueForKey:@"noticeRemark"];
    model.noticeeveryDosage = [dict valueForKey:@"noticeeveryDosage"];
    return model;
}

- (void)dropTable{
    if([_dbTool dropTable:@"LocalNoticeModel"])
    {
        NSLog(@"删除成功");
    }
    else
    {
        NSLog(@"删除失败");
    }
}

@end
