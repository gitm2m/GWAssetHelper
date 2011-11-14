//
//  UIImageView+AssetHelper.m
//  rototray
//
//  Created by Glenn Wolters on 11/14/11.
//  Copyright (c) 2011 Glnn!. All rights reserved.
//

#import "UIImageView+AssetHelper.h"

@implementation UIImageView (AssetHelper)


-(void)setImageWithAsset:(ALAsset *)asset {
//	GWAssetManager *assetManager = [GWAssetManager sharedAssetManager];
//	
//	NSDictionary *assetURLs = [asset valueForProperty:ALAssetPropertyURLs];
//	NSArray *keys = [assetURLs allKeys];
//	NSURL *assetURL = [assetURLs objectForKey:[keys firstObject]];
//	NSLog(@"URL %@", assetURL);
//
//	if (assetURL) {
//		[assetManager thumbnailWithAssetURL:assetURL forDelegate:self];		
//	}
}

-(void)setThumbnailWithAssetURL:(NSURL *)assetURL {
	GWAssetManager *assetManager = [GWAssetManager sharedAssetManager];
	
	[assetManager cancelForDelegate:self];
	
	if (assetURL) {
		[assetManager thumbnailWithAssetURL:assetURL forDelegate:self];
	}	
}

-(void)setImageWithAssetURL:(NSURL *)assetURL {

	GWAssetManager *assetManager = [GWAssetManager sharedAssetManager];

	[assetManager cancelForDelegate:self];
	
	if (assetURL) {
		[assetManager fullScreenImageWithAssetURL:assetURL forDelegate:self];
	}
}

-(void)assetManager:(GWAssetManager *)assetManager didFinishWithImage:(UIImage *)image {
	self.image = image;
}

-(void)assetManager:(GWAssetManager *)assetManager didFailWithError:(NSError *)error {
	
}


@end
