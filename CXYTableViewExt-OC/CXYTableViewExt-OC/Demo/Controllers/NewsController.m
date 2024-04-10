//
//  NewsController.m
//  CXYTableViewExt-OC
//
//  Created by cxy on 2024/3/20.
//

#import "NewsController.h"
#import "NewsCell.h"
#import "MJRefresh.h"

@interface NewsController ()

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, copy) NSArray *list;
@end

@implementation NewsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self configTable];
    [self requestPage:1];
}

- (void)configTable {
    MJWeakSelf
    self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        [weakSelf requestPage:1];
    }];
    
    self.tableView.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
        [weakSelf requestPage:weakSelf.page+1];
    }];
}

- (void)requestPage:(NSInteger)page {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSArray *res = @[@0,@0,@0,@0,@0];
        if (page==1) {
            self.list = res;
        } else {
            self.list = [self.list arrayByAddingObjectsFromArray:res];
        }
        [self endRefreshing];
        [self bindViewData];
    });
}

- (void)endRefreshing {
    if (self.tableView.mj_header.isRefreshing) {
        [self.tableView.mj_header endRefreshing];
    }
    if (self.tableView.mj_footer.isRefreshing) {
        [self.tableView.mj_footer endRefreshing];
    }
}

- (void)bindViewData {
    [self.tableView.t makeItems:^(CXYTable * _Nonnull make) {
        [make addCellClass:NewsCell.class dataList:self.list];
    }];
}

@end
