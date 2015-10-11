//
//  MoreViewController.m
//  项目一
//
//  Created by mac on 15/8/3.
//  Copyright (c) 2015年 chenhao. All rights reserved.
//

#import "MoreViewController.h"

typedef void (^MyBlock)(void);

@interface MoreViewController ()<UIAlertViewDelegate>
{
    UILabel *_label;
    UIAlertView *_aler;
    MyBlock _homePathBlock;
    NSString *_homePath;   //沙盒 路径
    NSArray *_subFilePath; //存储文件路径名数组
    
    NSArray *_flieNames;  //文件夹中文件名
}
@property (weak, nonatomic) IBOutlet UILabel *clearLabel;


@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.font = [UIFont boldSystemFontOfSize:30];
    _label.textColor = [UIColor whiteColor];
    
    self.navigationItem.titleView  = _label;
    _label.text = @"更多";
    
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main@2x"]];
    
    //创建警告视图
    [self _creatAler];
    
    //创建沙河路径
    [self _creatHomePath];
    
    
    
    
    
}

//创建沙河路径
- (void)_creatHomePath
{
    // /Library/Caches/com.hackemist.SDWebImageCache.default  SDWebImageCache 框架的的缓存文件夹
    // /Library/Caches/com.huiwenjiaoyu.--- 系统框架的缓存文件夹 webView
    
    //获取当前应用程序的沙盒路径
    _homePath = NSHomeDirectory();
    
    
    _subFilePath = @[@"/Library/Caches/com.hackemist.SDWebImageCache.default",@"/Library/Caches/com.huiwenjiaoyu.---"];
}


//创建警告视图
- (void)_creatAler
{
    _aler = [[UIAlertView alloc] initWithTitle:@"清除缓存" message:@"是否清除缓存"delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
}


//计算缓存
- (void)countNum
{
    
    
    long long fileSize = 0;
    for (NSString *str in _subFilePath) {
        //获取SDWebImageCache的缓存文件夹路径
        NSString *subFlie = [_homePath stringByAppendingPathComponent:str];
        //创建一个文件管理器 单例
        NSFileManager *fileManager = [NSFileManager defaultManager];//文件管理器
        
        //获取某个路径下的所有文件名
        _flieNames = [fileManager subpathsOfDirectoryAtPath:subFlie error:nil];
        
        //遍历文件夹
        
        for (NSString *fileName in _flieNames) {
            //拼接文件路径
            NSString *file = [subFlie stringByAppendingPathComponent:fileName];
            
            //根据文件路径 获取文件的相关信息
            NSDictionary *dic = [fileManager attributesOfItemAtPath:file error:nil];
            
            fileSize += [dic[NSFileSize] longLongValue];
        }
        
    }
    CGFloat num = (CGFloat)fileSize / 1024 /1024;
    _clearLabel.text = [NSString stringWithFormat:@"%.2fMB",num];

}

- (void)clearNum
{
    //内存清理
    
//    [self _creatHomePath];
    for (NSString *str in _subFilePath) {
        //获取SDWebImageCache的缓存文件夹路径
        NSString *subFlie = [_homePath stringByAppendingPathComponent:str];
        //创建一个文件管理器 单例
        NSFileManager *fileManager = [NSFileManager defaultManager];//文件管理器
        
        //获取某个路径下的所有文件名
        NSArray *flieNames = [fileManager subpathsOfDirectoryAtPath:subFlie error:nil];
        
        //遍历文件夹
        
        for (NSString *fileName in flieNames)
        {
            //拼接文件路径
            NSString *file = [subFlie stringByAppendingPathComponent:fileName];
            
            //删除文件
            [fileManager removeItemAtPath:file error:nil];
            
        }
        
    }
    _clearLabel.text = @"清理中...";
    
    [self performSelector:@selector(countNum) withObject:nil afterDelay:1];
    
}



//点击清除缓存单元格
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%li",indexPath.row);
    if (indexPath.row == 0)
    {
        [_aler show];
    }
}


//警告视图点击事件
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [self clearNum];
    }
}



//当视图将要显示 计算缓存文件大小
- (void)viewWillAppear:(BOOL)animated
{
    [self countNum];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.view removeFromSuperview];
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
