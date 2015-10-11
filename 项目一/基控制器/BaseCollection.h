//
//  BaseCollection.h
//  项目一
//
//  Created by mac on 15/8/11.
//  Copyright (c) 2015年 chenhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCollection : UICollectionView

- (id)initWithFrame:(CGRect)frame itemSize:(CGSize)itemSize sectionInset:(UIEdgeInsets )sectionInset;

@property (nonatomic, strong) NSArray *movieData;

@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, assign) UIEdgeInsets sectionInset;



@end
