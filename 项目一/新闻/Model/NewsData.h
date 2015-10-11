//
//  NewsData.h
//  day1 项目1
//
//  Created by mac on 15/8/4.
//  Copyright (c) 2015年 chenhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsData : NSObject

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSNumber *type;
@property (nonatomic,strong) NSString *image;
@property (nonatomic,strong) NSString *summary;


-(id)initWithDic:(NSDictionary *)dic;
@end
