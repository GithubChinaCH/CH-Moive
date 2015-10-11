//
//  TopData.m
//  项目一
//
//  Created by mac on 15/8/5.
//  Copyright (c) 2015年 chenhao. All rights reserved.
//

#import "TopData.h"

@implementation TopData

-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self)
    {
        _images = dic[@"images"];
        
        NSDictionary *num = dic[@"rating"];
        _rating = num[@"average"];
        
        _title = dic[@"title"];
    }
    return self;
    
}

@end
