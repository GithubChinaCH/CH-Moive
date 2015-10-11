//
//  PostCollection.m
//  项目一
//
//  Created by mac on 15/8/10.
//  Copyright (c) 2015年 chenhao. All rights reserved.
//

#import "PostCollection.h"
#import "Movie.h"
#import "MovieDetail.h"


@interface PostCollection ()
{
    UILabel *_nameLabel;
    
    
    BOOL isHidden;
}

@end

@implementation PostCollection
/*
- (id)initWithFrame:(CGRect)frame
{
    //创建布局对象
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //单元格大小
    layout.itemSize = CGSizeMake(frame.size.width * 0.7, frame.size.height * 0.7);
    //单元格间隙
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(40, frame.size.width*0.15, 0, frame.size.width * 0.15);
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
*/

#pragma mark - dataSource
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
//{
//    return self.movieData.count;
//}

//创建单元格
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"postCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor grayColor];
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:cell.bounds];
    Movie *movie = self.movieData[indexPath.row];
    [imageV sd_setImageWithURL:movie.images[@"large"]];
    cell.backgroundView = imageV;
    
    NSArray *ary = [[NSBundle mainBundle]loadNibNamed:@"MovieDetail" owner:self options:nil];
    
    MovieDetail *view = [ary lastObject];
    view.frame = cell.bounds;
    //view.backgroundColor = [UIColor grayColor];
    view.tag = 100 + indexPath.row;
    view.hidden = YES;
    view.message = movie;

    
    [cell addSubview:view];
    
    
    return cell;
}


/*
 滑动视图将要停止时调用
 
 scrollView           //滑动视图
 velocity             //滑动速度
 targetContentOffset  //结构体指针 表示滑动停止之后的偏移量
 
 */

//自定义滑动宽度
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset
{
    //分页显示
    //分页显示本质是滑动停止之后停止在某一页上
    //改变滑动结束后的偏移量
    
    //获取系统滑动结束后的偏移量
    CGFloat offset = targetContentOffset->x;
    //计算滑动完成之后落在哪一个单元格内
    /*
     0 － 0.5 ＋ 间隙宽度        0
     0.5 - 1.5 + 2*间隙         1
     1.5 － 2.5 ＋ 3*间隙        2
    */
    offset = offset + (scrollView.width*0.7 ) /2 ;
    NSInteger index = offset/(scrollView.width * 0.7 +10);
    
    //计算分页后的偏移量
    offset = index * (scrollView.width *0.7 + 10);
    
    //改变滑动结束后的偏移量
    targetContentOffset->x = offset;
    
}



//点击单元格 滑动/翻转
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //判断点击的是哪个单元格
    //1 根据偏移量 计算当前显示在最中间的单元格
    NSInteger index = (collectionView.contentOffset.x + kScreenWeight*0.7/2) / (collectionView.width * 0.7 +10);
    //2 和被点击的单元格indexpath做比较
    if (index == indexPath.item) {
        //点击正中间分单元格 做翻转
        UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
        UIView *view = (UIView *)[cell viewWithTag:100 + indexPath.row];
        
        UIViewAnimationOptions option = (view.hidden)?UIViewAnimationOptionTransitionFlipFromLeft : UIViewAnimationOptionTransitionFlipFromRight;
        [UIView transitionWithView:[collectionView cellForItemAtIndexPath:indexPath]
                          duration:0.3
                           options:option
                        animations:^{
             view.hidden = !view.hidden;
                        }
                        completion:nil];
    }
    else
    {
        //点击两边的单元格 滑动到中间
        
        CGPoint point = CGPointMake(indexPath.item * (kScreenWeight *0.7 +10), collectionView.contentOffset.y);
        [collectionView setContentOffset:point animated:YES];
//        [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        
    }
    
}

//发送通知
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x < 0 || scrollView.contentOffset.x > 2800) {
        return;
    }
    else
    {
        self.floatNUm = (scrollView.contentOffset.x + 0.35* kScreenWeight)/ (self.size.width * 0.7  +10);
        
        _nowNum = (scrollView.contentOffset.x + 0.35* kScreenWeight) / (self.size.width * 0.7  +10);
        Movie *movie = self.movieData[_nowNum];
        _movieName = movie.chinesseName;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeName" object:self];
    }
}



//将视图从单元格上移除
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIView *view = [cell viewWithTag:100 + indexPath.row];
//    view.hidden = YES;
    [view removeFromSuperview];
    //NSLog(@"%li",indexPath.row);
}


//- (void)setAry:(NSArray *)ary
//{
//    _movieAry = ary;
//}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
