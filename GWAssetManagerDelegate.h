//
//  GWAssetManagerDelegate.h
//  rototray
//
//  Created by Glenn Wolters on 11/14/11.
//  Copyright (c) 2011 Glnn!. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GWAssetManager;

@protocol GWAssetManagerDelegate <NSObject>

- (void)assetManager:(GWAssetManager *)assetManager didFinishWithImage:(UIImage *)image;
- (void)assetManager:(GWAssetManager *)assetManager didFailWithError:(NSError *)error;


@end
