//
//  CXYTable.m
//  CXYTableViewExt-OC
//
//  Created by cxy on 2024/3/13.
//

#import <UIKit/UIKit.h>
#import "CXYTable.h"
#import "CXYTableSectionItem.h"
#import "UITableView+CXYExt.h"
#import "CXYTableDataSource.h"

@interface CXYTable ()

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSMutableDictionary *registeredClasses;
@property (nonatomic, strong) CXYTableDataSource *defaultDataSource;
@property (nonatomic, strong) NSMutableArray<CXYTableSectionItem*> *sectionItems;
@end

@implementation CXYTable

- (instancetype)initWithTableView:(UITableView*)tableView {
    if (self = [super init]) {
        self.tableView = tableView;
    }
    return self;
}

- (void)makeItems:(void(NS_NOESCAPE ^)(CXYTable *make))block {
    [self removeItems];
    block(self);
    [self.tableView reloadData];
}

- (void)updateItems:(void(NS_NOESCAPE ^)(CXYTable *make, UITableView *tableView))block {
    block(self, self.tableView);
}

- (void)removeItems:(void(NS_NOESCAPE ^)(CXYTable *make, UITableView *tableView))block {
    block(self, self.tableView);
}

- (CXYTableDataSource *)defaultDataSource {
    if (!_defaultDataSource) {
        _defaultDataSource = CXYTableDataSource.new;
    }
    return _defaultDataSource;
}

- (NSMutableArray<CXYTableSectionItem*> *)sectionItems {
    if (!_sectionItems) {
        _sectionItems = NSMutableArray.new;
    }
    return _sectionItems;
}


- (NSMutableDictionary *)registeredClasses {
    if (!_registeredClasses) {
        _registeredClasses = NSMutableDictionary.new;
    }
    return _registeredClasses;
}


- (void)registerItemClasses:(NSArray *)itemClasses {
    for (Class itemClass in itemClasses) {
        [self registerItemClass:itemClass];
    }
}

- (void)registerItemClass:(Class)itemClass {
    NSString *name = NSStringFromClass(itemClass);
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"nib"];
    
    if ([itemClass isSubclassOfClass:[UITableViewCell class]]) {
        if (path) {
            [self.tableView registerNib:[UINib nibWithNibName:name bundle:nil] forCellReuseIdentifier:name];
        } else {
            [self.tableView registerClass:itemClass forCellReuseIdentifier:name];
        }
        
    } else if ([itemClass isSubclassOfClass:[UITableViewHeaderFooterView class]]) {
        if (path) {
            [self.tableView registerNib:[UINib nibWithNibName:name bundle:nil] forHeaderFooterViewReuseIdentifier:name];
        } else {
            [self.tableView registerClass:itemClass forHeaderFooterViewReuseIdentifier:name];
        }
    } else {
        [NSException raise:NSInvalidArgumentException format:@"%s is an illegal class!", name.UTF8String];
    }
}

// 数据源&代理
- (void)configDataSource:(id<UITableViewDelegate,UITableViewDataSource>)dataSource {
    self.tableView.dataSource = dataSource;
    self.tableView.delegate = dataSource;
}

- (void)useDefaultDataSource {
    [self configDataSource:self.defaultDataSource];
}

- (void)useDefaultDataSourceIfNeed {
    if (!self.tableView.delegate && !self.tableView.dataSource) {
        [self useDefaultDataSource];
    }
}

- (void)defaultDidSelectCell:(void(^)(UITableView *tableView, NSIndexPath *indexPath))didSelect {
    self.defaultDataSource.didSelect = didSelect;
}


- (BOOL)isEmptySectionItems {
    if (self.sectionItems.count==0) return YES;
    
    for (CXYTableSectionItem *sec in self.sectionItems) {
        if (!sec.isEmptyItem) {
            return NO;
        }
    }
    return YES;
}

- (void)registerIfNeed:(Class)itemClass {
    NSString *name = NSStringFromClass(itemClass);
    if (!self.registeredClasses[name]) {
        [self registerItemClass:itemClass];
        self.registeredClasses[name] = itemClass;
    }
}

