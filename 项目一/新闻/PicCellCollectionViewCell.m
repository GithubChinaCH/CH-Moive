//
//  PicCellCollectionViewCell.m
//  简易图片 浏览器
//
//  Created by mac on 15/8/9.
//  Copyright (c) 2015年 chenhao. All rights reserved.
//

#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

#import "PicCellCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@interface PicCellCollectionViewCell ()<UIScrollViewDelegate>
{
    UIScrollView *_scroll;
    
    UIImageView *_imageV;
    
    NSTimer *_timer;
    
    CGFloat _height;  //接受图片高
    CGFloat _width;   //接受图片宽
}

@end

@implementation PicCellCollectionViewCell

//重写init方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _creatView];
        
        [self addTag];
        
        
    }
    return self;
}

//创建滑动视图
- (void)_creatView
{
    _scroll = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self.contentView addSubview: _scroll];
    
    //_scroll.backgroundColor = [UIColor orangeColor];
    
    _imageV = [[UIImageView alloc] initWithFrame:self.bounds];
    [_scroll addSubview:_imageV];
    _imageV.contentMode = UIViewContentModeScaleAspectFit;
    
    _height = _imageV.frame.size.height;
    _width = _imageV.frame.size.width;
    
    _scroll.delegate = self;
    
    _scroll.minimumZoomScale = 0.3;
    _scroll.maximumZoomScale = 10;
}

#pragma mark - delegate

//放回可以缩小放大的图片
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    
    return _imageV;
}

//滑动视图改变大小执行的方法
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    if (scale < 1) {
        _imageV.center = CGPointMake(kScreenWidth/2, kScreenHeight/2);
        return;
    }
}


#pragma mark - 手势
//添加手势
- (void)addTag
{
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] init];
    tap1.numberOfTapsRequired = 1;
    tap1.numberOfTouchesRequired= 1;
    [tap1 addTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tap1];
    
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] init];
    tap2.numberOfTapsRequired = 2;
    tap2.numberOfTouchesRequired = 1;
    [tap2 addTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tap2];
}
//手势执行的方法
- (void)tapAction:(UITapGestureRecognizer *)tap
{
    if (tap.numberOfTapsRequired == 1) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(oneTap:) userInfo:nil repeats:NO];
    }
    else if (tap.numberOfTapsRequired == 2)
    {
        [_timer invalidate];
        [self twoTap];
    }
}

//点击一次执行的方法
- (void)oneTap:(UITapGestureRecognizer *)tap
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"disAppearNavi" object:self];
}
//点击两次执行的方法
- (void)twoTap
{
    if (_imageV.frame.size.height == _height && _imageV.frame.size.width == _width)
    {
        [_scroll setZoomScale:3 animated:YES];
    }
    else
    {
        [_scroll setZoomScale:1 animated:YES];
        _imageV.frame = self.bounds;
        
    }
}

//还原图片大小
- (void)returnFrame
{
    [_scroll setZoomScale:1];
    _imageV.frame = self.bounds;
}



#pragma mark - set
//自定义set方法
- (void)setImageWithURL:(NSURL *)url
{
    [_imageV sd_setImageWithURL:url];
    
}

- (void)setImageWithImage:(UIImage *)image
{
    _imageV.image = image;
}

- (void)setImageWithStr:(NSString *)str
{
    _imageV.image = [UIImage imageNamed:str];
}



- (void)awakeFromNib {
    // Initialization code
}

@end
