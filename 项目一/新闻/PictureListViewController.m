//
//  PictureListViewController.m
//  简易图片 浏览器
//
//  Created by mac on 15/8/9.
//  Copyright (c) 2015年 chenhao. All rights reserved.
//

#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

#import "PictureListViewController.h"
#import "UIImageView+WebCache.h"
#import "PictureViewController.h"
#import "BaseTabBarViewController.h"


@interface PictureListViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    UICollectionView *_collection;
    
    PictureViewController *_pic;
    
    NSMutableArray *_urlAry;
}

@end

@implementation PictureListViewController

//自定义创建方法
- (instancetype)initWithAry:(NSArray *)ary

{
    self = [super init];
    if (self)
    {
        _ImagesAry = ary;
        [self _creatListView];
    }
    return self;
}


//创建视图

- (void)_creatListView
{
    //布局对象
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.minimumInteritemSpacing = 10;
    flow.minimumLineSpacing = 10;
    flow.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    CGFloat width = (kScreenWidth - 10*5)/3;
    flow.itemSize = CGSizeMake(width, width*1.5);
    
    _collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) collectionViewLayout:flow];
    

    [self.view addSubview:_collection];
    _collection.dataSource = self;
    _collection.delegate = self;
    
    [_collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"listCell"];
    
}

#pragma makr - dataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _ImagesAry.count;
    //return 50;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"listCell" forIndexPath:indexPath];
    //cell.backgroundColor = [UIColor yellowColor];
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius = 30;
    cell.layer.borderWidth = 3;
    cell.layer.borderColor = [[UIColor orangeColor] CGColor];
    
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:cell.bounds];
    
    if ([_ImagesAry[indexPath.row] isKindOfClass:[NSURL class]])
    {
        [imageV sd_setImageWithURL:_ImagesAry[indexPath.row]];
    }
    else if ([_ImagesAry[indexPath.row] isKindOfClass:[NSString class]])
    {
        imageV.image = [UIImage imageNamed:_ImagesAry[indexPath.row]];
    }
    else if ([_ImagesAry[indexPath.row] isKindOfClass:[UIImage class]])
    {
        imageV.image = _ImagesAry[indexPath.row];
    }
    else
    {
        imageV.image = nil;
    }
    

    [cell.contentView addSubview:imageV];
    
    
    
    
    return cell;
}

#pragma mark - delegate
//点击图片 进入这张图片的模态视图
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    _pic = [[PictureViewController alloc] init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:_pic];
    _pic.num = indexPath.row;
    _pic.ImagesAry = _ImagesAry;
    
    
    [self presentViewController:navi animated:YES completion:nil];
}




//放回时列表浏览器图片位置放回到 最后观看到的图片的位置
- (void)backImage
{
    NSInteger num = _pic.backNum;
    NSIndexPath *path = [NSIndexPath indexPathForRow:num inSection:0];
    [_collection scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionBottom animated:NO];
}

#pragma mark - 隐藏标签栏

- (void)viewWillDisappear:(BOOL)animated
{
    BaseTabBarViewController *tab = (BaseTabBarViewController *)self.tabBarController;
    [tab setTabBarHidden:NO animation:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    BaseTabBarViewController *tab = (BaseTabBarViewController *)self.tabBarController;
    [tab setTabBarHidden:YES animation:NO];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
//    [self _loadData];
//    [self _creatListView];

    UILabel *_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.font = [UIFont boldSystemFontOfSize:30];
    _label.textColor = [UIColor whiteColor];
    self.navigationItem.titleView  = _label;
    _label.text = @"图片浏览";
    
    self.navigationController.navigationBar.tintColor = [UIColor redColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backImage) name:@"backNum" object:nil];
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
