//
//  MovieDetailDatta.m
//  项目一
//
//  Created by mac on 15/8/6.
//  Copyright (c) 2015年 chenhao. All rights reserved.
//

#import "MovieDetailDatta.h"

@implementation MovieDetailDatta

- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        _titleCn = dic[@"titleCn"];
        _image = dic[@"image"];
        
        NSDictionary *release = dic[@"release"];
        _location = release[@"location"];
        _date = release[@"date"];
        
        _directors = dic[@"directors"];
        _actors = dic[@"actors"];
        _type = dic[@"type"];
        
        _images = dic[@"images"];
        
    }
    return self;
}


@end
