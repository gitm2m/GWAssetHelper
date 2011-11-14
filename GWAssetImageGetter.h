//
//  GWAssetImageGetter.h
//  rototray
//
//  Created by Glenn Wolters on 11/14/11.
//  Copyright (c) 2011 Glnn!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GWAssetImageGetterDelegate.h"

@class GWAssetManager;

@interface GWAssetImageGetter : NSObject

@property (nonatomic, retain) NSURL *assetURL;
@property (nonatomic, assign) id<GWAssetImageGetterDelegate> delegate;

-(id)initWithDelegate:(id)delegate;

-(void)thumbnailForAssetURL:(NSURL *)assetURL;
-(void)fullscreenImageForAssetURL:(NSURL *)assetURL;
@end
