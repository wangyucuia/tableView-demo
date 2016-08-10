//
//  WYCTableViewCell.m
//  tableView demo
//
//  Created by 王玉翠 on 16/7/22.
//  Copyright © 2016年 王玉翠. All rights reserved.
//

#import "WYCTableViewCell.h"

@implementation WYCTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSLog(@"%@",NSStringFromCGRect(self.frame));
        
        [self.contentView addSubview:self.WYCimageView];
        
    }
    return self;
}


-(UIImageView *)WYCimageView{
    
    
    if (_WYCimageView == nil) {
        
        _WYCimageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
        _WYCimageView.image = [UIImage imageNamed:@"123"];
        _WYCimageView.contentMode = UIViewContentModeScaleAspectFill;
        
    }
    return _WYCimageView;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
