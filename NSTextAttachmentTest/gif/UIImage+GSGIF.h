//
//  UIImage+GSGIF.h
//  NSTextAttachmentTest
//
//  Created by net263 on 2019/8/9.
//  Copyright © 2019 net263. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (GSGIF)
+ (UIImage *)gs_animatedGIFNamed:(NSString *)name;

+ (UIImage *)gs_animatedGIFWithData:(NSData *)data;

- (UIImage *)gs_animatedImageByScalingAndCroppingToSize:(CGSize)size;
@end

NS_ASSUME_NONNULL_END
