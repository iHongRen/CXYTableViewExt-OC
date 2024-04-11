//
//  HeaderFooterController.m
//  CXYTableViewExt-OC
//
//  Created by cxy on 2024/4/11.
//

#import "HeaderFooterController.h"
#import "Header.h"
#import "Footer.h"
#import "TextCell.h"

@interface HeaderFooterController ()

@end

@implementation HeaderFooterController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self bindViewData];
}

- (void)bindViewData {
    NSArray *sectionList1 = @[@"1",@"2",@"3",@"4",@"5"];
    
    [self.tableView.t makeItems:^(CXYTable * _Nonnull make) {
        [make addHeaderItem:Header.class data:@"我是Header1"];
        [make addCellClass:TextCell.class dataList:sectionList1];
        [make addFooterItem:Footer.class data:@"我是Footer1"];
        
        [make addHeaderItem:Header.class data:@"我是Header2"];
        [make addCellClass:TextCell.class data:@"text-cell"];
        [make addCellClass:TextCell.class data:@"text-cell"];
        [make addFooterItem:Footer.class data:@"我是Footer1"];
    }];
}
@end
