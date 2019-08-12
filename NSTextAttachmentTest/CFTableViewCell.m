//
//  CFTableViewCell.m
//  11 - 动态表情
//
//  Created by 于传峰 on 2017/2/15.
//  Copyright © 2017年 于传峰. All rights reserved.
//

#import "CFTableViewCell.h"
#import "GSGifLabel.h"

@interface CFTableViewCell()


@end

@implementation CFTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _label = [[GSGifLabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        _label.numberOfLines = 0;
        [self addSubview:_label];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setMode:(CFTextModel *)mode
{
    CGRect frame = CGRectMake(0, 0, 300, mode.height);
    _label.frame = frame;
}
@end
