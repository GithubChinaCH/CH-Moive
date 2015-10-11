//
//  MovieViewController.m
//  项目一
//
//  Created by mac on 15/8/3.
//  Copyright (c) 2015年 chenhao. All rights reserved.
//

#import "MovieViewController.h"
#import "BaseTabBarViewController.h"
#import "Movie.h"
#import "MoveTableViewCell.h"
#import "PostCollection.h"
#import "HeadList.h"

@interface MovieViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIButton *_rightButton;  //导航栏右上角按钮
    PostCollection *_postView;        //海报视图
    UITableView *_listView;    // 电影列表视图
    //__weak IBOutlet UITableView *_listView;
    NSMutableArray *_movieData;   //存储电影信息数组
    

    UICollectionView *_colletion;
    UICollectionView *_colletion1;
    UIView *_detailView;
    CGFloat _cWidth;
    BOOL _isReturn;
    
    
    HeadList *_headListView;
    UIView *_headView;     //头部视图所有视图的父视图
    UIButton *_button;         //
    UIButton *_lightLeftButton; //左灯光
    UIButton *_lightRightButton; //右灯光
    
    UIView *_coverView;       //覆盖视图
    
    UILabel *_nameLabel;
}

@end

@implementation MovieViewController
//移除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"电影";
    
    
    self.view.backgroundColor = [UIColor clearColor];
    //读取数据
    [self _loadData];
    
    [self _creatBUttonItem];
    [self _creatViews];
   // NSLog(@"%f",self.view.frame.size.height);

    //创建头部视图
    [self _creatTopView];
    
    //设置导航栏的透明
    self.navigationController.navigationBar.translucent = YES;

   // BaseTabBarViewController *navi = (BaseTabBarViewController *)self.navigationController;
    
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    
    //self.navigationController.navigationBarHidden = YES;

    //创建电影名label
    [self _creatLabel];
    
   // 改变电影名  滑动中间视图 改变 顶部视图 通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeName) name:@"changeName" object:nil];
   // 头部列表滑动 改变 中间视图
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(footViewChange) name:@"headControlFoot" object:nil];

    /*
    //KVO
    [_headListView addObserver:self forKeyPath:@"floatNUm" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    [_postView addObserver:self forKeyPath:@"floatNUm" options:NSKeyValueObservingOptionNew context:nil];
    
    */
}


/*
#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"%@",change);

    NSNumber *value = change [@"new"];
    NSInteger num = [value integerValue];
    NSIndexPath *indexpath = [NSIndexPath indexPathForItem:num inSection:0];
    
    if (object == _headListView && _postView.floatNUm != num) {
        [_postView scrollToItemAtIndexPath:indexpath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        _postView.floatNUm = num;
    }
    else if (object == _postView && _headListView.floatNUm !=num)
    {
        [_headListView scrollToItemAtIndexPath:indexpath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        _headListView.floatNUm = num;
    }
    
    
    
}

*/



#pragma mark - 通知方法

//上面的视图滑动 改变海报视图
- (void)footViewChange
{
    CGFloat scale = (kScreenWeight * 0.7 + 10) / 90;
    CGPoint point = CGPointMake(_headListView.contentOffset.x * scale, _postView.contentOffset.y);

    _postView.contentOffset = point;
    
//    [_postView setContentOffset:point animated:YES];
    

}

//海报视图滑动改变 顶部视图以及名字
- (void)changeName
{
    _nameLabel.text = _postView.movieName;
    
    CGFloat scale = (kScreenWeight * 0.7 + 10) / 90;
    CGPoint point = CGPointMake(_postView.contentOffset.x / scale, _headListView.contentOffset.y);
    _headListView.contentOffset = point;
    
}

