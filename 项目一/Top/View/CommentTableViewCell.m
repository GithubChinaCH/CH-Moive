//
//  CommentTableViewCell.m
//  项目一
//
//  Created by mac on 15/8/6.
//  Copyright (c) 2015年 chenhao. All rights reserved.
//

#import "CommentTableViewCell.h"

@implementation CommentTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


- (void)setMessage:(MovieComment *)message
{
    _message = message;
    _nickname.text = message.nickname;
    _content.text = message.content;
    _content.numberOfLines = 0;
    
    CGFloat num = [message.rating floatValue];
    if (num != 0)
    {
        _rating.text = [NSString stringWithFormat:@"%.1f",num];
    }
    else
    {
        _rating.text = [NSString stringWithFormat:@""];
    }
    
    
    NSURL *url = [NSURL URLWithString:message.userImage];
    [_userImage sd_setImageWithURL:url];
    _userImage.layer.masksToBounds = YES;
    _userImage.layer.cornerRadius = 5;


    
    _backView.layer.masksToBounds = YES;
    _backView.layer.cornerRadius = 5;
    _backView.backgroundColor = [UIColor whiteColor];
    //_backView.size = CGSizeMake(300, 50);
    
    
    
    CGRect rect = [message.content boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 10000)
                                    options:NSStringDrawingUsesLineFragmentOrigin
                                 attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20]}
                                    context:nil];
    
    _content.size = CGSizeMake(_content.size.width , rect.size.height+20);

    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
