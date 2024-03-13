//
//  CXYTableSectionItem.h
//  CXYTableViewExt-OC
//
//  Created by cxy on 2024/3/13.
//

#import <Foundation/Foundation.h>
#import "CXYTableItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface CXYTableSectionItem : NSObject

@property (nonatomic, strong, nullable) CXYTableItem *headerItem;
@property (nonatomic, strong, nullable) CXYTableItem *footerItem;
@property (nonatomic, strong, nullable) NSMutableArray<CXYTableItem *> *cellItems;

- (BOOL)isEmptyItem;
- (BOOL)isEmptyCellItem;
@end

NS_ASSUME_NONNULL_END
