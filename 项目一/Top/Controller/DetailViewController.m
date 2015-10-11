//
//  DetailViewController.m
//  项目一
//
//  Created by mac on 15/8/6.
//  Copyright (c) 2015年 chenhao. All rights reserved.
//

#import "DetailViewController.h"
#import "BaseTabBarViewController.h"
#import "MovieDetailDatta.h"
#import "MovieDetailTableViewCell.h"
#import "MovieComment.h"
#import "CommentTableViewCell.h"

@interface DetailViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    MovieDetailDatta *_moveData;
    
    NSMutableArray *_commentAry;
    NSMutableArray *_heightAry; //存储单元格高度
    NSMutableArray *_isSelectAry; //储存单元格选中状态
    NSMutableArray *_backSizeWidth;  //储存backView size
    NSMutableArray *_backSizeHeight;
    
    NSIndexPath *_lastIndex;
    
    UITableView *_tab;
    
    BOOL _isOk;

    NSIndexPath *_indexPath;


}


@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"电影详情";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self _loadData];
    
    [self _creatView];
    
}


//读取数据
- (void)_loadData
{
    //电影详情数据
    NSString *path = [[NSBundle mainBundle] pathForResource:@"movie_detail" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSError *err = [[NSError alloc] init];
   NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&err];
    
    _moveData = [[MovieDetailDatta alloc] initWithDic:dic];
    
    //评论数据
    NSString *path2 = [[NSBundle mainBundle] pathForResource:@"movie_comment" ofType:@"json"];
    NSData *data2 = [NSData dataWithContentsOfFile:path2];
    
    NSError *err2 = [[NSError alloc] init];
    NSDictionary *dic2 = [NSJSONSerialization JSONObjectWithData:data2 options:NSJSONReadingMutableLeaves error:&err2];
    
    _heightAry = [[NSMutableArray alloc] init];
    _commentAry = [[NSMutableArray alloc] init];
    _isSelectAry = [[NSMutableArray alloc] init];
    _backSizeWidth = [[NSMutableArray alloc] init];
    _backSizeHeight = [[NSMutableArray alloc] init];
    
    
    for (NSDictionary *d in dic2[@"list"]) {
        MovieComment *comment = [[MovieComment alloc] initWithDic:d];
        [_commentAry addObject:comment];
        [_heightAry addObject:@60];
        [_isSelectAry addObject:@0];
        [_backSizeWidth addObject:@300];
        [_backSizeHeight addObject:@50];
    }
    
    
    
}

//创建视图
- (void)_creatView
{
    _tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWeight, kScreenHeight - 16)];
    _tab.delegate = self;
    _tab.dataSource = self;
    _tab.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main@2x"]];
    
    
    
    
    [self.view addSubview:_tab];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;
    }
    else return _commentAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        MovieDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myTopCell"];
        if (cell == nil)
        {
            NSArray *ary = [[NSBundle mainBundle] loadNibNamed:@"MovieDetailTableViewCell" owner:self options:nil];
            cell = [ary lastObject];
            cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main@2x"]];
        }
        cell.message = _moveData;
        
        //cell.userInteractionEnabled = NO;
        
        return cell;
        
    }
    else
    {
        CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"otherCell"];
        if (cell == nil)
        {
            NSArray *ary = [[NSBundle mainBundle]loadNibNamed:@"CommentTableViewCell" owner:self options:nil];
            cell = [ary lastObject];
            cell.backgroundColor = [UIColor clearColor];

           

        }
        
        
        /*
        MovieComment *comment = _commentAry[indexPath.row];
        NSString *str = comment.content;
        
        CGRect rect = [str boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 10000)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20]}
                                        context:nil];
        
        cell.content.size = CGSizeMake(cell.content.size.width, rect.size.height+10);
        */

        cell.backView.size = CGSizeMake([_backSizeWidth[indexPath.row] floatValue], [_backSizeHeight[indexPath.row] floatValue]);

        cell.message = _commentAry[indexPath.row];
        
        
        return cell;
    }


}

#pragma mark - UITableViewDelegate

//点击单元格
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    if (indexPath == _indexPath) {
//        indexPath =nil;
//    }
//    
//    _indexPath = indexPath;
//    
//    
//    
//    [_tab reloadData];
    
    
    
//    NSLog(@"%li",indexPath.row);
    if (indexPath.section == 0) {
        [_tab reloadData];
    }
    else
    {

        
        CommentTableViewCell *cell = (CommentTableViewCell *)[_tab cellForRowAtIndexPath:indexPath];
        



        NSNumber *is = _isSelectAry[indexPath.row];
        BOOL isSelect = [is boolValue];
        isSelect = !isSelect;

        if (isSelect) {
            [self tableView:_tab didDeselectRowAtIndexPath:_lastIndex];
            MovieComment *comment = _commentAry[indexPath.row];
            NSString *str = comment.content;
            
            CGRect rect = [str boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 10000)
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20]}
                                                context:nil];
            
            cell.backView.size = CGSizeMake(cell.backView.size.width, rect.size.height +40);
            NSNumber *num = [NSNumber numberWithFloat:rect.size.height + 50];
            NSNumber *num1 = [NSNumber numberWithFloat:rect.size.height + 40];
        
            [_backSizeHeight replaceObjectAtIndex:indexPath.row withObject:num1];
            [_heightAry replaceObjectAtIndex:indexPath.row withObject:num];
            
            NSNumber *myNum = [NSNumber numberWithBool:isSelect];
            [_isSelectAry replaceObjectAtIndex:indexPath.row withObject:myNum];
 

            if (!_isOk)
            {
                //[self tableView:_tab didDeselectRowAtIndexPath:_lastIndex];
            }
            
             _lastIndex = indexPath;
        }
        
        else
        {
            [self tableView:_tab didDeselectRowAtIndexPath:_lastIndex];
            
            [_isSelectAry replaceObjectAtIndex:indexPath.row withObject:@0];
            _lastIndex = indexPath;  
        }
        
//        NSIndexSet *set = [NSIndexSet indexSetWithIndex:1];
        
        
        [_tab reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
//        [_tab reloadData];
//        [_tab reloadSections:set withRowAnimation:UITableViewRowAnimationNone];

    }
    
}


//单元格取消选中
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   CommentTableViewCell *cell = (CommentTableViewCell *)[_tab cellForRowAtIndexPath:indexPath];
    cell.backView.size = CGSizeMake(300, 50);
    [_heightAry replaceObjectAtIndex:indexPath.row withObject:@60];
    [_backSizeHeight replaceObjectAtIndex:indexPath.row withObject:@50];
    [_isSelectAry replaceObjectAtIndex:indexPath.row withObject:@0];

}


//组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

//单元格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    if (indexPath.section == 0) {
        return 310;
    }
    else
    {
        if (indexPath == _indexPath) {
            MovieComment *comment = _commentAry[indexPath.row];
            NSString *str = comment.content;
            
            CGRect rect = [str boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 10000)
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20]}
                                            context:nil];
            
            return rect.size.height + 60;
            
        }
        else
        {
            return 60;
        }
    }
    */
    
    if (indexPath.section == 0) {
        return 310;
    }
    else
    {
      return [_heightAry[indexPath.row] floatValue];
    }
     
}











# pragma mark - 隐藏标签栏
- (void)viewWillAppear:(BOOL)animated
{
    BaseTabBarViewController *tab = (BaseTabBarViewController *)self.tabBarController;
    [tab setTabBarHidden:YES animation:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{
    BaseTabBarViewController *tab = (BaseTabBarViewController *)self.tabBarController;
    
    [tab setTabBarHidden:NO animation:NO];
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