#pragma mark - 数据读取
- (void)_loadData
{
    //1 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"us_box" ofType:@"json"];
    //2 读取文件
    NSData *data = [NSData dataWithContentsOfFile:path];
    //3 解析文件
    NSError *error = [[NSError alloc] init];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data
                                    options:NSJSONReadingMutableLeaves
                                      error:&error];

    _movieData = [[NSMutableArray alloc] init];
    for (NSDictionary *d in dic[@"subjects"]) {

        Movie *movie = [[Movie alloc] initWithDic:d];
        //[_movieData addObject:d];
        [_movieData addObject:movie];
    }

    
    
}


#pragma mark - 创建中间视图
- (void)_creatViews
{
    //查创建海报视图
    _postView = [[PostCollection alloc] initWithFrame:CGRectMake(0, 0, kScreenWeight, kScreenHeight-49)
                                             itemSize:CGSizeMake(kScreenWeight* 0.7, (kScreenHeight - 49)* 0.7)  sectionInset:UIEdgeInsetsMake(40, kScreenWeight * 0.15, 0, kScreenWeight* 0.15)];
    //_postView.backgroundColor = [UIColor yellowColor];
    _postView.hidden = NO;
    _postView.movieData = _movieData;
    [self.view addSubview:_postView];
   // [self _creatPostView];
    
    
    //创建列表视图
    
    _listView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWeight, kScreenHeight - 49) style:UITableViewStylePlain];
    _listView.hidden = YES;
    _listView.dataSource = self;
    _listView.delegate = self;
    _listView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_listView];
    _listView.rowHeight = 120;
    
    _listView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWeight, 64)];
    
    _listView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main@2x"]];
    
}

//创建电影名字label
- (void)_creatLabel
{
    _nameLabel = [[UILabel alloc] init];
    
    _nameLabel.font = [UIFont boldSystemFontOfSize:30];
    _nameLabel.size = CGSizeMake(200, 40);
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.center = CGPointMake(kScreenWeight/2, 590);
    NSLog(@"%lf",_postView.bottom - 20);
    _nameLabel.numberOfLines = 0;
    //_nameLabel.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_nameLabel];
    
    _nameLabel.hidden = NO;
}


#pragma mark - tableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _movieData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    MoveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if (cell == nil) {
        NSArray *ary = [[NSBundle mainBundle] loadNibNamed:@"MoveTableViewCell" owner:nil options:nil];
        cell = [ary lastObject];
        cell.backgroundColor = [UIColor clearColor];
        
    }
    
    cell.message = _movieData[indexPath.row];
    
    return cell;
}


#pragma  mark － 创建按钮
- (void)_creatBUttonItem
{
    //创建按钮
    _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightButton.frame = CGRectMake(0, 0, 49, 25);
    [_rightButton setBackgroundImage:[UIImage imageNamed:@"exchange_bg_home@2x"] forState:UIControlStateNormal];
    [_rightButton setImage:[UIImage imageNamed:@"list_home"] forState:UIControlStateSelected];
    [_rightButton setImage:[UIImage imageNamed:@"poster_home"] forState:UIControlStateNormal];
    
    //给按钮添加点击事件
    [_rightButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //包装 按钮
    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc] initWithCustomView:_rightButton];
    //将按钮添加到导航项中
    self.navigationItem.rightBarButtonItem = rightitem;
    
    
    
    
}

//按钮点击事件
- (void)buttonAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
    _coverView.hidden = YES;
    [self upHome];
    //根据 按钮的选中状态来设置旋转方向
    UIViewAnimationOptions option = sender.selected ? UIViewAnimationOptionTransitionFlipFromRight:UIViewAnimationOptionTransitionFlipFromLeft;
    
    
    //给某个视图加动画
    NSArray *ary = @[sender,self.view];
    [self transView:ary
         animations:^{
             
             _headView.hidden = sender.selected;
             _listView.hidden = !sender.selected;
             _postView.hidden = sender.selected;
             _nameLabel.hidden = sender.selected;
             

    }
            options:option];
    
    
    /*
    [UIView transitionWithView:sender              //需要添加动画的视图
                      duration:0.3                 //动画持续时间
                       options:option              //翻转方向
                    animations:^{
                        sender.selected = !sender.selected;
                    }
                    completion:nil];
   

    [UIView transitionWithView:self.view              //需要添加动画的视图
                      duration:0.3                 //动画持续时间
                       options:option              //翻转方向
                    animations:^{

                        _listView.hidden = sender.selected;
                        _postView.hidden = !sender.selected;

                    }
                    completion:nil];
    */
   
}