/**
 添加item
 */
- (void)addHeaderItem:(Class)headerClass data:(id)data delegate:(id)delegate {
    [self registerIfNeed:headerClass];
    [self useDefaultDataSourceIfNeed];
    
    CXYTableItem *headerItem = [CXYTableItem new];
    headerItem.itemClass = headerClass;
    headerItem.data = data;
    headerItem.delegate = delegate;
    
    CXYTableSectionItem *last = self.sectionItems.lastObject;
    if (last && [last isEmptyItem]) {
        last.headerItem = headerItem;
    } else {
        CXYTableSectionItem *sec = [CXYTableSectionItem new];
        sec.headerItem = headerItem;
        [self.sectionItems addObject:sec];
    }
}

- (void)addHeaderItem:(Class)headerClass data:(id)data {
    [self addHeaderItem:headerClass data:data delegate:nil];
}

- (void)addCellClass:(Class)cellClass data:(id)data {
    [self addCellClass:cellClass data:data delegate:nil];
}

- (void)addCellClass:(Class)cellClass delegate:(id)delegate {
    [self addCellClass:cellClass data:nil delegate:delegate];
}

- (void)addCellClass:(Class)cellClass data:(id)data delegate:(id)delegate {
    [self addCellClass:cellClass data:data delegate:delegate didSelectBlock:nil];
}

- (void)addCellClass:(Class)cellClass didSelectBlock:(CXYTableItemBlock)block {
    [self addCellClass:cellClass data:nil delegate:nil didSelectBlock:block];
}

- (void)addCellClass:(Class)cellClass data:(id)data didSelectBlock:(CXYTableItemBlock)block {
    [self addCellClass:cellClass data:data delegate:nil didSelectBlock:block];
}

- (void)addCellClass:(Class)cellClass data:(id)data delegate:(id)delegate didSelectBlock:(CXYTableItemBlock)block {
    [self registerIfNeed:cellClass];
    [self useDefaultDataSourceIfNeed];
    
    CXYTableSectionItem *last = self.sectionItems.lastObject;
    if (!last || last.footerItem) {
        last = [CXYTableSectionItem new];
        [self.sectionItems addObject:last];
    }
    
    CXYTableItem *item = [CXYTableItem new];
    item.itemClass = cellClass;
    item.data = data;
    item.delegate = delegate;
    item.itemBlock = block;
    
    [last.cellItems addObject:item];
}

- (void)addCellClass:(Class)cellClass dataList:(NSArray *)dataList {
    [self addCellClass:cellClass dataList:dataList delegate:nil];
}

- (void)addCellClass:(Class)cellClass dataList:(NSArray *)dataList delegate:(id)delegate {
    if (dataList.count == 0) {
        return;
    }
  
    NSMutableArray *cellItems = [NSMutableArray arrayWithCapacity:dataList.count];
    for (id data in dataList) {
        CXYTableItem *item = [CXYTableItem new];
        item.itemClass = cellClass;
        item.data = data;
        item.delegate = delegate;
        [cellItems addObject:item];
    }
    [self addCellClass:cellClass items:cellItems];
}

- (void)addCellClass:(Class)cellClass dataList:(NSArray *)dataList didSelectBlock:(CXYTableItemBlock _Nullable)block {
    if (dataList.count == 0) {
        return;
    }
  
    NSMutableArray *cellItems = [NSMutableArray arrayWithCapacity:dataList.count];
    for (id data in dataList) {
        CXYTableItem *item = [CXYTableItem new];
        item.itemClass = cellClass;
        item.data = data;
        item.itemBlock = block;
        [cellItems addObject:item];
    }
    [self addCellClass:cellClass items:cellItems];
}

- (void)addCellClass:(Class)cellClass items:(NSArray<CXYTableItem*> *)items {
    if (items.count == 0) {
        return;
    }
    
    [self registerIfNeed:cellClass];
    [self useDefaultDataSourceIfNeed];
    
    CXYTableSectionItem *last = self.sectionItems.lastObject;
    if (!last || !last.footerItem) {
        last = [CXYTableSectionItem new];
        [self.sectionItems addObject:last];
    }
    
    [last.cellItems addObjectsFromArray:items];
}


