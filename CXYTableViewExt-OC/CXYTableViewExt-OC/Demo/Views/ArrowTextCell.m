//
//  ArrowTextCell.m
//  CXYTableViewExt-OC
//
//  Created by cxy on 2024/3/20.
//

#import "ArrowTextCell.h"
#import "CXYTableItemProtocol.h"

@interface ArrowTextCell ()<CXYTableItemProtocol>

@property (weak, nonatomic) IBOutlet UILabel *title;

@end
@implementation ArrowTextCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configData:(id)data {
    self.title.text = data;
}


@end
