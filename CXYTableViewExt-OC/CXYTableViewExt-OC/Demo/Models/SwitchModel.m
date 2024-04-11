//
//  SwitchModel.m
//  CXYTableViewExt-OC
//
//  Created by cxy on 2024/4/11.
//

#import "SwitchModel.h"

@implementation SwitchModel

+ (instancetype)title:(NSString*)title isOn:(BOOL)isOn {
    SwitchModel *model = SwitchModel.new;
    model.title = title;
    model.isOn = isOn;
    return model;
}

@end
