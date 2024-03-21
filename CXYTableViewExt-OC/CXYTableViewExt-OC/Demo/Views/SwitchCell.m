//
//  SwitchCell.m
//  CXYTableViewExt-OC
//
//  Created by cxy on 2024/3/13.
//

#import "SwitchCell.h"
#import "UITableView+CXYExt.h"

@interface SwitchCell ()<CXYTableItemProtocol>
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UISwitch *switchView;
@property (nonatomic, weak) id delegate;
@end

@implementation SwitchCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configData:(id)data indexPath:(NSIndexPath *)indexPath delegate:(id)delegate {
    self.switchView.on = [data boolValue];
    self.delegate = delegate;
}


- (IBAction)onSwitch:(UISwitch*)sender {
    if ([self.delegate respondsToSelector:@selector(Cell2DelegateSwitchChanged:)]) {
        [self.delegate Cell2DelegateSwitchChanged:sender.isOn];
    }
}

@end
