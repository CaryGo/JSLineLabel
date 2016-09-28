//
//  BaseTableViewController.m
//  JSLineLabel
//
//  Created by Cary on 16/9/28.
//  Copyright © 2016年 Cary. All rights reserved.
//

#import "BaseTableViewController.h"

#import "AttributeTableVC.h"
#import "LineAttributeTableVC.h"

@interface BaseTableViewController ()

@property(nonatomic, strong)NSMutableArray *dataSource;

@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = [NSMutableArray arrayWithObjects:
                       @"AttributeLabel",
                       @"LineAttributeLabel",
                       @"LineHeight",
                       nil];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            AttributeTableVC * vc = [[AttributeTableVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            LineAttributeTableVC *vc = [[LineAttributeTableVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            
        }
            break;
            
        default:
            break;
    }
}

@end
