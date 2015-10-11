//
//  launchScreenViewController.m
//  项目一
//
//  Created by mac on 15/8/12.
//  Copyright (c) 2015年 chenhao. All rights reserved.
//

#import "LaunchScreenViewController.h"

@interface LaunchScreenViewController ()
{
    NSInteger z;
    
    NSTimer *_timer;
    
    NSMutableArray *_allNumAry;
}

@end

@implementation LaunchScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIApplication *app = [UIApplication sharedApplication];
    [app setStatusBarHidden:YES];
    
    z = 1;
    [self _creatImageView];

    
    [self saveNum];
    
    
    /*
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                              target:self
                                            selector:@selector(showImage)
                                            userInfo:nil
                                             repeats:YES];*/
    
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(showImageTwo:) userInfo:nil repeats:YES];
}

- (void)_creatMyImageWithX:(NSInteger)x Y:(NSInteger)y
{
    CGFloat imageWidth = kScreenWeight / 4;
    CGFloat imageHeight = kScreenHeight / 6;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x * imageWidth, y * imageHeight, imageWidth, imageHeight)];
    [self.view addSubview:imageView];
    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%li",z]];
    imageView.tag = z;
    z++;
    imageView.hidden = YES;
}

//创建imageView
- (void)_creatImageView
{
    //计算每一个ImageView的大小
    
    NSInteger x = 0;
    NSInteger y = 0;
    
    for (y = 0; x < 4; x++) {
        [self _creatMyImageWithX:x Y:y];
    }
    
    //最后一列
    y = 1;
    x = 3;
    for (x = 3; y < 6; y ++)
    {
        [self _creatMyImageWithX:x Y:y];
    }
    
    //最后一排
    x=2;
    for (y = 5; x >=0; x--) {
        [self _creatMyImageWithX:x Y:y];
    }
    
    //第一列
    y = 4;
    for (x = 0; y > 0; y--) {
        [self _creatMyImageWithX:x Y:y];
    }
    
    x = 1;
    for (y = 1; x < 3; x ++) {
        [self _creatMyImageWithX:x Y:y];
    }
    
    y = 2;
    for (x = 2; y < 5; y++) {
        [self _creatMyImageWithX:x Y:y];
    }
    
    x = 1;
    for (y = 4;y > 1 ; y--) {
        [self _creatMyImageWithX:x Y:y];
    }
}

//开机动画
- (void)showImage
{
    static int i = 1;
    UIImageView *image = (UIImageView *)[self.view viewWithTag:i];
    image.hidden = NO;
    i++;
    
    if (i == 25) {
        [_timer invalidate];
        [self performSelector:@selector(showFirstView) withObject:self afterDelay:0.5];
    }
}

//自定义开机动画2
- (void)showImageTwo:(NSTimer *)timer
{
    NSInteger num = [self getRandNum];
//    NSLog(@"%li",num);
    UIImageView *imageV = (UIImageView *)[self.view viewWithTag:num];
    imageV.hidden = NO;
    
    if (_allNumAry.count == 0) {
        [timer invalidate];
        [UIView animateWithDuration:0.5 animations:^{
            self.view.transform = CGAffineTransformMakeScale(0.001, 0.001);
        }];
        [self performSelector:@selector(showFirstView) withObject:nil afterDelay:0.5];
    }
}

//储存1～24
- (void)saveNum
{
    _allNumAry = [[NSMutableArray alloc] init];
    for (int i = 0; i< 25; i ++) {
        [_allNumAry addObject:[NSNumber numberWithInt:i + 1]];
    }
}

//获取随机数
- (NSInteger)getRandNum
{
    NSInteger count = _allNumAry.count;
    NSInteger num = random()%count;
    NSInteger myNum = [_allNumAry[num] integerValue];
    [_allNumAry removeObject:_allNumAry[num]];
    
    return myNum;
}


//展示第一个页面
- (void)showFirstView
{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UIViewController *vc = [story instantiateInitialViewController];
    //
    self.view.window.rootViewController = vc;
    
    //显示动画
    vc.view.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [UIView animateWithDuration:0.5 animations:^{
        vc.view.transform = CGAffineTransformIdentity;
    }];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
