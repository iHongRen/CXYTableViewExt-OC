//
//  Header.m
//  CXYTableViewExt-OC
//
//  Created by cxy on 2024/3/13.
//

#import "Header.h"
#import "CXYTableItemProtocol.h"

@interface Header ()<CXYTableItemProtocol>
@property (nonatomic, strong) UILabel *title;

@end

@implementation Header

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = UIColor.redColor;
        self.backgroundColor = UIColor.redColor;
        
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
