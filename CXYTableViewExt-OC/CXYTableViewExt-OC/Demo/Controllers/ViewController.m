//
//  ViewController.m
//  CXYTableViewExt-OC
//
//  Created by cxy on 2024/3/12.
//

#import "ViewController.h"
#import "UITableView+CXYExt.h"

#import "ArrowTextCell.h"

#import "SettingController.h"
#import "NewsController.h"
#import "HeaderFooterController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *bg = UIView.new;
    bg.userInteractionEnabled = NO;
    bg.backgroundColor = UIColor.whiteColor;
    bg.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 100);
    UIView *v = self.navigationController.navigationBar.subviews.firstObject;
    v.clipsToBounds = YES;
    [v insertSubview:bg atIndex:0];
    
    [self bindViewData];
}

- (void)bindViewData {
    __weak typeof(self) weakSelf = self;
    
    [self.tableView.t makeItems:^(CXYTable * _Nonnull make) {
        
        [make addCellClass:ArrowTextCell.class data:@"设置页示例" didSelectBlock:^(id  _Nonnull data, NSIndexPath * _Nonnull indexPath) {
            SettingController *c = [SettingController new];
            c.title = data;
            [weakSelf.navigationController pushViewController:c animated:YES];
        }];
        
        [make addCellClass:ArrowTextCell.class data:@"资讯列表示例" didSelectBlock:^(id  _Nonnull data, NSIndexPath * _Nonnull indexPath) {
            NewsController *c = [NewsController new];
            c.title = data;
            [weakSelf.navigationController pushViewController:c animated:YES];
        }];
        
        [make addCellClass:ArrowTextCell.class data:@"Section Header & Footer 示例" didSelectBlock:^(id  _Nonnull data, NSIndexPath * _Nonnull indexPath) {
            HeaderFooterController *c = [HeaderFooterController new];
            c.title = data;
            [weakSelf.navigationController pushViewController:c animated:YES];
        }];
    }];
    
}


@end
