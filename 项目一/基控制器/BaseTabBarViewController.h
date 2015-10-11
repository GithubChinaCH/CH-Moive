//
//  BaseTabBarViewController.h
//  项目一
//
//  Created by mac on 15/8/3.
//  Copyright (c) 2015年 chenhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTabBarViewController : UITabBarController

//设置自定义的标签栏是否隐藏
- (void)setTabBarHidden:(BOOL)hidden animation:(BOOL)animation;

@property (nonatomic, strong) UIImageView *selectImage;
@end
