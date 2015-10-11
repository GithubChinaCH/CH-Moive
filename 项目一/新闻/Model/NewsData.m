//
//  NewsData.m
//  day1 项目1
//
//  Created by mac on 15/8/4.
//  Copyright (c) 2015年 chenhao. All rights reserved.
//

#import "NewsData.h"

@implementation NewsData

- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        _title = dic[@"title"];
        _summary = dic[@"summary"];
        _type = dic[@"type"];
        _image = dic[@"image"];
    }
    
    return self;
}

@end
