//
//  RootViewController.m
//  OpenGL--Demo
//
//  Created by zhaokaile on 2018/7/25.
//  Copyright © 2018年 none. All rights reserved.
//

#import "RootViewController.h"
#import "ViewController.h"//绘制2D图形
#import "Draw2DImageVC.h"//绘制2D图片
@interface RootViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,copy)NSArray *dataSource;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView *tableview = [[UITableView alloc]initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
    tableview.rowHeight = 44.0;
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
    self.dataSource = @[@"绘制2D图形",@"绘制2D图片"];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        [self.navigationController pushViewController:[ViewController new] animated:YES];
    }else if (indexPath.row == 1){
        [self.navigationController pushViewController:[Draw2DImageVC new] animated:YES];
    }
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
