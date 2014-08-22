//
//  ViewController.m
//  ProgressDemo
//
//  Created by Zhuang Xiaowei on 14-8-22.
//  Copyright (c) 2014年 Eli. All rights reserved.
//

#import "ViewController.h"
#import "ProgressView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    ProgressView *progress = [[ProgressView alloc] initWithFrame:(CGRect){50, 50, 100, 100}];
    [self.view addSubview:progress];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
