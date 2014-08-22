//
//  ProgressView.m
//  SomeThingTest
//
//  Created by Zhuang Xiaowei on 14-8-18.
//  Copyright (c) 2014年 Eli. All rights reserved.
//

#import "ProgressView.h"
#import <QuartzCore/QuartzCore.h>

@interface ProgressView()

@property (nonatomic, weak) CAShapeLayer *progressLayer;
@property (nonatomic, weak) CAShapeLayer *trackLayer;
@property (nonatomic, weak) CAShapeLayer *clickLayer;
@property (nonatomic, weak) UILabel *progressLabel;
@property (nonatomic) CGPoint arcCenter;

@end

@implementation ProgressView

- (id)initWithFrame:(CGRect)frame
{
    if (frame.size.width != frame.size.height) frame.size.height = frame.size.width;
    self = [super initWithFrame:frame];
    if (self)
    {
        _arcCenter = (CGPoint){CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) / 2};
        
        self.userInteractionEnabled = YES;
        CAShapeLayer *trackLayer = [[CAShapeLayer alloc] init];
        [self.layer addSublayer:trackLayer];
        self.trackLayer = trackLayer;
        self.trackLayer.fillColor = UIColor.clearColor.CGColor;
        
        CAShapeLayer *progressLayer = [[CAShapeLayer alloc] init];
        [self.layer addSublayer:progressLayer];
        self.progressLayer = progressLayer;
        self.progressLayer.fillColor = UIColor.clearColor.CGColor;
        
        UILabel *label = [[UILabel alloc] initWithFrame:(CGRect){0, 0, 50, 30}];
        label.text = @"00";
        label.center = self.arcCenter;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:24.0f];
        [self addSubview:label];
        self.progressLabel = label;
        
        _progressColor = UIColor.orangeColor.CGColor;
        _trackColor = UIColor.grayColor.CGColor;
        
        self.progressLayer.strokeColor = _progressColor;
        self.trackLayer.strokeColor = _trackColor;
        
        _progress = 0.75;
        
        
        self.progressWith = 5;
        
        
        self.layer.borderColor = UIColor.blackColor.CGColor;
        self.layer.borderWidth = 1.0f;
    }
    return self;
}

- (void)setTrack
{
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.arcCenter
                                                        radius:(CGRectGetWidth(self.bounds) - self.progressWith) / 2
                                                    startAngle:0
                                                      endAngle:2 * M_PI
                                                     clockwise:NO];
    self.trackLayer.path = path.CGPath;
}

- (void)setProgressBar
{
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.arcCenter
                                                        radius:(CGRectGetWidth(self.bounds) - self.progressWith) / 2
                                                    startAngle:-M_PI_2
                                                      endAngle:2 * M_PI * self.progress - M_PI_2
                                                     clockwise:YES];
    self.progressLayer.path = path.CGPath;
}

- (void)setLabelNumber
{
    NSString *result = [NSString stringWithFormat:@"%d", (int)(self.progress * 100)];
    self.progressLabel.text = result;
}

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    
    [self setTrack];
    [self setProgressBar];
    [self setLabelNumber];
}

- (void)setTrackColor:(CGColorRef)trackColor
{
    _trackColor = trackColor;
    self.trackLayer.strokeColor = _trackColor;
    
    [self setTrack];
}

- (void)setProgressColor:(CGColorRef)progressColor
{
    _progressColor = progressColor;
    self.progressLayer.strokeColor = _progressColor;
    
    [self setProgressBar];
}

- (void)setProgressWith:(CGFloat)progressWith
{
    _progressWith = progressWith;
    self.trackLayer.lineWidth = _progressWith;
    self.progressLayer.lineWidth = _progressWith;
    
    [self setTrack];
    [self setProgressBar];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
    
    CGPoint touchPoint = [touch locationInView:self];
    CGFloat distX = abs(touchPoint.x - self.arcCenter.x + self.progressWith);
    CGFloat distY = abs(touchPoint.y - self.arcCenter.y + self.progressWith);
    CGFloat distince = distX * distX + distY * distY;// the squr of two point's distince
    CGFloat r = CGRectGetWidth(self.bounds) / 2 - self.progressWith;
    CGFloat result = r * r - distince;
    
    if (result < 0)//out of circle
    {
        return;
    }
    
    CAShapeLayer *clickLayer = [[CAShapeLayer alloc] init];
    clickLayer.frame = self.bounds;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.arcCenter
                                                        radius:CGRectGetWidth(self.bounds)/2 - self.progressWith
                                                    startAngle:0
                                                      endAngle:2 * M_PI
                                                     clockwise:YES];
    clickLayer.path = path.CGPath;
    clickLayer.fillColor = UIColor.orangeColor.CGColor;
    clickLayer.strokeColor = UIColor.clearColor.CGColor;
    clickLayer.lineWidth = 0;
    clickLayer.opacity = 0.3f;
    [self.layer addSublayer:clickLayer];
    self.clickLayer = clickLayer;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.clickLayer)
    {
        [self.clickLayer removeFromSuperlayer];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
