//
//  MovieDetail.h
//  项目一
//
//  Created by mac on 15/8/10.
//  Copyright (c) 2015年 chenhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Star.h"
#import "Movie.h"

@interface MovieDetail : UIView
@property (weak, nonatomic) IBOutlet UIImageView *movieImage;
@property (weak, nonatomic) IBOutlet UILabel *CHName;
@property (weak, nonatomic) IBOutlet UILabel *ENName;
@property (weak, nonatomic) IBOutlet Star *starView;
@property (weak, nonatomic) IBOutlet UILabel *rating;
@property (weak, nonatomic) IBOutlet UILabel *year;

@property (nonatomic, strong) Movie *message;

@end
