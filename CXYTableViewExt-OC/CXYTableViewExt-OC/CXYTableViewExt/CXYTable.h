//
//  CXYTable.h
//  CXYTableViewExt-OC
//
//  Created by cxy on 2024/3/13.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CXYTableItem.h"
#import "CXYTableItemProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface CXYTable : NSObject

- (instancetype)initWithTableView:(UITableView*)tableView;

// 可使用自定义的
- (void)configDataSource:(id<UITableViewDelegate,UITableViewDataSource>)dataSource;

// 默认的数据源和代理
- (void)useDefaultDataSource;
// 使用默认的数据源和代理，cell被点击时调用
- (void)defaultDidSelectCell:(void(^)(UITableView *tableView, NSIndexPath *indexPath))didSelect;

// 配置item
- (void)makeItems:(void(NS_NOESCAPE ^)(CXYTable *make))block;
- (void)updateItems:(void(NS_NOESCAPE ^)(CXYTable *make, UITableView *tableView))block;
- (void)removeItems:(void(NS_NOESCAPE ^)(CXYTable *make, UITableView *tableView))block;


/**
 添加item
 */
- (void)addHeaderItem:(Class)headerClass data:(id _Nullable)data delegate:(id _Nullable)delegate;
- (void)addHeaderItem:(Class)headerClass data:(id _Nullable)data;

- (void)addCellClass:(Class)cellClass data:(id _Nullable)data;
- (void)addCellClass:(Class)cellClass delegate:(id _Nullable)delegate;
- (void)addCellClass:(Class)cellClass data:(id _Nullable)data delegate:(id _Nullable)delegate;
- (void)addCellClass:(Class)cellClass didSelectBlock:(CXYTableItemBlock _Nullable)block;
- (void)addCellClass:(Class)cellClass data:(id _Nullable)data didSelectBlock:(CXYTableItemBlock _Nullable)block;

- (void)addCellClass:(Class)cellClass dataList:(NSArray *)dataList;
- (void)addCellClass:(Class)cellClass dataList:(NSArray *)dataList delegate:(id _Nullable)delegate;
- (void)addCellClass:(Class)cellClass dataList:(NSArray *)dataList didSelectBlock:(CXYTableItemBlock _Nullable)block;

- (void)addFooterItem:(Class)footerClass data:(id _Nullable)data delegate:(id _Nullable)delegate;
- (void)addFooterItem:(Class)footerClass data:(id _Nullable)data;

/**
 插入item
 */
- (void)insertHeaderItem:(Class)headerClass data:(id _Nullable)data section:(NSInteger)section;
- (void)insertHeaderItem:(Class)headerClass data:(id _Nullable)data delegate:(id _Nullable)delegate section:(NSInteger)section;

- (void)insertCellItem:(Class)cellClass data:(id _Nullable)data indexPath:(NSIndexPath *)indexPath;
- (void)insertCellItem:(Class)cellClass data:(id _Nullable)data delegate:(id _Nullable)delegate indexPath:(NSIndexPath *)indexPath;
- (void)insertCellItems:(Class)cellClass dataList:(NSArray *)dataList indexPath:(NSIndexPath *)indexPath;
- (void)insertCellItems:(Class)cellClass dataList:(NSArray *)dataList delegate:(id _Nullable)delegate indexPath:(NSIndexPath *)indexPath;

- (void)insertFooterItem:(Class)footerClass data:(id _Nullable)data section:(NSInteger)section;
- (void)insertFooterItem:(Class)footerClass data:(id _Nullable)data delegate:(id _Nullable)delegate section:(NSInteger)section;


/**
  删除 item
 */
- (void)removeItems;
- (void)removeSectionItem:(NSUInteger)section;
- (void)removeHeaderItem:(NSUInteger)section;
- (void)removeCellItem:(NSIndexPath *)indexPath;
- (void)removeFooterItem:(NSUInteger)section;

/**
 获取item 数据
 */
// header item
- (CXYTableItem*)headerItemInSection:(NSUInteger)section;
- (id)headerItemDataInSection:(NSUInteger)section;
- (id)headerItemDelegateInSection:(NSUInteger)section;
- (Class)headerItemClassInSection:(NSUInteger)section;
- (CXYTableItemBlock)headerItemBlockInSection:(NSUInteger)section;

// footer item
- (CXYTableItem*)footerItemInSection:(NSUInteger)section;
- (id)footerItemDataInSection:(NSUInteger)section;
- (id)footerItemDelegateInSection:(NSUInteger)section;
- (Class)footerItemClassInSection:(NSUInteger)section;
- (CXYTableItemBlock)footerItemBlockInSection:(NSUInteger)section;

// cell item
- (CXYTableItem*)cellItemAtIndexPath:(NSIndexPath*)indexPath;
- (id)cellItemDataAtIndexPath:(NSIndexPath*)indexPath;
- (id)cellItemDelegateAtIndexPath:(NSIndexPath*)indexPath;
- (Class)cellItemClassAtIndexPath:(NSIndexPath*)indexPath;
- (CXYTableItemBlock)cellItemBlockAtIndexPath:(NSIndexPath*)indexPath;



/**
 *  获取item数量
 */
- (NSUInteger)numberOfSections;
- (NSUInteger)numberOfCellItemsInSection:(NSUInteger)section;

/**
 *  获取item高度
 */
- (CGFloat)heightForCellAtIndexPath:(NSIndexPath*)indexPath;
- (CGFloat)heightForHeaderInSection:(NSUInteger)section;
- (CGFloat)heightForFooterInSection:(NSUInteger)section;

/**
 *  获取重用item
 */
- (UITableViewCell*)reusableCellAtIndexPath:(NSIndexPath*)indexPath;
- (UITableViewHeaderFooterView*)reusableHeaderInSection:(NSUInteger)section;
- (UITableViewHeaderFooterView*)reusableFooterInSection:(NSUInteger)section;

@end

NS_ASSUME_NONNULL_END
