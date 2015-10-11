//
//  HeadList.m
//  项目一
//
//  Created by mac on 15/8/10.
//  Copyright (c) 2015年 chenhao. All rights reserved.
//

#import "HeadList.h"
#import "Movie.h"


@interface HeadList ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSArray *_imageAry;
}


@end

@implementation HeadList

- (void)setAry:(NSArray *)ary
{
    _imageAry = ary;
}

//重写initWithFrame方法
- (id)initWithFrame:(CGRect)frame
{
    //创建布局对象
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing =10;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    layout.itemSize = CGSizeMake(80, 100);
    layout.sectionInset = UIEdgeInsetsMake(5, kScreenWeight/2 - 40, 25, kScreenWeight/2 - 40);
    
    
    
    self = [super initWithFrame:frame collectionViewLayout:layout];
    self.showsHorizontalScrollIndicator = NO;
    if (self)
    {
        self.delegate = self;
        self.dataSource = self;
        
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"headListCell"];
    }
    return self;
}


#pragma mark - datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _imageAry.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"headListCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor grayColor];
    
    cell.layer.borderWidth = 3;
    cell.layer.masksToBounds = YES;
    cell.layer.borderColor = [[UIColor yellowColor]CGColor];
    cell.layer.cornerRadius = 20;
    
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:cell.bounds];
    Movie *movie = _imageAry[indexPath.row];
    [image sd_setImageWithURL:movie.images[@"small"]];
    
    cell.backgroundView = image;
    
    return cell;
}


#pragma mark - delegate
//自定义滑动宽度
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset
{
    CGFloat offset = targetContentOffset->x;
    offset = offset + 45;
    NSInteger num = offset/90;
    
    targetContentOffset->x = num *90;
}


//点击单元格事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger num = (collectionView.contentOffset.x + 45)/90;
    if (num != indexPath.item) {
        [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }
}


//滑动通知
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.floatNUm = (scrollView.contentOffset.x + 45)/90;
    _nowNum = (scrollView.contentOffset.x + 45)/90;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"headControlFoot" object:self];
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