- (void)addFooterItem:(Class)footerClass data:(id)data delegate:(id)delegate {
    [self registerIfNeed:footerClass];
    [self useDefaultDataSourceIfNeed];
    
    CXYTableItem *item = [CXYTableItem new];
    item.itemClass = footerClass;
    item.data = data;
    item.delegate = delegate;
    
    CXYTableSectionItem *last = self.sectionItems.lastObject;
    if (!last || last.footerItem) {
        last = [CXYTableSectionItem new];
        [self.sectionItems addObject:last];
    }
    last.footerItem = item;
}

- (void)addFooterItem:(Class)footerClass data:(id)data {
    [self addFooterItem:footerClass data:data delegate:nil];
}


/**
 插入item
 */
- (void)insertHeaderItem:(Class)headerClass data:(id)data section:(NSInteger)section {
    [self insertHeaderItem:headerClass data:data delegate:nil section:section];
}

- (void)insertHeaderItem:(Class)headerClass data:(id)data delegate:(id)delegate section:(NSInteger)section {
    if (section > self.sectionItems.count) {
        NSString *msg = [NSString stringWithFormat:@"section(%@) is out of range",@(section)];
        NSAssert(NO, msg);
        return;
    }
    
    if (section==self.sectionItems.count) {
        [self addHeaderItem:headerClass data:data delegate:delegate];
        return;
    }
    
    [self registerIfNeed:headerClass];
    [self useDefaultDataSourceIfNeed];
    
    CXYTableItem *item = [CXYTableItem new];
    item.itemClass = headerClass;
    item.data = data;
    item.delegate = delegate;
    
    CXYTableSectionItem *sectionItem = self.sectionItems[section];
    if (sectionItem.headerItem==nil) {
        sectionItem.headerItem = item;
    } else {
        CXYTableSectionItem *newItem = [CXYTableSectionItem new];
        newItem.headerItem = item;
        [self.sectionItems insertObject:newItem atIndex:section];
    }
}

- (void)insertCellItem:(Class)cellClass data:(id)data indexPath:(NSIndexPath *)indexPath {
    [self insertCellItem:cellClass data:data delegate:nil indexPath:indexPath];
}

- (void)insertCellItem:(Class)cellClass data:(id)data delegate:(id)delegate indexPath:(NSIndexPath *)indexPath {
    [self insertCellItems:cellClass dataList:@[data] delegate:delegate indexPath:indexPath];
}

- (void)insertCellItems:(Class)cellClass dataList:(NSArray *)dataList indexPath:(NSIndexPath *)indexPath {
    [self insertCellItems:cellClass dataList:dataList delegate:nil indexPath:indexPath];
}

- (void)insertCellItems:(Class)cellClass dataList:(NSArray *)dataList delegate:(id)delegate indexPath:(NSIndexPath *)indexPath {
    if (indexPath.section >= self.sectionItems.count) {
        NSString *msg = [NSString stringWithFormat:@"section(%@) is out of range",@(indexPath.section)];
        NSAssert(NO, msg);
        return;
    }
    
    [self registerIfNeed:cellClass];
    [self useDefaultDataSourceIfNeed];
    
    NSMutableArray *items = [NSMutableArray arrayWithCapacity:dataList.count];
    for (id data in dataList) {
        CXYTableItem *item = [CXYTableItem new];
        item.itemClass = cellClass;
        item.data = data;
        item.delegate = delegate;
        
        [items addObject:item];
    }
    
    CXYTableSectionItem *sectionItem = self.sectionItems[indexPath.section];
    if (indexPath.row > sectionItem.cellItems.count) {
        NSString *msg = [NSString stringWithFormat:@"section (%@), row (%@) is out of range",@(indexPath.section), @(indexPath.row)];
        NSAssert(NO, msg);
        return;
    }
    [sectionItem.cellItems insertObjects:items atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(indexPath.row, items.count)]];
}

