//
//  Star.m
//  项目一
//
//  Created by mac on 15/8/4.
//  Copyright (c) 2015年 chenhao. All rights reserved.
//

#import "Star.h"

@interface Star()
{
    UIView *_grayView;
    UIView *_yellowView;
}

@end


@implementation Star


//initWithFrame 从xib文件中读取时是不会调用的
- (id)initWithFrame:(CGRect)frame
{
    //强制让视图的宽高成比例 能够显示五颗星
    CGFloat width = frame.size.height/17 * 17.5 *5;
    frame.size.width = width;
    self = [super initWithFrame:frame];
    if (self) {
        //[self _createViews];
    }
    return self;
}


//从xib创建view时所调用的方法
- (void)awakeFromNib
{
    CGFloat width = self.frame.size.height/17 * 17.5 *5;
    self.width = width;
    [self _createViews];
}


//根据值来改变黄色视图的宽度
- (void)setRating:(CGFloat)rating
{
    if (rating <0 || rating >10) {
        return;
    }
    //改变黄色视图宽度
    _yellowView.width = _grayView.width * rating / 10;
}

//创建星星视图
- (void)_createViews
{

    //创建灰色
    _grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 17.5 * 5, 17)];
    [self addSubview:_grayView];
    
    _grayView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gray@2x"]];
    
    //创建黄色
    _yellowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 17.5*5, 17)];
    [self addSubview:_yellowView];
    
    _yellowView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"yellow@2x"]];
    //使用transform对星星视图进行缩放 使其和父视图一样
    //1 计算缩放比例
    CGFloat scale = self.size.height/17;
    //2 设置缩放transform
    CGAffineTransform transform = CGAffineTransformMakeScale(scale, scale);
    
    //3 进行缩放
    _grayView.transform = transform;
    _yellowView.transform = transform;
    
    //让位置和大小变换过后的视图 重新移动到原来的位置上
//    _grayView.frame = self.bounds;
//    _yellowView.frame = self.bounds;
    
    _grayView.left = 0;
    _yellowView.left = 0;
    
}


@end
