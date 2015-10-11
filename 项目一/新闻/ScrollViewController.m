//
//  ScrollViewController.m
//  项目一
//
//  Created by mac on 15/8/6.
//  Copyright (c) 2015年 chenhao. All rights reserved.
//

#import "ScrollViewController.h"
#import "BaseTabBarViewController.h"
#import "BigImageCollectionViewCell.h"

@interface ScrollViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    UICollectionView *_collection;
    
    BOOL _isHidden;
    
}


@end

@implementation ScrollViewController
//移除通知
- (void)dealloc
{
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"图片浏览";
    
    UIApplication *app = [UIApplication sharedApplication];
    [app setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    
    self.navigationController.navigationBar.translucent = YES;
    [self _creatView];
    
    [self _creatButton];

    
    
    

    //接收通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hiddenNavi) name:@"disAppearNavi" object:nil];
}

//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    return 1;
//}


//通知事件
- (void)hiddenNavi
{
    if (self.navigationController.navigationBarHidden ==NO)
    {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
    else
    {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
    
}

//点击到哪张就到那张图片
- (void)viewWillLayoutSubviews
{
    _backNum = self.num;
    
    NSIndexPath *path = [NSIndexPath indexPathForRow:self.num inSection:0];
    
    [_collection scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
}

//滑动代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"backNum" object:self];
    
    if (scrollView.contentOffset.x >=0 && scrollView.contentOffset.x < _message.count*385) {
        _num = scrollView.contentOffset.x / 385 ;
//        NSLog(@"%li",_num);
    }
    else return;
    
}






#pragma mark - 创建视图
- (void)_creatView
{
    //创建布局对象
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    //设置单元格大小
    flow.itemSize = CGSizeMake(kScreenWeight, kScreenHeight-34);
    //设置单元格的最小水平间隙
    flow.minimumInteritemSpacing = 10;
    flow.sectionInset = UIEdgeInsetsMake(0, 0, 0, 10);
    
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //创建collection
    _collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, -25, kScreenWeight + 10, kScreenHeight + 30) collectionViewLayout:flow];
    //隐藏滑
    _collection.showsHorizontalScrollIndicator = NO;
    //开启分页效果
    _collection.pagingEnabled = YES;
    _collection.dataSource = self;
    _collection.delegate = self;
   
    //_collection.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:_collection];
    
    
    // 注册单元格
    [_collection registerClass:[BigImageCollectionViewCell class] forCellWithReuseIdentifier:@"scrollCell"];
    
    
    
}


//创建导航栏 按钮
- (void)_creatButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 50, 40);
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:18];

    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.navigationItem.leftBarButtonItem = item;
}

//按钮事件
- (void)buttonAction:(UIButton *)sender
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}

#pragma mark - dataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _message.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BigImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"scrollCell" forIndexPath:indexPath];
    //cell.backgroundColor = [UIColor grayColor];
   /*
    //创建一个图片视图
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:cell.bounds];
    //加载网络图片
    [imageV sd_setImageWithURL:_message[indexPath.row]];
    
    //设置图片的拉升模式
    imageV.contentMode = UIViewContentModeScaleToFill;
    
    //将图片设置到cell上
    cell.backgroundView = imageV;
    */
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, 20, 100, 40)];
//    label.text = [NSString stringWithFormat:@"%li",indexPath.row];
//    label.backgroundColor = [UIColor whiteColor];
//    [cell addSubview:label];
    
    
    NSURL *url = _message[indexPath.row];
    
    [cell setImageURL:url];
    
    return cell;
}


//单元格滑出视图执行事件
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    BigImageCollectionViewCell *big = (BigImageCollectionViewCell *)cell;
    [big setBack];
    
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
