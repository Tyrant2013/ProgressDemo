//
//  ProgressView.h
//  SomeThingTest
//
//  Created by Zhuang Xiaowei on 14-8-18.
//  Copyright (c) 2014年 Eli. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ProgressView;

@protocol ProgressViewDelegate

- (void)progress:(ProgressView *)progressView didClickInSideWithProgress:(CGFloat)progress;

@end

@interface ProgressView : UIView

@property (nonatomic) CGFloat progress;//进度0-1
@property (nonatomic) CGFloat progressWith;//进度条宽度
@property (nonatomic) CGColorRef trackColor;//进度条背景颜色
@property (nonatomic) CGColorRef progressColor;//进度条颜色

@end
