//
//  CXYTableDataSource.m
//  CXYTableViewExt-OC
//
//  Created by cxy on 2024/3/12.
//

#import "CXYTableDataSource.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UITableView+CXYExt.h"


@interface MRTableDataSource : NSObject

@end

@implementation CXYTableDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [tableView.t numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [tableView.t numberOfCellItemsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView.t reusableCellAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView.t heightForCellAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [tableView.t heightForHeaderInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return [tableView.t heightForFooterInSection:section];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [tableView.t reusableHeaderInSection:section];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [tableView.t reusableFooterInSection:section];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.didSelect) {
        self.didSelect(tableView, indexPath);
    }
    
    CXYTableItem *item = [tableView.t cellItemAtIndexPath:indexPath];
    if (item && item.itemBlock) {
        item.itemBlock(item.data, indexPath);
    }
}

@end
