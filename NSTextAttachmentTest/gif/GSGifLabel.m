//
//  GSGifLabel.m
//  NSTextAttachmentTest
//
//  Created by net263 on 2019/8/9.
//  Copyright © 2019 net263. All rights reserved.
//

#import "GSGifLabel.h"
#import "GSGifTextAttachment.h"

@implementation GSGifLabel

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    if(self.attributedText != nil)
    {
        [self.attributedText enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, self.attributedText.length) options:NSAttributedStringEnumerationReverse usingBlock:^(GSGifTextAttachment* value, NSRange range, BOOL * _Nonnull stop) {
            if(value && CGRectEqualToRect(value.bounds, gifRect))
            {
                [value reset];
            }
        }];
    }
    [super setAttributedText:attributedText];

    [self.attributedText enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, self.attributedText.length) options:NSAttributedStringEnumerationReverse usingBlock:^(GSGifTextAttachment* value, NSRange range, BOOL * _Nonnull stop) {
        if(value && CGRectEqualToRect(value.bounds, gifRect))
        {
            value.containerView = self;
        }
    }];
}

@end
