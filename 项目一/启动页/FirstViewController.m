//
//  FirstViewController.m
//  项目一
//
//  Created by mac on 15/8/12.
//  Copyright (c) 2015年 chenhao. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()<UIScrollViewDelegate>

{
    UIScrollView *_scroll;
    UIImageView *_pageView;
    UIButton *_button;
}
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //隐藏状态栏
    UIApplication *app = [UIApplication sharedApplication];
    [app setStatusBarHidden:YES];
    
    [self _creatView];

}

//创建 滑动视图
- (void)_creatView
{
    _scroll = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scroll.delegate = self;
    _scroll.pagingEnabled = YES;
    _scroll.bounces = NO;
    _scroll.contentSize = CGSizeMake(5*kScreenWeight, 0);
    [self.view addSubview:_scroll];
    
    for (int i = 0; i<5; i++) {
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(i * kScreenWeight, 0, kScreenWeight, kScreenHeight)];
        
        NSString *str = [NSString stringWithFormat:@"guide%i",i+1];
        UIImage *image = [UIImage imageNamed:str];
        imageV.image = image;
        [_scroll addSubview:imageV];
    }
    
    //创建页码显示器
    _pageView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWeight-173)/2, kScreenHeight - 50, 173, 26)];
    _pageView.image = [UIImage imageNamed:@"guideProgress1"];
    [self.view addSubview:_pageView];
    
    //进入按钮
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    //[_button setTitle:@"进入电影世界" forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _button.frame = CGRectMake((kScreenWeight - 100)/2, kScreenHeight - 160, 100, 100);
    //_button.backgroundColor = [UIColor redColor];
    [_button setBackgroundImage:[UIImage imageNamed:@"QQ20150812-1"] forState:UIWindowLevelNormal
     ];    [_button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];
    _button.hidden = YES;
}

//滑动视图滚动的方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat x = scrollView.contentOffset.x;
    if (x>0 && x<kScreenWeight*5) {
        NSInteger num = (x + kScreenWeight/2)/kScreenWeight;
        NSArray *ary = @[@"guideProgress1",
                         @"guideProgress2",
                         @"guideProgress3",
                         @"guideProgress4",
                         @"guideProgress5"];
        UIImage *image = [UIImage imageNamed:ary[num]];
        _pageView.image = image;
        
        if (num ==4 ) {
            _button.hidden = NO;
        }
        else
        {
            _button.hidden = YES;
        }
    }
    
    
}


//按钮事件 点击按钮进入到第一个视图控制器
- (void)buttonAction:(UIButton *)sender
{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UIViewController *vc = [story instantiateInitialViewController];
    //
    self.view.window.rootViewController = vc;
    
    //显示动画
    vc.view.transform = CGAffineTransformMakeScale(0.5, 0.5);
    [UIView animateWithDuration:0.3 animations:^{
        vc.view.transform = CGAffineTransformIdentity;
    }];
    
    NSUserDefaults *use = [NSUserDefaults standardUserDefaults];
    [use setBool:YES forKey:@"first"];
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
