//
//  NewsController.m
//  CXYTableViewExt-OC
//
//  Created by cxy on 2024/3/20.
//

#import "NewsController.h"
#import "NewsCell.h"
#import "MJRefresh.h"
#import "NewsModel.h"

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
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestPage:1];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestPage:weakSelf.page+1];
    }];
}

- (void)requestPage:(NSInteger)page {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSMutableArray *res = @[].mutableCopy;
        for (NSInteger i=0; i<10; i++) {
            NewsModel *model = [NewsModel new];
            model.title = @"新闻标题";
            model.desc = @"新闻摘要";
            model.img = @"cover";
            [res addObject:model];
        }
       
        if (page==1) {
            self.list = res;
        } else {
            self.list = [self.list arrayByAddingObjectsFromArray:res];
        }
        self.page = page;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NewsModel *model = [self.tableView.t cellItemDataAtIndexPath:indexPath];
    NSLog(@"%@ %zd", model.title, indexPath.row);
}
@end
