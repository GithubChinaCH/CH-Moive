//
//  HeadList.h
//  项目一
//
//  Created by mac on 15/8/10.
//  Copyright (c) 2015年 chenhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadList : UICollectionView

@property (nonatomic, assign) CGFloat nowNum;
@property (nonatomic, assign) NSInteger floatNUm;

- (void)setAry:(NSArray *)ary;


@end
