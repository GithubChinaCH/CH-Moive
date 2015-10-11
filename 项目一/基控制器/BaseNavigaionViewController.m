//
//  BaseNavigaionViewController.m
//  项目一
//
//  Created by mac on 15/8/3.
//  Copyright (c) 2015年 chenhao. All rights reserved.
//

#import "BaseNavigaionViewController.h"

@interface BaseNavigaionViewController ()

@end

@implementation BaseNavigaionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg_all-64"] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.translucent = NO;
    //NSLog(@"%f",self.view.frame.size.height);
    
    //self.navigationBar.barTintColor = [UIColor redColor];
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return 1;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
