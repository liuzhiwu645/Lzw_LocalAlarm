//
//  LzwRootTableViewCell.h
//  YYTX_Demo
//
//  Created by pc37 on 2017/9/26.
//  Copyright © 2017年 Zhiwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LzwRootModel.h"

@protocol LzwRootTableViewCellDelegate <NSObject>

- (void)userActionSwitchOn_Off:(UISwitch *)noticeSwitch;

@end

@interface LzwRootTableViewCell : UITableViewCell

@property (nonatomic, strong) LzwRootModel *modelRoot;

@property (nonatomic, assign) id<LzwRootTableViewCellDelegate>rootDelegate;


@end
