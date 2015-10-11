//
//  TopData.h
//  项目一
//
//  Created by mac on 15/8/5.
//  Copyright (c) 2015年 chenhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopData : NSObject

@property (nonatomic,copy) NSString *title;
@property (nonatomic,strong) NSNumber *rating;
@property (nonatomic,strong) NSDictionary *images;

- (id)initWithDic:(NSDictionary *)dic;

@end
