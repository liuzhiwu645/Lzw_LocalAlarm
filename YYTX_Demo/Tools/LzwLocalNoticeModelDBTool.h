//
//  LzwLocalNoticeModelDBTool.h
//  YYTX_Demo
//
//  Created by pc37 on 2017/9/26.
//  Copyright © 2017年 Zhiwu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LzwLocalNoticeModelDBTool : NSObject
/**
 *  初始化单例类
 *
 *  @return 单例
 */
+ (instancetype)shareInstance;
/**
 *  创建表
 */
- (void)createTable;
/**
 *  新增
 */
- (void)insertModel:(LzwRootModel *)localNoticeModel vc:(UIViewController *)viewController;
/**
 *  查询
 *
 *  @return 结果集
 */
- (NSArray *)selectAllModel;
/**
 *  根据信息删除相应数据
 *
 *  @param key   字段名
 *  @param value 字段值
 */
-(void)deleteModelWithkey:(NSString *)key value:(NSString *)value;
/**
 *  根据Id更新字段
 *
 *  @param key   字段名
 *  @param value 字段值
 *  @param nId   Id
 */
-(void)updateModelWithkey:(NSString *)key value:(NSString *)value nId:(NSString *)nId;
/**
 *  根据Id查询数据
 *
 *  @param noticeId noticeId
 *
 *  @return LocalNoticeModel
 */
- (LzwRootModel *)selectLocalNoticeModelWithNoticeId:(NSString *)noticeId;
/**
 *  删除表
 */
- (void)dropTable;
@end
