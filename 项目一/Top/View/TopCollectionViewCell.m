//
//  TopCollectionViewCell.m
//  项目一
//
//  Created by mac on 15/8/5.
//  Copyright (c) 2015年 chenhao. All rights reserved.
//

#import "TopCollectionViewCell.h"

@implementation TopCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}


- (void)setMessage:(TopData *)message
{
    _message = message;
    
    CGFloat num = [message.rating floatValue];
    
    _rating.text = [NSString stringWithFormat:@"%.1f",num];
    _title.text = message.title;
    
    //背景图片
    NSURL *url = [NSURL URLWithString:message.images[@"small"]];

    [_backImage sd_setImageWithURL:url];
    
    [_starImage setRating:num];
    
    
}


@end
