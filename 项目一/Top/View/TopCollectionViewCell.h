//
//  TopCollectionViewCell.h
//  项目一
//
//  Created by mac on 15/8/5.
//  Copyright (c) 2015年 chenhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopData.h"
#import "Star.h"

@interface TopCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *backImage;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet Star *starImage;

@property(nonatomic ,strong) TopData *message;
@property (weak, nonatomic) IBOutlet UILabel *rating;

@end
