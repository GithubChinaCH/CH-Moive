//
//  BaseViewController.m
//  项目一
//
//  Created by mac on 15/8/3.
//  Copyright (c) 2015年 chenhao. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseTabBarViewController.h"


@interface BaseViewController ()
{
    UILabel *_label;
    BaseTabBarViewController *_tab;
}

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.font = [UIFont boldSystemFontOfSize:30];
    _label.textColor = [UIColor whiteColor];
    
    self.navigationItem.titleView  = _label;
    _tab = (BaseTabBarViewController *)self.navigationController.tabBarController;
    
    
    UIApplication *app = [UIApplication sharedApplication];
    [app setStatusBarHidden:NO];
    [app setStatusBarStyle:UIStatusBarStyleLightContent];
    //添加手势
    //[self addSwip];
}

//重写 set 方法
- (void)setTitle:(NSString *)title
{
    //_title = title;
    [super setTitle:title];
    _label.text = title;
    
}


//给视图添加手势
- (void)addSwip
{
    UISwipeGestureRecognizer *rightSwip = [[UISwipeGestureRecognizer alloc] init];
    [rightSwip addTarget:self action:@selector(rightSwipAction)];
    rightSwip.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwip];
    UISwipeGestureRecognizer *leftSwip = [[UISwipeGestureRecognizer alloc] init];
    leftSwip.direction = UISwipeGestureRecognizerDirectionLeft;
    [leftSwip addTarget:self action:@selector(leftSwip)];
    [self.view addGestureRecognizer:leftSwip];
    
}
//右滑手势
- (void)rightSwipAction
{
    NSInteger num = self.tabBarController.selectedIndex;
    if (num != 0) {

        [UIView animateWithDuration:0.3 animations:^{
            self.tabBarController.selectedIndex--;
            _tab.selectImage.left -= kScreenWeight / 5;
        }];
    }
    
}
//左滑手势
- (void)leftSwip
{
    NSInteger num = self.tabBarController.viewControllers.count;
    if (self.tabBarController.selectedIndex != num) {
        self.tabBarController.selectedIndex++;
        [UIView animateWithDuration:0.3 animations:^{
            _tab.selectImage.right += kScreenWeight / 5;

        }];
    }
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
