//
//  NewsCell.m
//  CXYTableViewExt-OC
//
//  Created by cxy on 2024/3/27.
//

#import "NewsCell.h"
#import "CXYTableItemProtocol.h"

@interface NewsCell ()<CXYTableItemProtocol>
@property (weak, nonatomic) IBOutlet UIImageView *cover;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *desc;

@end
@implementation NewsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    

}

#pragma mark - CXYTableItemProtocol
- (void)configData:(id)data {
    self.cover.image = [UIImage imageNamed:@"cover"];
}

@end
