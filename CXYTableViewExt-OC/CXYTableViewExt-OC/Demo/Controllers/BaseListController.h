//
//  BaseListController.h
//  CXYTableViewExt-OC
//
//  Created by cxy on 2024/3/21.
//

#import <UIKit/UIKit.h>
#import "UITableView+CXYExt.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseListController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong, readonly) UITableView *tableView;

@end

NS_ASSUME_NONNULL_END