//自定义多视图旋转方法 将按钮和海报视图存入数组
- (void)transView:(NSArray *)ary animations:(void (^)(void))animations options:(UIViewAnimationOptions)options
{
    for (int i = 0; i<ary.count; i++) {
        [UIView transitionWithView:ary[i] duration:0.3 options:options animations:animations completion:nil];
    }
    
}




#pragma mark - 创建头部视图
- (void)_creatTopView
{
    //遮盖视图
    _coverView = [[UIView alloc] initWithFrame:self.view.bounds];
    _coverView.backgroundColor = [UIColor blackColor];
    _coverView.alpha = 0.4;
    [self.view addSubview:_coverView];
    _coverView.hidden = YES;
    
    //点击覆盖视图 手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [tap addTarget:self action:@selector(upHome)];
    [_coverView addGestureRecognizer:tap];
    
    //手指滑动 覆盖视图出现
    //手指下滑
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(downHome)];
    swipe.direction = UISwipeGestureRecognizerDirectionDown;
    [_postView addGestureRecognizer:swipe];
    //手指上滑
    UISwipeGestureRecognizer *swipe1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(upHome)];
    swipe1.direction = UISwipeGestureRecognizerDirectionUp;
    [_coverView addGestureRecognizer:swipe1];

    
    
    
   //创建父视图
    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, -45, kScreenWeight, 130)];
    [self.view addSubview:_headView];
    _headView.hidden = NO;
    //_headView.backgroundColor = [UIColor orangeColor];
    
    //背景视图
    UIImageView *BGimage = [[UIImageView alloc] initWithFrame:_headView.bounds];
    UIImage *image = [UIImage imageNamed:@"indexBG_home@2x"];
    image = [image stretchableImageWithLeftCapWidth:0 topCapHeight:3];
    
    BGimage.image = image;
    [_headView addSubview:BGimage];
    
    //头部列表视图
    _headListView = [[HeadList alloc] initWithFrame:CGRectMake(0, 0, kScreenWeight, 120)];
    _headListView.backgroundColor = [UIColor clearColor];
    [_headView addSubview:_headListView];
    [_headListView setAry:_movieData];
    
    //创建上下按钮
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.size = CGSizeMake(60, 20);
    _button.center = CGPointMake(kScreenWeight/2, 120);
    //button.backgroundColor = [UIColor redColor];
    [_headView addSubview:_button];
    [_button setImage:[UIImage imageNamed:@"down_home@2x"] forState:UIControlStateNormal];
    [_button setImage:[UIImage imageNamed:@"up_home@2x"] forState:UIControlStateSelected];
    
    [_button addTarget:self action:@selector(upDownButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //创建灯光按钮
    _lightLeftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _lightLeftButton.frame = CGRectMake(kScreenWeight/2 - 130, 0, 80, 60);
    //lightLeftButton.backgroundColor = [UIColor redColor];
    [_headView addSubview:_lightLeftButton];
    [_lightLeftButton setImage:[UIImage imageNamed:@"light@2x"] forState:UIControlStateNormal];
    
    _lightRightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _lightRightButton.frame = CGRectMake(kScreenWeight/2 +50, 0, 80, 60);
    [_headView addSubview:_lightRightButton];
    [_lightRightButton setImage:[UIImage imageNamed:@"light@2x"] forState:UIControlStateNormal];
    
    
    
//    [self.view addSubview:_coverView];
}






//按钮点击事件 ------------------------
- (void)upDownButtonAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
    (sender.selected)? [self downHome]:[self upHome];
}

