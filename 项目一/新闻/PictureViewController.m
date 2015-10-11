//
//  PictureViewController.m
//  简易图片 浏览器
//
//  Created by mac on 15/8/8.
//  Copyright (c) 2015年 chenhao. All rights reserved.
//

#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

#import "PictureViewController.h"
#import "PicCellCollectionViewCell.h"

@interface PictureViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collection;
    
    UILabel *_label;
}

@end

@implementation PictureViewController

//移除通知
- (void)dealloc
{
    //移除相应的通知
    //如果通知不移除 容易造成程序崩溃
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

//创建视图
- (void)_creatview
{
    //创建布局对象
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.minimumInteritemSpacing = 10;
    flow.itemSize = CGSizeMake(kScreenWidth, kScreenHeight - 20);
    flow.sectionInset = UIEdgeInsetsMake(0, 0, 0, 10);
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //创建 collection
    _collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth + 10, kScreenHeight) collectionViewLayout:flow];
    _collection.dataSource = self;
    _collection.delegate = self;
    _collection.pagingEnabled = YES;
    _collection.showsHorizontalScrollIndicator = NO;
    //_collection.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:_collection];
    
    //注册
    [_collection registerClass:[PicCellCollectionViewCell class] forCellWithReuseIdentifier:@"picCell"];
    
}

#pragma mark - dataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _ImagesAry.count;
//    return 20;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PicCellCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"picCell" forIndexPath:indexPath];
    //cell.top = 0;
    //cell.backgroundColor = [UIColor yellowColor];

    if ([_ImagesAry[indexPath.row] isKindOfClass:[NSURL class]])
    {
        
        [cell setImageWithURL:_ImagesAry[indexPath.row]];
    }
    else if ([_ImagesAry[indexPath.row] isKindOfClass:[NSString class]])
    {
        [cell setImageWithStr:_ImagesAry[indexPath.row]];
    }
    else if ([_ImagesAry[indexPath.row] isKindOfClass:[UIImage class]])
    {
        [cell setImageWithImage:_ImagesAry[indexPath.row]];
    }
    else
    {
        cell.backgroundColor = [UIColor redColor];
    }
    
    
    
    return cell;
}

#pragma mark - 点击哪张到哪张
- (void)viewWillLayoutSubviews
{
    _backNum = _num + 1;
    NSIndexPath *path = [NSIndexPath indexPathForRow:self.num inSection:0];
    
    [_collection scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
}
//每次滑动纪录当前页码数
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    if (scrollView.contentOffset.x >=0 && scrollView.contentOffset.x < _ImagesAry.count*385) {
        _num = scrollView.contentOffset.x / 385 ;
        _label.text = [NSString stringWithFormat:@"第%li张",_num+1];
    }
    else return;
    
}

//单元格消失的时候图片大小还原
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    _backNum = indexPath.row + 1;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"backNum" object:self];
    
    PicCellCollectionViewCell *myCell = (PicCellCollectionViewCell *)cell;
    [myCell returnFrame];
}


#pragma mark - 创建导航栏按钮
//在导航栏上 创建按钮
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
//按钮点击事件
- (void)buttonAction:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


//通知事件
- (void)hiddenNavi
{
    if (self.navigationController.navigationBarHidden == YES) {
        [self.navigationController setNavigationBarHidden:NO animated:YES ];
    }
    else
    {
        [self.navigationController setNavigationBarHidden:YES animated:YES ];
    }
}



- (void)viewDidLoad {
    [super viewDidLoad];
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.font = [UIFont boldSystemFontOfSize:30];
    _label.textColor = [UIColor whiteColor];
    
    self.navigationItem.titleView  = _label;
    
    _label.text = [NSString stringWithFormat:@"第%li张",self.num + 1];

    //self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor orangeColor];
    [self _creatview];
    [self _creatButton];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.translucent = YES;
    
    
    //接收通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hiddenNavi) name:@"disAppearNavi" object:nil];
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
