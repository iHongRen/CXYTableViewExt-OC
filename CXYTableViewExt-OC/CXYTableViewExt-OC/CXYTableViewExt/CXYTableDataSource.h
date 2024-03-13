//
//  CXYTableDataSource.h
//  CXYTableViewExt-OC
//
//  Created by cxy on 2024/3/12.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CXYTableDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, copy) void(^didSelect)(UITableView *tableView, NSIndexPath *indexPath);

@end

NS_ASSUME_NONNULL_END
