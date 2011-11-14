//
//  UIImageView+AssetHelper.h
//  rototray
//
//  Created by Glenn Wolters on 11/14/11.
//  Copyright (c) 2011 Glnn!. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GWAssetManager.h"

@interface UIImageView (AssetHelper) <GWAssetManagerDelegate>

-(void)setImageWithAssetURL:(NSURL *)assetURL;
-(void)setThumbnailWithAssetURL:(NSURL *)assetURL;
@end
