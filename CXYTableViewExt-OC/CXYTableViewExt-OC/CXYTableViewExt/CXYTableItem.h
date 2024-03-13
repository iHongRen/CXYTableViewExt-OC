//
//  CXYTableItem.h
//  CXYTableViewExt-OC
//
//  Created by cxy on 2024/3/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^CXYTableItemBlock)(id data, NSIndexPath *indexPath);

@interface CXYTableItem : NSObject

@property (nonatomic, strong) Class itemClass;
@property (nonatomic, strong, nullable) id data;
@property (nonatomic, weak, nullable) id delegate;
@property (nonatomic, copy, nullable) CXYTableItemBlock itemBlock;
@end

NS_ASSUME_NONNULL_END
