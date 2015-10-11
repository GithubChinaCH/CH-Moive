//
//  NewsTableViewCell.h
//  day1 项目1
//
//  Created by mac on 15/8/4.
//  Copyright (c) 2015年 chenhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsData.h"


@interface NewsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *newsImage;
@property (weak, nonatomic) IBOutlet UIImageView *typeImage;
@property (weak, nonatomic) IBOutlet UILabel *news;
@property (weak, nonatomic) IBOutlet UILabel *summary;


@property (nonatomic,strong) NewsData *myNews;

@end
