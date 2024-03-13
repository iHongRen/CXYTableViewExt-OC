//
//  CXYTableSectionItem.m
//  CXYTableViewExt-OC
//
//  Created by cxy on 2024/3/13.
//

#import "CXYTableSectionItem.h"

@implementation CXYTableSectionItem

- (NSMutableArray<CXYTableItem *> *)cellItems {
    if (!_cellItems) {
        _cellItems = NSMutableArray.new;
    }
    return _cellItems;
}

- (BOOL)isEmptyItem {
    if (self.headerItem || self.footerItem || self.cellItems.count>0) {
        return NO;
    }
    return YES;
}

- (BOOL)isEmptyCellItem {
    return self.cellItems.count==0;
}
@end
