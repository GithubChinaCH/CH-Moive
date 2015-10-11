//
//  ImageViewController.m
//  项目一
//
//  Created by mac on 15/8/5.
//  Copyright (c) 2015年 chenhao. All rights reserved.
//

#import "ImageViewController.h"
#import "BaseTabBarViewController.h"
#import "ScrollViewController.h"
#import "BaseTabBarViewController.h"
#import "BaseNavigaionViewController.h"

@interface ImageViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSMutableArray *_dataAry;
    
    NSMutableArray *_urlAry;
    
    ScrollViewController *_scroll;
    
    NSInteger _num;
    
}

@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新闻图片";
    //返回按钮 颜色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
    [self _creatViews];
    [self _dataLoad];

    
    //接收通知 
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationChange) name:@"backNum" object:nil];
    
    
}


//列表视图图片位置改变
- (void)locationChange
{
    UICollectionView *collect = (UICollectionView *)[self.view viewWithTag:100];
    NSIndexPath *path = [NSIndexPath indexPathForRow:_scroll.backNum inSection:0];
    
    [collect scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:NO];

}

//读取数据
- (void)_dataLoad
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

//创建视图
- (void)_creatViews
{

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.minimumLineSpacing = 10;
    flowLayout.itemSize = CGSizeMake(80, 80);
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 10, 5, 10);
    
    
    
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWeight, kScreenHeight -20) collectionViewLayout:flowLayout];
    collection.tag = 100;
    
    collection.dataSource = self;
    collection.delegate = self;
    
    collection.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main@2x"]];
    [collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    
    [self.view addSubview:collection];
}







#pragma mark - dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataAry.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor redColor];
    
    NSDictionary *dic = _dataAry[indexPath.row];
    NSURL *url = [NSURL URLWithString:dic[@"image"]];
    UIImageView *image = [[UIImageView alloc] initWithFrame:cell.bounds];
    [image sd_setImageWithURL:url];

    

    
    [cell addSubview:image];
    
    //-----------------视图的边框----------------
    //设置视图的圆角半径
    cell.layer.cornerRadius = 30;
    cell.layer.masksToBounds = YES;
    //设置边框颜色
    cell.layer.borderColor = [[UIColor yellowColor]CGColor];
    //设置边框的宽度
    cell.layer.borderWidth = 3;
    
    
    
    
    
    
    return cell;
}

#pragma mark - 单元格被选中
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    _scroll = [[ScrollViewController alloc] init];
//    [self.navigationController pushViewController:scroll animated:YES];

    BaseNavigaionViewController *navi = [[BaseNavigaionViewController alloc] initWithRootViewController:_scroll];
    //navi.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    
    [self presentViewController:navi animated:YES completion:nil];
    
    _scroll.message = _urlAry;

    _scroll.num = indexPath.row;
    
}




#pragma mark - 标签栏 隐藏消失
- (void)viewWillDisappear:(BOOL)animated
{
    BaseTabBarViewController *tab = (BaseTabBarViewController *)self.tabBarController;
    [tab setTabBarHidden:NO animation:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    BaseTabBarViewController *tab = (BaseTabBarViewController *)self.tabBarController;
    [tab setTabBarHidden:YES animation:NO];
    UIApplication *app = [UIApplication sharedApplication];
    [app setStatusBarHidden:NO];
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
