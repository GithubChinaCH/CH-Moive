//
//  TabButton.m
//  项目一
//
//  Created by mac on 15/8/3.
//  Copyright (c) 2015年 chenhao. All rights reserved.
//

#import "TabButton.h"

@interface TabButton()
{
    UIImageView *_imageView;//图标
    UILabel *_titleLabel;   //文字
    
}

@end



@implementation TabButton


- (id)initWithFrame:(CGRect)frame imageName:(NSString *)imageName title:(NSString *)title
{
    self = [super init];
    if (self)
    {
        //对输入的frame 进行约束 和调整
        frame.size.height = 49;
        frame.origin.y = 0;
        self.frame = frame;
        
        [self _createSubView];
        
        _imageView.image = [UIImage imageNamed:imageName];
        _titleLabel.text = title;
        
        
    }
    return self;
}

- (void)_createSubView
{
    //创建图标
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 27, 25)];
    _imageView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2-5);
    //设置图片视图的拉升模式
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_imageView];
    
    
    
    //创建label
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 45, 10)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont systemFontOfSize:12];
    _titleLabel.center = CGPointMake(self.width/2, self.height/2-5);
    //让label的顶部 和 image 的底部对齐
    _titleLabel.top = _imageView.bottom+3;
    [self addSubview:_titleLabel];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
