//
//  MovieDetail.m
//  项目一
//
//  Created by mac on 15/8/10.
//  Copyright (c) 2015年 chenhao. All rights reserved.
//

#import "MovieDetail.h"

@implementation MovieDetail

//重写set方法
- (void)setMessage:(Movie *)message
{
    //从move中读取small的地址并转换一个url对象
    NSURL *url = [NSURL URLWithString:message.images[@"small"]];
    //通过以一个url自动加载图片
    [_movieImage sd_setImageWithURL:url];
    
    //星星视图
    
    [_starView setRating:message.mark];
    
    _CHName.text = message.chinesseName;
    _CHName.numberOfLines = 0;
    _ENName.text = message.englishName;
    _ENName.numberOfLines = 0;
    
    _year.text = [NSString stringWithFormat:@"上映年份:%@",message.year];

    _rating.text = [NSString stringWithFormat:@"%.1f",message.mark];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