- (void)insertFooterItem:(Class)footerClass data:(id)data section:(NSInteger)section {
    [self insertFooterItem:footerClass data:data delegate:nil section:section];
}

- (void)insertFooterItem:(Class)footerClass data:(id)data delegate:(id)delegate section:(NSInteger)section {
    if (section > self.sectionItems.count) {
        NSString *msg = [NSString stringWithFormat:@"section(%@) is out of range",@(section)];
        NSAssert(NO, msg);
        return;
    }
    
    if (section==self.sectionItems.count) {
        [self addFooterItem:footerClass data:data delegate:delegate];
        return;
    }
    
    [self registerIfNeed:footerClass];
    [self useDefaultDataSourceIfNeed];
    
    CXYTableItem *item = [CXYTableItem new];
    item.itemClass = footerClass;
    item.data = data;
    item.delegate = delegate;
    
    CXYTableSectionItem *sectionItem = self.sectionItems[section];
    if (sectionItem.footerItem==nil) {
        sectionItem.footerItem = item;
    } else {
        CXYTableSectionItem *newItem = [CXYTableSectionItem new];
        newItem.footerItem = item;
        [self.sectionItems insertObject:newItem atIndex:section];
    }
}


/**
  删除 item
 */
- (void)removeItems {
    [self.sectionItems removeAllObjects];
}

- (void)removeSectionItem:(NSUInteger)section {
    [self.sectionItems removeObjectAtIndex:section];
}

- (void)removeHeaderItem:(NSUInteger)section {
    CXYTableSectionItem *sectionItem = [self sectionItemInSection:section];
    if (sectionItem) {
        sectionItem.headerItem = nil;
    }
}

- (void)removeCellItem:(NSIndexPath *)indexPath {
    CXYTableSectionItem *sectionItem = [self sectionItemInSection:indexPath.section];
    if (sectionItem) {
        NSMutableArray *cellItems = sectionItem.cellItems;
        if (indexPath.row < cellItems.count) {
            [cellItems removeObjectAtIndex:indexPath.row];
        }
    }
}

- (void)removeFooterItem:(NSUInteger)section {
    CXYTableSectionItem *sectionItem = [self sectionItemInSection:section];
    if (sectionItem) {
        sectionItem.footerItem = nil;
    }
}



/**
 获取item
 */
- (CXYTableSectionItem *)sectionItemInSection:(NSUInteger)section {
    if (self.sectionItems.count>section) {
        return self.sectionItems[section];
    }
    return nil;
}

// header item
- (CXYTableItem*)headerItemInSection:(NSUInteger)section {
    return [self sectionItemInSection:section].headerItem;
}

- (id)headerItemDataInSection:(NSUInteger)section {
    return [self headerItemInSection:section].data;
}

- (id)headerItemDelegateInSection:(NSUInteger)section {
    return [self headerItemInSection:section].delegate;
}

- (Class)headerItemClassInSection:(NSUInteger)section {
    return [self headerItemInSection:section].itemClass;
}

- (CXYTableItemBlock)headerItemBlockInSection:(NSUInteger)section {
    return [self headerItemInSection:section].itemBlock;
}

// footer item
- (CXYTableItem*)footerItemInSection:(NSUInteger)section {
    return [self sectionItemInSection:section].footerItem;
}

- (id)footerItemDataInSection:(NSUInteger)section {
    return [self footerItemInSection:section].data;
}

- (id)footerItemDelegateInSection:(NSUInteger)section {
    return [self footerItemInSection:section].delegate;
}

- (Class)footerItemClassInSection:(NSUInteger)section {
    return [self footerItemInSection:section].itemClass;
}

- (CXYTableItemBlock)footerItemBlockInSection:(NSUInteger)section {
    return [self footerItemInSection:section].itemBlock;
}

// cell item
- (NSArray<CXYTableItem *>*)cellItemsInSection:(NSUInteger)section {
    return [self sectionItemInSection:section].cellItems;
}

