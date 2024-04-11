//
//  Footer.m
//  CXYTableViewExt-OC
//
//  Created by cxy on 2024/3/13.
//

#import "Footer.h"
#import "CXYTableItemProtocol.h"

@interface Footer()<CXYTableItemProtocol>

@property (nonatomic, strong) UILabel *title;
@end
@implementation Footer

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = UIColor.grayColor;
        self.backgroundColor = UIColor.grayColor;
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 200, 30)];
        title.textColor = UIColor.whiteColor;
        [self.contentView addSubview:title];
        self.title = title;
    }
    return self;
}

#pragma mark - CXYTableItemProtocol
+ (CGFloat)heightForData:(id)data {
    return 30;
}

- (void)configData:(NSString*)data {
    self.title.text = data;
}

@end
