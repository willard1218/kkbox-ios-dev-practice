//
//  ViewController.m
//  SneakGame
//
//  Created by willard on 2016/8/16.
//  Copyright © 2016年 willard. All rights reserved.
//

#import "WLSnakeView.h"
#import "WLViewController.h"

@interface WLViewController ()

@end

@implementation WLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    int width = 10;
    WLSnakeView *demoView = [[WLSnakeView alloc] initWithFrame:CGRectMake(60, 100, width, width)];
    [self.view addSubview:demoView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
