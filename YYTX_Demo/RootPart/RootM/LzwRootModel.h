//
//  LzwRootModel.h
//  YYTX_Demo
//
//  Created by pc37 on 2017/9/26.
//  Copyright © 2017年 Zhiwu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ColumnPropertyMappingDelegate.h"

@interface LzwRootModel : NSObject<ColumnPropertyMappingDelegate>

/*
@property (nonatomic, strong) NSString *drugName;//药品名
@property (nonatomic, strong) NSString *drugTime;//服药时间
@property (nonatomic, strong) NSString *everyDosage;//每次用量
@property (nonatomic, strong) NSString *repetitionTime;//重复时间
@property (nonatomic, strong) NSString *userRemark;//用户备注
@property (nonatomic, strong) NSString *noticeID; //闹钟ID;
@property (nonatomic, strong) NSString *isOpen; //是否打开开关;
*/

@property (strong , nonatomic) NSString *noticeId;
@property (strong , nonatomic) NSString *noticeTime;
@property (strong , nonatomic) NSString *noticeWeek;
@property (strong , nonatomic) NSString *isOpen;
@property (strong , nonatomic) NSString *noticeName;
@property (strong , nonatomic) NSString *noticeRemark;
@property (strong , nonatomic) NSString *noticeeveryDosage;


-(instancetype)initWithDictionary:(NSDictionary *)dict;


@end
