//
//  CXYTableItemProtocol.h
//  CXYTableViewExt-OC
//
//  Created by cxy on 2024/3/13.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@protocol CXYTableItemProtocol <NSObject>

@optional
+ (CGFloat)heightForData:(id)data;

- (void)configData:(id)data;
- (void)configData:(id)data indexPath:(NSIndexPath *)indexPath delegate:(id)delegate;

@end


NS_ASSUME_NONNULL_END
