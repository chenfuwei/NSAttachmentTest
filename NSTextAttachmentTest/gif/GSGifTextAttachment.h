//
//  GSGifTextAttachment.h
//  NSTextAttachmentTest
//
//  Created by net263 on 2019/8/9.
//  Copyright © 2019 net263. All rights reserved.
//

#import <UIKit/UIKit.h>
#define gifRect CGRectMake(0,0,60,50)
NS_ASSUME_NONNULL_BEGIN

@interface GSGifTextAttachment : NSTextAttachment
@property(nonatomic,copy)NSString *gifName;
@property(nonatomic,weak)UIView *containerView;

-(void)reset;
@end

NS_ASSUME_NONNULL_END
