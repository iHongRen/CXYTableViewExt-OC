//
//  HeadTitleCell.m
//  CXYTableViewExt-OC
//
//  Created by cxy on 2024/4/11.
//

#import "HeadTitleCell.h"
#import "CXYTableItemProtocol.h"

@interface HeadTitleCell ()<CXYTableItemProtocol>
@property (weak, nonatomic) IBOutlet UILabel *title;

@end
@implementation HeadTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

#pragma mark - CXYTableItemProtocol
- (void)configData:(id)data {
    self.title.text = data;
}


@end
