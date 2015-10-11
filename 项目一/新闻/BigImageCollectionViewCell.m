//
//  BigImageCollectionViewCell.m
//  项目一
//
//  Created by mac on 15/8/8.
//  Copyright (c) 2015年 chenhao. All rights reserved.
//

#import "BigImageCollectionViewCell.h"

@interface BigImageCollectionViewCell()<UIScrollViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UIImageView *_imageView;
    NSTimer *_timer;
    
    UIScrollView *_scroll;
    
    BOOL _isChange;
}
@end

@implementation BigImageCollectionViewCell

//自定义frame方法
- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self)
    {
        [self _creatView];
        
        [self _addTap];
    }
    return self;
}

//创建视图
- (void)_creatView
{
    //创建 滑动视图
    _scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 44, kScreenWeight, kScreenHeight-61)];
    [self addSubview:_scroll];

    //_scroll.backgroundColor = [UIColor yellowColor];
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 175, kScreenWeight, 317)];
    _imageView.contentMode = UIViewContentModeScaleToFill;
    [_scroll addSubview:_imageView];
    
    _scroll.minimumZoomScale = 0.3;
    _scroll.maximumZoomScale = 10;
    
    _scroll.delegate = self;
    _scroll.delegate = self;
    
    _scroll.contentSize = CGSizeMake(kScreenWeight, kScreenHeight);
}

//设置缩放视图
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    _isChange = NO;
    return _imageView;
}

//改变视图大小代理方法
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    //NSLog(@"%lf  %lf",self.size.width ,self.size.height);

    if (scale < 1) {
        _imageView.center = CGPointMake(kScreenWeight/2, kScreenHeight/2);
        _isChange = YES;
        return;
    }
    else if (scale > 1)
    {
        CGPoint point = _imageView.center;
        
        point = CGPointMake(kScreenWeight*scale / 2, 317 *scale /2);
        
        _imageView.center = point;
        _isChange  = YES;
        return;
    }
    else
    {
        _imageView.center = CGPointMake(kScreenWeight/2, kScreenHeight/2);
        _isChange = NO;
    }
}



//自定义set方法
- (void)setImageURL:(NSURL *)url
{
    [_imageView sd_setImageWithURL:url];
}


//添加点击事件

- (void)_addTap
{
    //点击的手势识别器
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] init];
    //点击两次
    tap1.numberOfTapsRequired = 2;
    //点击的手指数量
    tap1.numberOfTouchesRequired = 1;
    
    //添加一个执行的方法
    [tap1 addTarget:self action:@selector(tapAction:)];
    
    
    [self addGestureRecognizer:tap1];
    
    
    //点击的手势识别器
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] init];
    //点击两次
    tap2.numberOfTapsRequired = 1;
    //点击的手指数量
    tap2.numberOfTouchesRequired = 1;
    
    //添加一个执行的方法
    [tap2 addTarget:self action:@selector(tapAction:)];
    
    
    [self addGestureRecognizer:tap2];
}

/*
 单击双击的区分
 1 触发单击事件 使用一个定时器来判断 延迟0.5s
 2 如果 时间到了 但是没有执行 双击事件则执行
 3 如果执行了双击事件 则停止计时器
 
 */


//点击事件执行方法
- (void)tapAction:(UITapGestureRecognizer *)tap
{
    if (tap.numberOfTapsRequired == 2) {
        //双击
        [_timer invalidate];
        [self retutnScroll];
        //NSLog(@"2");
    }
    else if (tap.numberOfTapsRequired == 1)
    {
        //单击
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(tapOneAction:) userInfo:nil repeats:NO];
        
        
    }
}

//单击事件
- (void)tapOneAction:(UITapGestureRecognizer *)tap
{
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"disAppearNavi" object:self];
}

//双击事件
- (void)retutnScroll
{
    CGFloat scale = _scroll.zoomScale;
    //_isChange = !_isChange;
    if (scale != 1) {
        [_scroll setZoomScale:1 animated:YES];
//        _isChange = YES;
    }
    else{
        //设置当前的缩放比例 还原到未缩放状态
        [_scroll setZoomScale:3 animated:YES];
//        _isChange = NO;
    }
}

//视图回到原来尺寸
- (void)setBack
{
    [_scroll setZoomScale:1];
    _imageView.frame = CGRectMake(0, 175, kScreenWeight, 317);
}

@end
