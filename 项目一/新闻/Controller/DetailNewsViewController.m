//
//  DetailNewsViewController.m
//  项目一
//
//  Created by mac on 15/8/11.
//  Copyright (c) 2015年 chenhao. All rights reserved.
//

//https://www.baidu.com

#import "DetailNewsViewController.h"
#import "BaseTabBarViewController.h"



@interface DetailNewsViewController ()
{
    UIWebView *_web;   //是用来显示网页的
}


@end

@implementation DetailNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"网页";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    _web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWeight, kScreenHeight - 15)];
    [self.view addSubview:_web];
    
    
    /*
     
    //通过网址来加载webView
    //将 https://www.baidu.com 网址显示到webView上
    //1 创建一个网络请求
    NSURLRequest *rquest = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
    //2 使用这个网络请求 来加载web页面
    [_web loadRequest:rquest];
    
    */
    
    
    //通过HTML文件来加载webView
    //读取HTML文件
    /*
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"百度一下，你就知道" ofType:@"html"];
    //将文件内容转化为字符串
    NSString *str = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    //使用HTMLstring 来加载页面
    [_web loadHTMLString:str baseURL:nil];
    //网页 内容自适应
    _web.scalesPageToFit = YES;
    
    */
    
    //读取 news.html
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"news" ofType:@"html"];
    //将文件内容转化为字符串
    NSString *str = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    

    //读取news_detail.json
    filePath = [[NSBundle mainBundle] pathForResource:@"news_detail" ofType:@"json"];
    
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    //json解析
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    
    //读取需要的内容
    NSString *title = dic[@"title"];
    NSString *content = dic[@"content"];
    NSString *soucrce = dic[@"source"];
    NSString *time = dic[@"time"];
    //NSString *content = @"adhasdajkfajkflahjkvabljkcnaklcnaklsnklabacv";
    
    
    //NSLog(@"%@",str);
   // NSLog(@"title           %@,content         %@,source           %@,time        %@",title,content,soucrce,time);
    
    
    //将这些内容拼接成一个完整的HTMLstring
    NSString *htmlStr = [NSString stringWithFormat:str,title,content,soucrce,time];
    //将HTMLstring 加载到webView上
    [_web loadHTMLString:htmlStr baseURL:nil];
    
    _web.scalesPageToFit = YES;

    
    
    
}

//隐藏 显示状态栏
- (void)viewWillAppear:(BOOL)animated
{
    BaseTabBarViewController *tab = (BaseTabBarViewController *)self.tabBarController;
    [tab setTabBarHidden:YES animation:NO];
}
- (void)viewWillDisappear:(BOOL)animated
{
    BaseTabBarViewController *tab = (BaseTabBarViewController *)self.tabBarController;
    [tab setTabBarHidden:NO animation:NO];
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
