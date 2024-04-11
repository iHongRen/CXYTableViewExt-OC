//
//  TextCell.m
//  CXYTableViewExt-OC
//
//  Created by cxy on 2024/4/11.
//

#import "TextCell.h"
#import "CXYTableItemProtocol.h"

@interface TextCell ()<CXYTableItemProtocol>
@property (weak, nonatomic) IBOutlet UILabel *title;

@end
@implementation TextCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

#pragma mark - CXYTableItemProtocol
+ (CGFloat)heightForData:(id)data {
    return 40;
}

- (void)configData:(NSString*)data {
    self.title.text = data;
}

@end
