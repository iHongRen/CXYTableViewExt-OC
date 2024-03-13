//
//  Footer1.m
//  CXYTableViewExt-OC
//
//  Created by cxy on 2024/3/13.
//

#import "Footer1.h"

@implementation Footer1

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = UIColor.grayColor;
    }
    return self;
}

+ (CGFloat)heightForData:(id)data {
    return 40;
}

- (void)configData:(id)data {
    
}

@end
