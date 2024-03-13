//
//  Cell2.m
//  CXYTableViewExt-OC
//
//  Created by cxy on 2024/3/13.
//

#import "Cell2.h"
#import "UITableView+CXYExt.h"

@interface Cell2 ()<CXYTableItemProtocol>
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UISwitch *switchView;
@property (nonatomic, weak) id delegate;
@property (nonatomic, strong) NSIndexPath *indexPath;
@end
@implementation Cell2

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configData:(id)data indexPath:(NSIndexPath *)indexPath delegate:(id)delegate {
    self.switchView.on = [data boolValue];
    self.delegate = delegate;
    self.indexPath = indexPath;
}


- (IBAction)onSwitch:(UISwitch*)sender {
    if ([self.delegate respondsToSelector:@selector(Cell2DelegateSwitchChanged:indexPath:)]) {
        [self.delegate Cell2DelegateSwitchChanged:sender.isOn indexPath:self.indexPath];
    }
}

@end
