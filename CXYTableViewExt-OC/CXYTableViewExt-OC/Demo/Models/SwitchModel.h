//
//  SwitchModel.h
//  CXYTableViewExt-OC
//
//  Created by cxy on 2024/4/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SwitchModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL isOn;

+ (instancetype)title:(NSString*)title isOn:(BOOL)isOn;
@end

NS_ASSUME_NONNULL_END
