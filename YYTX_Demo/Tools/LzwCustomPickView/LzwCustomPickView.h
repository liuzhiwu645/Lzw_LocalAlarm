//
//  LzwCustomPickView.h
//  YYTX_Demo
//
//  Created by pc37 on 2017/9/26.
//  Copyright © 2017年 Zhiwu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^lzwLeftPickerDidSelectBlock)(NSInteger left);
typedef void(^lzwRighPickerDidSelectBlock)(NSInteger righ);


@interface LzwCustomPickView : UIPickerView

+ (void)show:(NSArray<NSArray<NSString *> *> *)datas didLeftSelectBlock:(lzwLeftPickerDidSelectBlock)didLeftSelectBlock didRighSelectBlock:(lzwRighPickerDidSelectBlock)didRifhSelectBlock;

@end
