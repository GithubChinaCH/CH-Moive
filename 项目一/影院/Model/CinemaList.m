    //
//  CinemaList.m
//  项目一
//
//  Created by mac on 15/8/7.
//  Copyright (c) 2015年 chenhao. All rights reserved.
//

#import "CinemaList.h"

@implementation CinemaList

- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        _name = dic[@"name"];
        _address = dic[@"address"];
        _lowPrice = dic[@"lowPrice"];
        //NSLog(@"%@", _lowPrice);
        _isCouponSupport = dic[@"isCouponSupport"];
        _isSeatSupport = dic[@"isSeatSupport"];
        _grade = dic[@"grade"];
        //_distance = dic[@"distance"];
        _districtId = dic[@"districtId"];
        _isGroupBuySupport = dic[@"isGroupBuySupport"];
    }
    return self;
}

@end
