//
//  Cell1.m
//  CXYTableViewExt-OC
//
//  Created by cxy on 2024/3/13.
//

#import "Cell1.h"
#import "UITableView+CXYExt.h"

@interface Cell1 ()<CXYTableItemProtocol>
@property (weak, nonatomic) IBOutlet UILabel *title;

@end
@implementation Cell1

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (CGFloat)heightForData:(id)data {
    return 80;
}

- (void)configData:(id)data {
    self.title.text = data;
}
@end
