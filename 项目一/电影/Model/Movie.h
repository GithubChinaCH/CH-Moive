//
//  Movie.h
//  项目一
//
//  Created by mac on 15/8/4.
//  Copyright (c) 2015年 chenhao. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MovieImageSmall @"small"


@interface Movie : NSObject

@property (nonatomic,strong) NSString *chinesseName;  //中文名
@property (nonatomic,strong) NSString *englishName;   //英文名
@property (nonatomic,assign) CGFloat mark;            //评分
@property (nonatomic,strong) UIImage *image;          //图片
@property (nonatomic,strong) NSString *year;          //年份
@property (nonatomic,strong) NSDictionary *images;

//自定义初始化方法
- (id)initWithDic:(NSDictionary *)dic;

@end
