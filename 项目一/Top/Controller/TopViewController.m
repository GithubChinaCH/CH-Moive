//
//  TopViewController.m
//  项目一
//
//  Created by mac on 15/8/3.
//  Copyright (c) 2015年 chenhao. All rights reserved.
//

#import "TopViewController.h"
#import "TopData.h"
#import "TopCollectionViewCell.h"
#import "DetailViewController.h"

@interface TopViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSMutableArray *_topData;
}

@end

@implementation TopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Top250";
    
    [self _loadData];
    [self _creatView];
    
}

//创建视图
- (void)_creatView
{
    CGFloat width = (kScreenWeight - 10*4)/3;
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.minimumInteritemSpacing = 10;
    flow.minimumLineSpacing = 10;
    flow.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    flow.itemSize = CGSizeMake(width, 150);
    
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWeight, kScreenHeight - 64) collectionViewLayout:flow];
    collection.dataSource = self;
    collection.delegate = self;
    
    collection.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main@2x"]];
    
    UINib *nib = [UINib nibWithNibName:@"TopCollectionViewCell" bundle:[NSBundle mainBundle]];
    [collection registerNib:nib forCellWithReuseIdentifier:@"topCell"];
    [self.view addSubview:collection];
}

#pragma mark - datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _topData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"topCell" forIndexPath:indexPath];
    cell.message = _topData[indexPath.row];
    return cell;
}



//读取数据
- (void)_loadData
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"top250" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSError *err = [[NSError alloc] init];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&err];
    _topData = [[NSMutableArray alloc] init];
    
    for (NSDictionary *d in dic[@"subjects"])
    {
        TopData *data = [[TopData alloc] initWithDic:d];
        [_topData addObject:data];
    }

    for (int i = 0; i < _topData.count - 1; i++) {
        for (int j = i+1; j < _topData.count; j++) {
            TopData *now = _topData[j];
            TopData *last = _topData[i];
            CGFloat nownum = [now.rating floatValue];
            CGFloat lastnum = [last.rating floatValue];
            if (lastnum<nownum) {
                [_topData exchangeObjectAtIndex:i withObjectAtIndex:j];
            }
        }
    }

}


#pragma mark - delegate
//选中单元格
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detail = [[DetailViewController alloc] init];
    [self.navigationController pushViewController:detail animated:YES];
    
    
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
