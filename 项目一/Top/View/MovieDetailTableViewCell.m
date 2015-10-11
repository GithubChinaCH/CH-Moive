//
//  MovieDetailTableViewCell.m
//  项目一
//
//  Created by mac on 15/8/6.
//  Copyright (c) 2015年 chenhao. All rights reserved.
//

#import "MovieDetailTableViewCell.h"

@implementation MovieDetailTableViewCell

- (void)awakeFromNib {

    // Initialization code
}

- (void)setMessage:(MovieDetailDatta *)message
{
    _message = message;
    _titleCN.text = message.titleCn;
    _date.text = [NSString stringWithFormat:@"%@ %@",message.location,message.date];
    
    _directors.text = [self appendStr:message.directors];
    _type.text = [self appendStr:message.type];
    _actors.text = [self appendStr:message.actors];
    _actors.numberOfLines = 0;
    
    
    //读取图片
    NSURL *url = [NSURL URLWithString:message.image];
    [_image sd_setImageWithURL:url];
    
    [self _creatView];
}


//创建collection 视图
- (void)_creatView
{
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.minimumInteritemSpacing = 11;
    flow.minimumLineSpacing = 11;
    CGFloat width = (kScreenWeight - (11*5))/4;
    flow.itemSize = CGSizeMake(width, 80);
    flow.sectionInset = UIEdgeInsetsMake(10, 11, 10, 11);
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView *detailCollect = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 200, kScreenWeight, 100) collectionViewLayout:flow];
    detailCollect.delegate = self;
    detailCollect.dataSource = self;
    
    detailCollect.layer.cornerRadius = 10;
    detailCollect.layer.masksToBounds = YES;
    detailCollect.layer.borderWidth = 2;
    detailCollect.layer.borderColor = [[UIColor orangeColor]CGColor];
    
    [detailCollect registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"movieImage"];
    [self.contentView addSubview:detailCollect];
}

#pragma mark - dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _message.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"movieImage" forIndexPath:indexPath];
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius = 40;
    cell.layer.borderWidth = 3;
    cell.layer.borderColor = [[UIColor orangeColor]CGColor];

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:cell.bounds];
    NSURL *url = [NSURL URLWithString:_message.images[indexPath.row]];
    [imageView sd_setImageWithURL:url];
    
    cell.backgroundView = imageView;
    
    return cell;
}



//自定义拼接字符串
- (NSString *)appendStr:(NSArray *)ary
{
    NSString *str = [[NSString alloc] init];
    for (int i = 0; i<ary.count; i++) {
        if (i == 0) {
            str = [NSString stringWithFormat:@"%@",ary[i]];
        }
        else
        {
            str = [NSString stringWithFormat:@"%@、%@",str,ary[i]];
        }

    }
    return str;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
