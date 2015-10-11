//
//  MoveTableViewCell.m
//  项目一
//
//  Created by mac on 15/8/4.
//  Copyright (c) 2015年 chenhao. All rights reserved.
//

#import "MoveTableViewCell.h"


@implementation MoveTableViewCell

//重写set方法
- (void)setMessage:(Movie *)message
{
    //_message = message;
    
    _year.text = message.year;
    _movieName.text = message.chinesseName;
    _mark.text = [NSString stringWithFormat:@"%.1f",message.mark];
    
    //电影图片
    //从move中读取small的地址并转换一个url对象
    NSURL *url = [NSURL URLWithString:message.images[@"small"]];
    //通过以一个url自动加载图片
    [_movieImage sd_setImageWithURL:url];
    
    //星星视图
    
    [_markImage setRating:message.mark];
    
    
    
        
    
    
    
}


- (void)awakeFromNib {
    // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected == YES) {
        
    }
    // Configure the view for the selected state
}

@end
