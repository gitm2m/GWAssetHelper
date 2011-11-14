//
//  GWAssetImageGetterDelegate.h
//  rototray
//
//  Created by Glenn Wolters on 11/14/11.
//  Copyright (c) 2011 Glnn!. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GWAssetImageGetter;

@protocol GWAssetImageGetterDelegate <NSObject>

-(void)imageGetter:(GWAssetImageGetter *)imageGetter finishedWithImage:(UIImage *)image forAssetURL:(NSURL *)assetURL;
-(void)imageGetter:(GWAssetImageGetter *)imageGetter failedWithError:(NSError *)error forAssetURL:(NSURL *)assetURL;

@end
