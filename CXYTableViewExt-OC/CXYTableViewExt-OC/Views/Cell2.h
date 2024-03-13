//
//  Cell2.h
//  CXYTableViewExt-OC
//
//  Created by cxy on 2024/3/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol Cell2Delegate <NSObject>

- (void)Cell2DelegateSwitchChanged:(BOOL)isOn indexPath:(NSIndexPath*)indexPath;

@end

@interface Cell2 : UITableViewCell

@end

NS_ASSUME_NONNULL_END
