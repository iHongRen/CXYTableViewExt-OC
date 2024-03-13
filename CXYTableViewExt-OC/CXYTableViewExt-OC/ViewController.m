//
//  ViewController.m
//  CXYTableViewExt-OC
//
//  Created by cxy on 2024/3/12.
//

#import "ViewController.h"
#import "UITableView+CXYExt.h"
#import "Cell1.h"
#import "Cell2.h"

#import "Header1.h"
#import "Footer1.h"

@interface ViewController ()<Cell2Delegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) BOOL switchValue;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self bindViewData];
}

- (void)bindViewData {
    // You can see CXYTable.h, more methods.
    
    [self.tableView.t makeItems:^(CXYTable * _Nonnull make) {
     
        [make addHeaderItem:Header1.class data:nil];
        for (int i=0; i<5; i++) {
            [make addCellItem:Cell1.class data:@(i).stringValue didSelectBlock:^(id  _Nonnull data, NSIndexPath * _Nonnull indexPath) {
                NSLog(@"%@",data);
            }];
        }
        [make addFooterItem:Footer1.class data:nil];

        [make addCellItem:Cell2.class data:@(self.switchValue) delegate:self];
    }];
}

- (void)Cell2DelegateSwitchChanged:(BOOL)isOn indexPath:(NSIndexPath*)indexPath {
    self.switchValue = isOn;
    
    [self.tableView.t updateItems:^(CXYTable * _Nonnull make, UITableView * _Nonnull tableView) {
        [self.tableView.t insertCellItem:Cell1.class data:@"00" indexPath:indexPath];
        [tableView reloadData];
    }];
    
    
//    [self bindViewData];
    
//    [self.tableView.t updateItems:^(CXYTable * _Nonnull make, UITableView * _Nonnull tableView) {
//        [make cellItemAtIndexPath:indexPath].data = @(self.switchValue);
//        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationNone)];
//    }];
}

@end
