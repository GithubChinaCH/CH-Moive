//
//  CinemaList.h
//  项目一
//
//  Created by mac on 15/8/7.
//  Copyright (c) 2015年 chenhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CinemaList : NSObject

@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *address;
@property(nonatomic, copy) NSString *lowPrice;
@property(nonatomic, strong) NSNumber *isSeatSupport;
@property(nonatomic, strong) NSNumber *isCouponSupport;
@property(nonatomic, strong) NSNumber *isGroupBuySupport;
@property(nonatomic, copy) NSString *grade;
@property(nonatomic, copy) NSString *distance;
@property(nonatomic, copy) NSString *districtId;


- (id)initWithDic:(NSDictionary *)dic;

@end
