//
//  ViewController.m
//  CXYTableViewExt-OC
//
//  Created by cxy on 2024/3/12.
//

#import "ViewController.h"
#import "UITableView+CXYExt.h"
#import "Cell1.h"
#import "Header1.h"
#import "Footer1.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView.t makeItems:^(CXYTable * _Nonnull make) {
        [make addCellItem:Cell1.class data:@"1"];
        [make addCellItem:Cell1.class data:@"100"];
        [make addHeaderItem:Header1.class data:nil];
        for (int i=0; i<10000; i++) {
            [make addCellItem:Cell1.class data:@(i).stringValue didSelectBlock:^(id  _Nonnull data, NSIndexPath * _Nonnull indexPath) {
                NSLog(@"%@",data);
            }];
        }
       
        [make addCellItem:Cell1.class data:@"10000"];
        [make addFooterItem:Footer1.class data:nil];
    }];
}


@end
