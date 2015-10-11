//
//  MovieComment.m
//  项目一
//
//  Created by mac on 15/8/6.
//  Copyright (c) 2015年 chenhao. All rights reserved.
//

#import "MovieComment.h"

@implementation MovieComment

- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        _userImage = dic[@"userImage"];
        _content = dic[@"content"];
        
        
        _rating = dic[@"rating"];
        
        _nickname = dic[@"nickname"];
    }
    return self;
}

@end
