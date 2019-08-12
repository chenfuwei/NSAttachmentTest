//
//  CFTableViewCell.h
//  11 - 动态表情
//
//  Created by 于传峰 on 2017/2/15.
//  Copyright © 2017年 于传峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CFTextModel.h"

@interface CFTableViewCell : UITableViewCell
@property (strong, nonatomic) UILabel *label;
@property(strong, nonatomic)CFTextModel *mode;

@end
