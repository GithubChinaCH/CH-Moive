//
//  MovieComment.h
//  项目一
//
//  Created by mac on 15/8/6.
//  Copyright (c) 2015年 chenhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieComment : NSObject

@property (nonatomic, copy) NSString *userImage;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) NSNumber *rating;

-(id)initWithDic:(NSDictionary *)dic;

@end
