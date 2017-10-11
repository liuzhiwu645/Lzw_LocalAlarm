//
//  UIButton+EnlargeEdge.h
//  WYEAPClient
//
//  Created by pc37 on 17/7/25.
//  Copyright © 2017年 pc47. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (EnlargeEdge)

- (void)setEnlargeEdge:(CGFloat) size;
- (void)setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left;

@end
