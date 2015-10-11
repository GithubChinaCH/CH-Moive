//
//  PictureListViewController.h
//  简易图片 浏览器
//
//  Created by mac on 15/8/9.
//  Copyright (c) 2015年 chenhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PictureListViewController : UIViewController

- (instancetype)initWithAry:(NSArray *)ary;

@property (nonatomic, strong) NSArray *ImagesAry;



@end