//视图向上移动
- (void)upHome
{
    [UIView animateWithDuration:0.3 animations:^{
        _headView.top = -45;
        _lightLeftButton.hidden = YES;
        _lightRightButton.hidden = YES;
        _coverView.hidden = YES;
        _button.selected = NO;
    }];
   
}

//视图向下移动
- (void)downHome
{
    [UIView animateWithDuration:0.3 animations:^{
        _headView.top = 64;
        _lightRightButton.hidden = NO;
        _lightLeftButton.hidden = NO;
        _coverView.hidden = NO;
        _button.selected = YES;
    }];
}
//-----------------------------按钮点击事件结束--------------















/*----------------------------------------------
#pragma mark - 海报视图内容

- (void)_creatPostView
{
    _cWidth = 2*(kScreenWeight -20)/3;
    CGFloat cHeight = _postView.frame.size.height - 26-50;
    
    //-----------------HHHHHHHHH---------------------
    UICollectionViewFlowLayout *flow1 = [[UICollectionViewFlowLayout alloc] init];
    flow1.minimumInteritemSpacing = 10;
    flow1.itemSize = CGSizeMake(_cWidth, cHeight);
    flow1.sectionInset = UIEdgeInsetsMake(26, _cWidth/4 + 10, 50, _cWidth/4);
    flow1.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _colletion1 = [[UICollectionView alloc] initWithFrame:_postView.bounds collectionViewLayout:flow1];
    _colletion1.dataSource = self;
    _colletion1.delegate = self;
    [_postView addSubview:_colletion1];
    [_colletion1 registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"backCell"];
    
    
    
    //布局对象
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.minimumInteritemSpacing = 10;
    flow.itemSize = CGSizeMake(_cWidth, cHeight);
    flow.sectionInset = UIEdgeInsetsMake(0, 0, 0, 10);
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _colletion = [[UICollectionView alloc] initWithFrame:CGRectMake(_cWidth/4+10, 26, _cWidth + 10 , cHeight) collectionViewLayout:flow];
    //_colletion.clipsToBounds = NO;
    _colletion.pagingEnabled = YES;
    _colletion.dataSource = self;
    _colletion.delegate = self;
    [_postView addSubview:_colletion];
    
    _colletion.backgroundColor = [UIColor redColor];
    
    [_colletion registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"postCell"];
    
    
    
}



#pragma mark - datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _movieData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == _colletion) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"postCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor greenColor];
        NSLog(@"%lf",cell.size.width);
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:cell.bounds];
        Movie *movie = _movieData[indexPath.row];
        
        [imageV sd_setImageWithURL:movie.images[@"large"]];
        
        cell.backgroundView = imageV;
        _detailView = [[UIView alloc] initWithFrame:cell.bounds];
        _detailView.backgroundColor = [UIColor yellowColor];
        [_colletion addSubview:_detailView];
        _detailView.hidden = YES;
        
        
        //cell.hidden = YES;
        return cell;
    }
    else
    {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"backCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor greenColor];
        NSLog(@"%lf",cell.size.width);
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:cell.bounds];
        Movie *movie = _movieData[indexPath.row];
        
        [imageV sd_setImageWithURL:movie.images[@"large"]];
        
        cell.backgroundView = imageV;
        return cell;
    }
    
}


#pragma mark - delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == _colletion1)
    {
        [_colletion setContentOffset:CGPointMake(indexPath.row * (_cWidth+10) , 0) animated:YES];
    }
    else
    {
        _isReturn = !_isReturn;
        UICollectionViewCell *cell = [_colletion cellForItemAtIndexPath:indexPath];
//        cell.selected = !cell.selected;
        [UIView transitionWithView:_colletion duration:1 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            cell.hidden = _isReturn;
            _detailView.hidden = !_isReturn;
            NSLog(@"  %i",cell.selected);
        } completion:nil];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _colletion1.contentOffset = _colletion.contentOffset;
}


- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%li",indexPath.row);
}

----------------------------------------*/



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