- (CXYTableItem*)cellItemAtIndexPath:(NSIndexPath*)indexPath {
    NSArray *cellItems = [self cellItemsInSection:indexPath.section];
    if (cellItems.count > indexPath.row) {
        return cellItems[indexPath.row];
    }
    return nil;
}

- (id)cellItemDataAtIndexPath:(NSIndexPath*)indexPath {
    return [self cellItemAtIndexPath:indexPath].data;
}

- (id)cellItemDelegateAtIndexPath:(NSIndexPath*)indexPath {
    return [self cellItemAtIndexPath:indexPath].delegate;
}

- (Class)cellItemClassAtIndexPath:(NSIndexPath*)indexPath {
    return [self cellItemAtIndexPath:indexPath].itemClass;
}

- (CXYTableItemBlock)cellItemBlockAtIndexPath:(NSIndexPath*)indexPath {
    return [self cellItemAtIndexPath:indexPath].itemBlock;
}




/**
 *  获取item数量
 */
- (NSUInteger)numberOfSections {
    return MAX(1, self.sectionItems.count);
}

- (NSUInteger)numberOfCellItemsInSection:(NSUInteger)section {
    return [self cellItemsInSection:section].count;
}





/**
 *  获取item高度
 */
- (CGFloat)heightForItem:(CXYTableItem*)item {
    if (!item) return CGFLOAT_MIN;
    
    if([item.itemClass respondsToSelector:@selector(heightForData:)]) {
        return [item.itemClass heightForData:item.data];
    }
    return UITableViewAutomaticDimension;
}

- (CGFloat)heightForCellAtIndexPath:(NSIndexPath*)indexPath {
    CXYTableItem *item = [self cellItemAtIndexPath:indexPath];
    return [self heightForItem:item];
}

- (CGFloat)heightForHeaderInSection:(NSUInteger)section {
    CXYTableItem *item = [self headerItemInSection:section];
    return [self heightForItem:item];
}

- (CGFloat)heightForFooterInSection:(NSUInteger)section {
    CXYTableItem *item = [self footerItemInSection:section];
    return [self heightForItem:item];
}



/**
 *  获取重用item
 */
- (UITableViewCell*)reusableCellAtIndexPath:(NSIndexPath*)indexPath {
    CXYTableItem *item = [self cellItemAtIndexPath:indexPath];
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:NSStringFromClass(item.itemClass) forIndexPath:indexPath];
    if ([cell respondsToSelector:@selector(configData:)]) {
        [(id<CXYTableItemProtocol>)cell configData:item.data];
    }
    
    if ([cell respondsToSelector:@selector(configData:indexPath:delegate:)]) {
        [(id<CXYTableItemProtocol>)cell configData:item.data indexPath:indexPath delegate:item.delegate];
    }
    return cell;
}

- (UITableViewHeaderFooterView*)reusableHeaderInSection:(NSUInteger)section {
    CXYTableItem *item = [self headerItemInSection:section];
    UITableViewHeaderFooterView *v = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass(item.itemClass)];
    if ([v respondsToSelector:@selector(configData:)]) {
        [(id<CXYTableItemProtocol>)v configData:item.data];
    }
    
    if ([v respondsToSelector:@selector(configData:indexPath:delegate:)]) {
        [(id<CXYTableItemProtocol>)v configData:item.data indexPath:[NSIndexPath indexPathForRow:0 inSection:section] delegate:item.delegate];
    }
    return v;
}

- (UITableViewHeaderFooterView*)reusableFooterInSection:(NSUInteger)section {
    CXYTableItem *item = [self footerItemInSection:section];
    UITableViewHeaderFooterView *v = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass(item.itemClass)];
    if ([v respondsToSelector:@selector(configData:)]) {
        [(id<CXYTableItemProtocol>)v configData:item.data];
    }
    
    if ([v respondsToSelector:@selector(configData:indexPath:delegate:)]) {
        [(id<CXYTableItemProtocol>)v configData:item.data indexPath:[NSIndexPath indexPathForRow:0 inSection:section] delegate:item.delegate];
    }
    return v;
}



@end
