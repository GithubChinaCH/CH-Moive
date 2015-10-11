//
//  BaseTabBarViewController.m
//  项目一
//
//  Created by mac on 15/8/3.
//  Copyright (c) 2015年 chenhao. All rights reserved.
//

#import "BaseTabBarViewController.h"
#import "TabButton.h"

@interface BaseTabBarViewController ()
{
    UIImageView *_newTabBarView;
    //UIImageView *_selectImage;
}

@end

@implementation BaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.backgroundImage = [UIImage imageNamed:@"tab_bg_all"];


    [self _removeItem];
    [self _creatItem];
  
}




//移除系统的item
- (void)_removeItem
{
    self.tabBar.hidden = YES;
    /*
    Class buttonItemCalss = NSClassFromString(@"UITabBarButton");
    //便利标签栏上的子视图 如果是UITabBarButton则移除
    for (id subView in self.tabBar.subviews) {
        if ([subView isMemberOfClass:buttonItemCalss]) {
            [subView removeFromSuperview];

        }
    }
     */
    
}


//创建自定义TaBar
- (void)_creatItem
{
    _newTabBarView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tab_bg_all"]];
    _newTabBarView.frame = CGRectMake(0, kScreenHeight-49, kScreenWeight, 49);
    [self.view addSubview:_newTabBarView];
    _newTabBarView.userInteractionEnabled = YES;
    
    
    
    //创建按钮
    //1 计算 按钮的长 宽
    CGFloat buttonWidth = kScreenWeight / self.viewControllers.count;
    CGFloat buttonHeight = 49;
    NSArray *imageNames = @[@"movie_cinema@2x",
                     @"msg_new@2x",
                     @"start_top250@2x",
                     @"icon_cinema@2x",
                     @"more_select_setting@2x"];
    
    NSArray *title = @[@"电影",
                       @"新闻",
                       @"Top250",
                       @"影院",
                       @"更多"
                       ];
    
    
    for (int i = 0; i < self.viewControllers.count; i++) {
        TabButton *button = [[TabButton alloc] initWithFrame:CGRectMake(i * buttonWidth, 0, buttonWidth, buttonHeight) imageName:imageNames[i] title:title[i]];
        [_newTabBarView addSubview:button];
        button.tag = 100 +i;
        [button addTarget:self action:@selector(buttonAction:)  forControlEvents:UIControlEventTouchUpInside];
    }
    //创建选中视图
    _selectImage = [[UIImageView alloc] init];
    _selectImage.image = [UIImage imageNamed:@"selectTabbar_bg_all1"];
    _selectImage.frame = CGRectMake(5, 0, buttonWidth-10, buttonHeight);
    //将这个选中视图 插到按钮下面
    [_newTabBarView insertSubview:_selectImage atIndex:0];
    
}


//设置自定义的标签栏是否隐藏
- (void)setTabBarHidden:(BOOL)hidden animation:(BOOL)animation
{
    if (animation) {
        //隐藏动画
        [UIView animateWithDuration:0.3 animations:^{
            if (hidden) {
                _newTabBarView.top = kScreenHeight;
            }
            else
            {
                _newTabBarView.bottom = kScreenHeight;
            }
        }];
    }
    //没有隐藏动画
    else
    {
        if (hidden) {
            _newTabBarView.top = kScreenHeight;
        }
        else
        {
            _newTabBarView.bottom = kScreenHeight;
        }
    }
}


- (void)buttonAction:(UIButton *)sender
{
    self.selectedIndex = sender.tag - 100;
    [UIView animateWithDuration:0.3 animations:^{
        _selectImage.center = sender.center;
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
