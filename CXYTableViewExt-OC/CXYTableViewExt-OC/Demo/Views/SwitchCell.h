//
//  SwitchCell.h
//  CXYTableViewExt-OC
//
//  Created by cxy on 2024/3/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SwitchCellDelegate <NSObject>

- (void)switchCellDelegateSwitchChanged:(id)data;

@end

@interface SwitchCell : UITableViewCell

@end

NS_ASSUME_NONNULL_END
