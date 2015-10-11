//
//  CinemaTableViewCell.m
//  项目一
//
//  Created by mac on 15/8/7.
//  Copyright (c) 2015年 chenhao. All rights reserved.
//

#import "CinemaTableViewCell.h"

@implementation CinemaTableViewCell

- (void)setMessage:(CinemaList *)message
{

    _name.text = message.name;
    _name.numberOfLines = 0;
    
    if ([message.lowPrice isKindOfClass:[NSString class]]) {
        _price.text = [NSString stringWithFormat:@"¥%@",message.lowPrice];
    }
    else
    {
        _price.text = nil;
    }
    _adress.text = message.address;
    _adress.numberOfLines = 0;
    _grade.text = message.grade;
    //_distance.text = message.distance;
    
    UIImage *image = ([message.isSeatSupport integerValue] == 1) ?[UIImage imageNamed:@"cinemaSeatMark@2x"] : nil;
    _seatImage.image = image;
    
    UIImage *image1 = ([message.isSeatSupport integerValue] == 1) ?[UIImage imageNamed:@"cinemaGrouponMark@2x"] : nil;
    _groupImage.image = image1;
    
    UIImage *image2 = ([message.isSeatSupport integerValue] == 1) ?[UIImage imageNamed:@"cinemaCouponMark@2x"] : nil;
    _couponImage.image = image2;
    
}





- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
