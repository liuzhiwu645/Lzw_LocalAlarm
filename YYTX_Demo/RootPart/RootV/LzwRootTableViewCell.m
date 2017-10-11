//
//  LzwRootTableViewCell.m
//  YYTX_Demo
//
//  Created by pc37 on 2017/9/26.
//  Copyright © 2017年 Zhiwu. All rights reserved.
//

#import "LzwRootTableViewCell.h"

@interface LzwRootTableViewCell ()

@property (nonatomic, strong) UILabel *labelName;
@property (nonatomic, strong) UILabel *labelTime;
@property (nonatomic, strong) UISwitch *remindSwitch;
@property (nonatomic, strong) UILabel *labelReptiTime;

@end

@implementation LzwRootTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatLzwRootTableViewCellSubviews];
    }
    return self;
}
//创建子视图
- (void)creatLzwRootTableViewCellSubviews
{
    self.labelName = [[UILabel alloc]init];
    _labelName.textColor = [UIColor lightGrayColor];
    _labelName.textAlignment = NSTextAlignmentLeft;
    _labelName.text = @"药品名称";
    _labelName.font = [UIFont systemFontOfSize:13.0];
    [self.contentView addSubview:_labelName];
    
    self.labelTime = [[UILabel alloc]init];
    _labelTime.textColor = [UIColor lightGrayColor];
    _labelTime.text = @"提醒时间";
    _labelTime.textAlignment = NSTextAlignmentLeft;
    _labelTime.font = [UIFont systemFontOfSize:13.0];
    [self.contentView addSubview:_labelTime];
    
    self.labelReptiTime = [[UILabel alloc]init];
    _labelReptiTime.textColor = [UIColor lightGrayColor];
    _labelReptiTime.textAlignment = NSTextAlignmentLeft;
    _labelReptiTime.font = [UIFont systemFontOfSize:13.0];
    _labelReptiTime.textColor = [UIColor redColor];
    [self.contentView addSubview:_labelReptiTime];
    
    self.remindSwitch = [[UISwitch alloc]init];
    [self.contentView addSubview:_remindSwitch];
    
    [_labelName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@15);
        make.width.mas_greaterThanOrEqualTo(150);
        make.height.equalTo(@20);
    }];
    
    [_labelTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leftMargin.equalTo(_labelName);
        make.top.equalTo(_labelName.mas_bottom).offset(15);
        make.width.mas_greaterThanOrEqualTo(80);
        make.height.equalTo(@20);
    }];
    
    [_labelReptiTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_labelTime);
        make.left.equalTo(_labelTime.mas_right).offset(5);
        make.height.equalTo(_labelTime);
        make.width.mas_greaterThanOrEqualTo(180);
    }];
    
    [_remindSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self.mas_right).offset(-50);
        make.width.height.equalTo(@20);
    }];
    
    [_remindSwitch addTarget:self action:@selector(usetSwitchOn_offNotification:) forControlEvents:UIControlEventValueChanged];
}
- (void)usetSwitchOn_offNotification:(UISwitch *)mySwitch
{
    if ([self.rootDelegate respondsToSelector:@selector(userActionSwitchOn_Off:)]) {
        mySwitch.tag = [_modelRoot.noticeId intValue] + 1000;
        
        [self.rootDelegate userActionSwitchOn_Off:mySwitch];
    }
}
-(void)setModelRoot:(LzwRootModel *)modelRoot
{
    _modelRoot = modelRoot;
    
    _labelName.text = [NSString stringWithFormat:@"%@", _modelRoot.noticeName];
    _labelTime.text = [NSString stringWithFormat:@"%@", _modelRoot.noticeTime];
    _remindSwitch.on = [_modelRoot.isOpen isEqualToString:@"1"]?YES:NO;
    _labelReptiTime.text = [NSString stringWithFormat:@"重复时间:%@", _modelRoot.noticeWeek];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
