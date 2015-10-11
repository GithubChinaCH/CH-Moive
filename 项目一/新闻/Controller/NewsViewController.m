//
//  NewsViewController.m
//  项目一
//
//  Created by mac on 15/8/3.
//  Copyright (c) 2015年 chenhao. All rights reserved.
//

#import "NewsViewController.h"
#import "Star.h"
#import "NewsData.h"
#import "NewsTableViewCell.h"
#import "ImageViewController.h"
#import "BaseTabBarViewController.h"
#import "BaseNavigaionViewController.h"
#import "PictureListViewController.h"
#import "DetailNewsViewController.h"

@interface NewsViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_newsData;
    NSMutableArray *_allData;
    NSArray *_ary;
    
    NSMutableArray *_dataAry;
    
    NSMutableArray *_urlAry;
    
    UITableView *_newsTab;
}


@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新闻";
   
    [self _dataUrlLoad];
    [self _loadData];
    [self _creatViews];
    
    
    
    
}


//读取url数据
- (void)_dataUrlLoad
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"image_list副本" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    _urlAry = [[NSMutableArray alloc] init];
    _dataAry = [[NSMutableArray alloc] init];
    NSError *error = [[NSError alloc] init];
    NSArray *ary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    
    _dataAry = [[NSMutableArray alloc] initWithArray:ary];
    
    for (NSDictionary *d in _dataAry) {
        NSURL *url = [NSURL URLWithString:d[@"image"]];
        [_urlAry addObject:url];
    }
    
    
}

//读取全部数据
- (void)_loadData
{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"news_list" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSError *error = [[NSError alloc] init];
    _ary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    _newsData = [NSMutableArray arrayWithArray:_ary];
    [_newsData removeObjectAtIndex:0];
    _allData = [[NSMutableArray alloc] init];
    for (NSDictionary *d in _newsData) {
        NewsData *newsData = [[NewsData alloc] initWithDic:d];
        [_allData addObject:newsData];
    }

}

//创建表视图
- (void)_creatViews
{
    
    
    _newsTab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.size.height-64) style:UITableViewStylePlain];
    _newsTab.dataSource = self;
    _newsTab.delegate = self;
    _newsTab.rowHeight = 80;
    
   
    
    
   /*
    //顶部视图
    newsTab.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 176)];
    newsTab.tableHeaderView.backgroundColor = [UIColor yellowColor];
    UIImageView *topImage = [[UIImageView alloc] initWithFrame:newsTab.tableHeaderView.frame];
    [newsTab.tableHeaderView addSubview:topImage];
    NSDictionary *dic = _ary[0];
    NSURL *url = [NSURL URLWithString:dic[@"image"]];

    [topImage sd_setImageWithURL:url];
    //文字
    */
    
    
    [self.view addSubview:_newsTab];
}

# pragma mark - delegate

//视图滑动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UITableViewCell *cell = (UITableViewCell *)[_newsTab viewWithTag:100];
    /*
    CGRect rect = cell.frame;
    rect = CGRectMake(0, scrollView.contentOffset.y, self.view.width, 176 - scrollView.contentOffset.y);
    cell.frame = rect;
    */
    
    UIImageView *image = (UIImageView *)[cell.contentView viewWithTag:101];
  
//    NSLog(@"%f",scrollView.contentOffset.y);
    if (scrollView.contentOffset.y > 0 ) {
        
        image.transform = CGAffineTransformIdentity;

        return;
    }
    else
    {
        //计算放大倍数
        CGFloat scale = (176 - scrollView.contentOffset.y)/176;
        //设置图片大小变换的transform
        CGAffineTransform transform = CGAffineTransformMakeScale(scale, scale);
        image.transform = transform;
        image.top = scrollView.contentOffset.y;
  
      /*
        UILabel *label = (UILabel *)[cell.contentView viewWithTag:102];
//        CGRect labelRect = label.frame;
//        labelRect.origin.y = 146 - scrollView.contentOffset.y;
//        label.frame = labelRect;
        label.bottom = cell.contentView.bottom;
*/
        

        
    }
    
    
    
}






# pragma mark - dataSouce
//单元格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 176;
    }
    else return 80;
        
}
//组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
//单元格数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else{
    return _allData.count;
    }
}
//创建单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"topCell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"topCell"];
            cell.tag = 100;

            UIImageView *image =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 176)];
            image.tag = 101;

            [image sd_setImageWithURL:[NSURL URLWithString:_ary[0][@"image"]]];
            [cell.contentView addSubview:image];

            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 176 - 30, self.view.width, 30)];
            label.tag = 102;
            label.text = _ary[0][@"title"];
            label.textColor = [UIColor whiteColor];
            label.font = [UIFont boldSystemFontOfSize:20];
            label.backgroundColor =[UIColor colorWithWhite:0 alpha:0.4];
            
            [cell.contentView addSubview:label];
            
        }
        return cell;
    }
    else
    {
        NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"newsCell"];
        if (cell == nil) {
            NSArray *ary = [[NSBundle mainBundle] loadNibNamed:@"NewsTableViewCell" owner:nil options:nil];
            
            cell = [ary lastObject];
            
            
            
        }
        cell.myNews = _allData[indexPath.row];
        return cell;
    }
}


//选中单元格
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsData *data = _allData[indexPath.row];

    NSNumber *num = data.type;
    if ([num integerValue] == 1) {
        
        //图片浏览器 1
        ImageViewController *image = [[ImageViewController alloc] init];
        BaseNavigaionViewController *navi = (BaseNavigaionViewController *)self.navigationController;
        
        [navi pushViewController:image animated:YES];
         
        
        //图片浏览器2
        /*
        PictureListViewController *list = [[PictureListViewController alloc] initWithAry:_urlAry];
        
         
        [self.navigationController pushViewController:list animated:YES];
        */

    }
    else if ([num integerValue] == 0)
    {
        DetailNewsViewController *detail = [[DetailNewsViewController alloc] init];
        
        
        BaseNavigaionViewController *navi = (BaseNavigaionViewController *)self.navigationController;
        [navi pushViewController:detail animated:YES];
    }
    else
    {
        return;
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
