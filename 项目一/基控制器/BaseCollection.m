//
//  BaseCollection.m
//  项目一
//
//  Created by mac on 15/8/11.
//  Copyright (c) 2015年 chenhao. All rights reserved.
//

#import "BaseCollection.h"

@interface BaseCollection ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>



@end


@implementation BaseCollection

- (id)initWithFrame:(CGRect)frame itemSize:(CGSize)itemSize sectionInset:(UIEdgeInsets )sectionInset
{
    //创建布局对象
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //单元格大小
    layout.itemSize = itemSize;
    _itemSize = itemSize;
    layout.sectionInset = sectionInset;
    
    //单元格间隙
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    //滑动效果
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    
    //初始化视图
    self = [super initWithFrame:frame collectionViewLayout:layout];
    self.showsHorizontalScrollIndicator = NO;
    if (self)
    {
        self.delegate = self;
        self.dataSource = self;
        
        
        
        
        //注册单元格
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"postCell"];
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _movieData.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

//- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
//                     withVelocity:(CGPoint)velocity
//              targetContentOffset:(inout CGPoint *)targetContentOffset
//{
//    CGFloat offset = targetContentOffset->x;
//    offset = offset + (_itemSize.width )/2;
//    NSInteger num = offset/(_itemSize.width + 10);
//    
//    targetContentOffset->x = num *(_itemSize.width + 10);
//}



@end
