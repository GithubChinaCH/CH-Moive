//
//  CinemaViewController.m
//  项目一
//
//  Created by mac on 15/8/3.
//  Copyright (c) 2015年 chenhao. All rights reserved.
//

#import "CinemaViewController.h"
#import "CinemaList.h"
#import "CinemaTableViewCell.h"

@interface CinemaViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_districtAry;
    
    NSMutableDictionary *_cinemaDic;     //存储每一组 电影院 的字典
    NSMutableArray *_cinemaAry;          //存储每一组电影院
    
    NSMutableArray *_isSelect;            //判断是否被选中
    
    UITableView *_tab;
    
    UITextField *_file;
}



@end

@implementation CinemaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"影院";
    
    [self _loadData];
    [self _creatView];

//    _tab.tableHeaderView = [[UIView alloc] init];
//    _tab.tableHeaderView.frame = CGRectMake(0, 0, kScreenWeight, 100);
//    _tab.tableHeaderView.backgroundColor = [UIColor whiteColor];
    
}


//数据读取
- (void)_loadData
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"district_list" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSError *err = [[NSError alloc] init];
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&err];
    _districtAry = [[NSMutableArray alloc] initWithArray:dic[@"districtList"]];
    _isSelect = [[NSMutableArray alloc] init];
    for (int i = 0; i < _districtAry.count; i++) {
        _cinemaAry = [[NSMutableArray alloc] init];
        _cinemaDic = [[NSMutableDictionary alloc] initWithDictionary:_districtAry[i]];
        [_cinemaDic setObject:_cinemaAry forKey:@"cList"];
        
        [_districtAry replaceObjectAtIndex:i withObject:_cinemaDic];
        [_isSelect addObject:@0];
    }
    
    
    NSString *path2 = [[NSBundle mainBundle] pathForResource:@"cinema_list" ofType:@"json"];
    NSData *data2 = [NSData dataWithContentsOfFile:path2];
    NSError *err2 = [[NSError alloc] init];
    
    NSDictionary *dic2 = [NSJSONSerialization JSONObjectWithData:data2 options:NSJSONReadingMutableLeaves error:&err2];
    
    for (NSDictionary *d in dic2[@"cinemaList"]) {
        CinemaList *list = [[CinemaList alloc] initWithDic:d];
        
        for (int i = 0; i < _districtAry.count; i++)
        {
            NSString *str = _districtAry[i][@"id"];
            if ([list.districtId isEqualToString:str])
            {
                _cinemaAry = _districtAry[i][@"cList"];
                [_cinemaAry addObject:list];
            }
            
        }
    }

    NSLog(@"%@",_districtAry);
}


//创建视图
- (void)_creatView
{
    _tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWeight, kScreenHeight - 64) style:UITableViewStyleGrouped];
    _tab.backgroundColor = [UIColor whiteColor];
    _tab.dataSource = self;
    _tab.delegate = self;
    _tab.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main@2x"]];
    
    
    
    [self.view addSubview:_tab];
}

#pragma mark - dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSLog(@"%@",_districtAry);
//    if (section+1 == 19) {
//        section = -1;
//    }
//    NSLog(@"%li",section);
//    NSLog(@"section %li %li",ary.count,section);
    
    NSInteger a;
    if ([_isSelect[section] boolValue])
    {
        NSArray *ary = _districtAry[section][@"cList"];
        a = ary.count;
    }
    else
    {
        a = 0;
    }
    
    
    return a;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *ary = _districtAry[indexPath.section][@"cList"];
    CinemaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addressCell"];
    if (cell == nil) {
        NSArray *ary = [[NSBundle mainBundle] loadNibNamed:@"CinemaTableViewCell" owner:self options:nil];
        cell = [ary lastObject];
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.message = ary[indexPath.row];
    
    if (indexPath.section+1==_districtAry.count && indexPath.row +1 == ary.count) {
        [self _loadData];
    }
    return cell;
}



#pragma mark - delegete
//单元格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
//单元格组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _districtAry.count;
}
//单元格组头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}
//单元格组尾高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

//创建组头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, kScreenWeight, 44);
    [button setBackgroundImage:[UIImage imageNamed:@"hotMovieBottomImage@2x"] forState:UIControlStateNormal];
    NSString *str = _districtAry[section][@"name"];
    [button setTitle:str forState:UIControlStateNormal];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    button.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    button.tag = 100+section;
    
    return button;
}
//按钮事件
- (void)buttonAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if ([_isSelect[sender.tag - 100] boolValue]) {
        [_isSelect replaceObjectAtIndex:sender.tag - 100 withObject:@0];

    }
    else
    {
        [_isSelect replaceObjectAtIndex:sender.tag - 100 withObject:@1];
       
    }
    
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:sender.tag - 100];
    [_tab reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
    
//    [_tab reloadData];
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
