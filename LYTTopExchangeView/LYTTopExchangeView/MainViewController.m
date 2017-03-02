//
//  MainViewController.m
//  LYTTopExchangeView
//
//  Created by liuyuntian on 17/3/1.
//  Copyright © 2017年 333. All rights reserved.
//

#import "MainViewController.h"
#import "LYTTopExhangeView.h"

@interface MainViewController ()
<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic,strong) LYTTopExhangeView *topView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStylePlain target:self action:@selector(refreshAction:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    
    LYTTopExhangeView *topView = [[LYTTopExhangeView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    topView.dataArray = @[@"favorite_bgView",@"favorite_bgView",@"favorite_bgView",@"favorite_bgView"];
    self.topView = topView;
    tableView.tableHeaderView = topView;
}

- (void)refreshAction:(id)send
{
    self.topView.dataArray = @[@"favorite_bgView",@"favorite_bgView"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"table"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"table"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld",indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
