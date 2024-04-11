//
//  SwitchCell.m
//  CXYTableViewExt-OC
//
//  Created by cxy on 2024/3/13.
//

#import "SwitchCell.h"
#import "UITableView+CXYExt.h"
#import "SwitchModel.h"

@interface SwitchCell ()<CXYTableItemProtocol>
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UISwitch *switchView;
@property (nonatomic, weak) id delegate;
@property (nonatomic, strong) SwitchModel *model;
@end

@implementation SwitchCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)onSwitch:(UISwitch*)sender {
    if ([self.delegate respondsToSelector:@selector(switchCellDelegateSwitchChanged:)]) {
        [self.delegate switchCellDelegateSwitchChanged:self.model];
    }
}

#pragma mark - CXYTableItemProtocol
- (void)configData:(SwitchModel*)data indexPath:(NSIndexPath *)indexPath delegate:(id)delegate {
    self.model = data;
    self.title.text = data.title;
    self.switchView.on = data.isOn;
    self.delegate = delegate;
}

@end
