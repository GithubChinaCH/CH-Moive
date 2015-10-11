//
//  Movie.m
//  项目一
//
//  Created by mac on 15/8/4.
//  Copyright (c) 2015年 chenhao. All rights reserved.
//

#import "Movie.h"


@implementation Movie

//自定义创建方法
- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        NSDictionary *sub = dic[@"subject"];
        _chinesseName = sub[@"title"];
        _englishName = sub[@"original_title"];
        _year = sub[@"year"];
        _images = sub[@"images"];
        
        NSDictionary *rating = sub[@"rating"];
        NSNumber *num = rating[@"average"];
        _mark = [num floatValue];
        
    }
    return self;
}

@end
