//
//  PostCollection.h
//  项目一
//
//  Created by mac on 15/8/10.
//  Copyright (c) 2015年 chenhao. All rights reserved.
//

#import "BaseCollection.h"

@interface PostCollection : BaseCollection //<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

{
   // NSArray *_movieAry;
}
//@property (nonatomic,strong) NSArray *movieAry;
@property (nonatomic, copy) NSString *movieName;
@property (nonatomic, assign) NSInteger nowNum;
@property (nonatomic, assign) NSInteger floatNUm;
//- (void)setAry:(NSArray *)ary;

@end
