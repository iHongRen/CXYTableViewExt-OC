//
//  SettingController.m
//  CXYTableViewExt-OC
//
//  Created by cxy on 2024/3/20.
//

#import "SettingController.h"
#import "HeadTitleCell.h"
#import "SwitchCell.h"
#import "ArrowTextCell.h"

#import "UITableView+CXYExt.h"
#import "SwitchModel.h"

@interface SettingController ()<SwitchCellDelegate>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self.view addSubview:self.tableView];
    [self bindViewData];
    

   
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:(UITableViewStylePlain)];
        _tableView.tableFooterView = UIView.new;
    }
    return _tableView;
}

- (void)bindViewData {
    
    [self.tableView.t makeItems:^(CXYTable * _Nonnull make) {
        [make addCellClass:HeadTitleCell.class data:@"通知"];
        [make addCellClass:SwitchCell.class data:[SwitchModel title:@"系统消息通知" isOn:YES] delegate:self];
        [make addCellClass:SwitchCell.class data:[SwitchModel title:@"通知显示消息详情" isOn:NO] delegate:self];
        [make addCellClass:SwitchCell.class data:[SwitchModel title:@"振动" isOn:YES] delegate:self];

        [make addCellClass:HeadTitleCell.class data:@"提示音"];
        [make addCellClass:ArrowTextCell.class data:@"消息提示音" didSelectBlock:^(id  _Nonnull data, NSIndexPath * _Nonnull indexPath) {
            NSLog(@"%@",data);
        }];
        [make addCellClass:ArrowTextCell.class data:@"来电铃声" didSelectBlock:^(id  _Nonnull data, NSIndexPath * _Nonnull indexPath) {
            NSLog(@"%@",data);
        }];
    }];
}

#pragma mark - SwitchCellDelegate
- (void)switchCellDelegateSwitchChanged:(SwitchModel*)data {
    data.isOn = !data.isOn;
    NSLog(@"%@ %@",data.title, @(data.isOn));
}


@end
