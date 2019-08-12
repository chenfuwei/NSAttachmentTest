//
//  GSGifTextAttachment.m
//  NSTextAttachmentTest
//
//  Created by net263 on 2019/8/9.
//  Copyright © 2019 net263. All rights reserved.
//

#import "GSGifTextAttachment.h"
#import "UIImage+GSGIF.h"
@interface GSGifTextAttachment()
@property(nonatomic, weak)UIImageView *imageView;
@end

@implementation GSGifTextAttachment
- (UIImage *)imageForBounds:(CGRect)imageBounds textContainer:(NSTextContainer *)textContainer characterIndex:(NSUInteger)charIndex
{
    [_imageView removeFromSuperview];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.backgroundColor = [UIColor redColor];
    [self.containerView addSubview:imageView];
    _imageView = imageView;
    
    UIImage *image = [super imageForBounds:imageBounds textContainer:textContainer characterIndex:charIndex];
    CGRect frame = imageBounds;
    if(textContainer != nil)
    {
        frame = CGRectMake(frame.origin.x, frame.origin.y - frame.size.height, frame.size.width, frame.size.height);
    }
    
    self.imageView.frame = frame;
    if(_gifName != nil)
    {
        self.imageView.image = [UIImage gs_animatedGIFNamed:_gifName];
    }
    return image;
}


-(void)reset
{
    [_imageView removeFromSuperview];
}

-(void)dealloc
{
    [_imageView removeFromSuperview];
    NSLog(@"GSGifTextAttachment dealloc");
}
@end
