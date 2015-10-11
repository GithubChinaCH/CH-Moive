//
//  TabButton.h
//  项目一
//
//  Created by mac on 15/8/3.
//  Copyright (c) 2015年 chenhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabButton : UIButton

/*
 初始化 button
 frame 位置大小
 title 标签的标题
 初始化完成后的button
 */
- (id)initWithFrame:(CGRect)frame
            imageName:(NSString *)imageName
                title:(NSString *)title;

@end
