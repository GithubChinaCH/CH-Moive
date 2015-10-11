//
//  NewsTableViewCell.m
//  day1 项目1
//
//  Created by mac on 15/8/4.
//  Copyright (c) 2015年 chenhao. All rights reserved.
//

#import "NewsTableViewCell.h"

@implementation NewsTableViewCell

//自定义set方法
- (void)setMyNews:(NewsData *)myNews
{
    _myNews = myNews;
    _news.text = myNews.title;
    _summary.text = myNews.summary;

    //读取图片
    NSURL *url = [NSURL URLWithString:myNews.image];
    [_newsImage sd_setImageWithURL:url];


//    [self setNeedsLayout];
    
    
    NSNumber *myType = _myNews.type;

    
    if ([myType integerValue] == 0) {
        
        _summary.left = _newsImage.right + 10;

        _typeImage.image = nil;
    }
    else
    {
        NSString *imageName = ([myType integerValue] == 1) ? @"sctpxw" : @"scspxw";
        _typeImage.image = [UIImage imageNamed:imageName];

        _summary.left = _newsImage.right + 45;
        
    }
}


- (void)layoutSubviews
{
//    NSNumber *myType = _myNews.type;
//    NSLog(@"%@, %@", _news.text, myType);
//    _summary.backgroundColor = [UIColor redColor];
//    
//    if ([myType integerValue] == 0) {
//
//        CGRect rect = _summary.frame;
//        rect.origin.x = _news.frame.origin.x;
//        [UIView animateWithDuration:1 animations:^{
//            _summary.left = _newsImage.right + 10;
//        }];
//        
//    }
//    else if ([myType integerValue] == 1)
//    {
//        _typeImage.image = [UIImage imageNamed:@"sctpxw@2x"];
//    }
//    else
//    {
//        _typeImage.image = [UIImage imageNamed:@"scspxw"];
//    }

    
//    _typeImage.left = _newsImage.right + 5;
    
}



- (void)awakeFromNib {

    // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
