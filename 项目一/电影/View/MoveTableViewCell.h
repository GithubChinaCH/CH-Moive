//
//  MoveTableViewCell.h
//  项目一
//
//  Created by mac on 15/8/4.
//  Copyright (c) 2015年 chenhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"
#import "Star.h"


@interface MoveTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *movieImage;
@property (weak, nonatomic) IBOutlet UILabel *movieName;
@property (weak, nonatomic) IBOutlet Star *markImage;

@property (weak, nonatomic) IBOutlet UILabel *year;
@property (weak, nonatomic) IBOutlet UILabel *mark;


@property (nonatomic, strong) Movie *message;
@end
