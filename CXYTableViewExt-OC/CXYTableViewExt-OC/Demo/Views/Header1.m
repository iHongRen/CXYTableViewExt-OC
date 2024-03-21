//
//  Header1.m
//  CXYTableViewExt-OC
//
//  Created by cxy on 2024/3/13.
//

#import "Header1.h"

@implementation Header1

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = UIColor.redColor;
    }
    return self;
}

+ (CGFloat)heightForData:(id)data {
    return 30;
}

- (void)configData:(id)data {
    
}

@end
