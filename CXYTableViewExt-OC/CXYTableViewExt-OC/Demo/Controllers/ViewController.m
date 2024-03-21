//
//  ViewController.m
//  CXYTableViewExt-OC
//
//  Created by cxy on 2024/3/12.
//

#import "ViewController.h"
#import "UITableView+CXYExt.h"

#import "ArrowTextCell.h"

#import "Cell1.h"
#import "SwitchCell.h"

#import "Header1.h"
#import "Footer1.h"

#import "SettingController.h"
#import "HomeController.h"
#import "NewsController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self bindViewData];
}

- (void)bindViewData {
    
    __weak typeof(self) weakSelf = self;

    [self.tableView.t makeItems:^(CXYTable * _Nonnull make) {
        
        [make addCellItem:ArrowTextCell.class data:@"设置页示例" didSelectBlock:^(id  _Nonnull data, NSIndexPath * _Nonnull indexPath) {
            SettingController *c = [SettingController new];
            [weakSelf.navigationController pushViewController:c animated:YES];
        }];
        
        [make addCellItem:ArrowTextCell.class data:@"资讯列表示例" didSelectBlock:^(id  _Nonnull data, NSIndexPath * _Nonnull indexPath) {
            NewsController *c = [NewsController new];
            [weakSelf.navigationController pushViewController:c animated:YES];
        }];
        
        [make addCellItem:ArrowTextCell.class data:@"多cell首页页示例" didSelectBlock:^(id  _Nonnull data, NSIndexPath * _Nonnull indexPath) {
            HomeController *c = [HomeController new];
            [weakSelf.navigationController pushViewController:c animated:YES];
        }];
    }];
    
}


@end
