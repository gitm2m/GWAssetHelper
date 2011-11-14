//
//  GWAssetImageGetter.m
//  rototray
//
//  Created by Glenn Wolters on 11/14/11.
//  Copyright (c) 2011 Glnn!. All rights reserved.
//

#import "GWAssetImageGetter.h"

@implementation GWAssetImageGetter

@synthesize assetURL = __assetURL;
@synthesize delegate = __delegate;

-(id)initWithDelegate:(id)delegate {
    self = [self init];
    if (self) {
        [self setDelegate:delegate];
    }
    return self;
}

-(void)thumbnailForAssetURL:(NSURL *)assetURL {
	[self setAssetURL:assetURL];
		
	GWAssetManager *manager = (GWAssetManager *)[self delegate];
	ALAssetsLibrary *library = [manager library];
	
	[library assetForURL:assetURL resultBlock:^(ALAsset *asset){
		CGImageRef imageRef = [asset thumbnail];
		UIImage *image = [UIImage imageWithCGImage:imageRef];
		
		if ([__delegate respondsToSelector:@selector(imageGetter:finishedWithThumbnail:forAssetURL:)]) {
			[__delegate imageGetter:self finishedWithImage:image forAssetURL:[self assetURL]];
		}
		
	}failureBlock:^(NSError *error) {
		if ([__delegate respondsToSelector:@selector(imageGetter:failedWithError:forAssetURL:)]) {
			[__delegate imageGetter:self failedWithError:error forAssetURL:[self assetURL]];
		}
	}];
}

-(void)fullscreenImageForAssetURL:(NSURL *)assetURL {
	[self setAssetURL:assetURL];
	
	GWAssetManager *manager = (GWAssetManager *)[self delegate];
	ALAssetsLibrary *library = [manager library];
	
	[library assetForURL:assetURL resultBlock:^(ALAsset *asset){
		ALAssetRepresentation *representation = [asset defaultRepresentation];
		
		CGImageRef imageRef = [representation fullScreenImage];
		UIImage *image = [UIImage imageWithCGImage:imageRef scale:[representation scale] orientation:[representation orientation]];
		NSLog(@"IMG %@", image);
		if ([__delegate respondsToSelector:@selector(imageGetter:finishedWithImage:forAssetURL:)]) {
			[__delegate imageGetter:self finishedWithImage:image forAssetURL:[self assetURL]];
		}
		
	}failureBlock:^(NSError *error) {
		if ([__delegate respondsToSelector:@selector(imageGetter:failedWithError:forAssetURL:)]) {
			[__delegate imageGetter:self failedWithError:error forAssetURL:[self assetURL]];
		}
	}];
}

@end
