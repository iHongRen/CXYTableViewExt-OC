//
//  UITableView+CXYExt.m
//  CXYTableViewExt-OC
//
//  Created by cxy on 2024/3/12.
//

#import "UITableView+CXYExt.h"
#import <objc/runtime.h>

@interface UITableView ()
@property (nonatomic, strong, readwrite) CXYTable *t;
@end

@implementation UITableView (CXYExt)

- (CXYTable*)t {
    id table = objc_getAssociatedObject(self, _cmd);
    if (!table) {
        table = [[CXYTable alloc] initWithTableView:self];
        objc_setAssociatedObject(self, _cmd, table, OBJC_ASSOCIATION_RETAIN);
    }
    return table;
}


@end
