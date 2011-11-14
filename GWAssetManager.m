//
//  GWAssetManager.m
//  rototray
//
//  Created by Glenn Wolters on 11/14/11.
//  Copyright (c) 2011 Glnn!. All rights reserved.
//

#import "GWAssetManager.h"

@interface GWAssetManager (private) 

-(void)nextQueueItem;
-(void)thumbnailWithAssetURL:(NSURL *)assetURL;

@end

@implementation GWAssetManager

@synthesize library = __library;
@synthesize assetQueue = __assetQueue;
@synthesize delegateQueue = __delegateQueue;
@synthesize getterQueue = __getterQueue;

+(GWAssetManager *)sharedAssetManager {
	static dispatch_once_t pred;
	static GWAssetManager *shared = nil;
	
	dispatch_once(&pred, ^{
		shared = [[GWAssetManager alloc] init];
		
	});
	return shared;
}

- (id)init {
    self = [super init];
    if (self) {
        dispatchQueue = dispatch_queue_create("com.rototray.library", NULL);
    }
    return self;
}


-(void)reloadLibrary {
	if (__library) {
		[__library release];
		__library = nil;
	}
	
	__library = [[ALAssetsLibrary alloc] init];
}

-(ALAssetsLibrary *)library {
	if (__library) {
		return __library;
	}
	
	__library = [[ALAssetsLibrary alloc] init];
	return __library;
}

-(void)fullScreenImageWithAssetURL:(NSURL *)assetURL forDelegate:(id)delegate {
	GWAssetImageGetter *imageGetter = [[[GWAssetImageGetter alloc] initWithDelegate:self] autorelease];
	
	[[self delegateQueue] addObject:delegate];
	[[self getterQueue] addObject:imageGetter];
	
	dispatch_async(dispatchQueue, ^{
		if ([assetURL isKindOfClass:[NSString class]]) {
			[imageGetter fullscreenImageForAssetURL:[NSURL URLWithString:(NSString *)assetURL]];
		}
		else {
			[imageGetter fullscreenImageForAssetURL:assetURL];		
		}		
	});
}

-(void)thumbnailWithAssetURL:(NSURL *)assetURL forDelegate:(id)delegate {	
	GWAssetImageGetter *imageGetter = [[[GWAssetImageGetter alloc] initWithDelegate:self] autorelease];
	
	[[self delegateQueue] addObject:delegate];
	[[self getterQueue] addObject:imageGetter];
	
	dispatch_async(dispatchQueue, ^{

		if ([assetURL isKindOfClass:[NSString class]]) {
			[imageGetter thumbnailForAssetURL:[NSURL URLWithString:(NSString *)assetURL]];
		}
		else {
			[imageGetter thumbnailForAssetURL:assetURL];		
		}
	});
}

-(void)imageGetter:(GWAssetImageGetter *)imageGetter finishedWithImage:(UIImage *)image forAssetURL:(NSURL *)assetURL {
	NSUInteger index = [__getterQueue indexOfObject:imageGetter];
	id delegate = nil;
	
	if ([[self delegateQueue] count]> index) {
		delegate = [[self delegateQueue] objectAtIndex:index];
	}

	dispatch_sync(dispatch_get_main_queue(), ^{
		if (delegate != nil && [delegate respondsToSelector:@selector(assetManager:didFinishWithImage:)]) {
			[delegate assetManager:self didFinishWithImage:image];
		}			
	});	

	
	if ([[self delegateQueue] count] > index && [[self getterQueue] count] > index) {
		[[self delegateQueue] removeObjectAtIndex:index];
		[[self getterQueue] removeObjectAtIndex:index];
	}	
}


-(void)imageGetter:(GWAssetImageGetter *)imageGetter failedWithError:(NSError *)error {
	//Failedc
}


-(void)cancelForDelegate:(id)delegate {
	NSUInteger index = [__delegateQueue indexOfObject:delegate];
		
	if ([[self delegateQueue] count] > index && [[self assetQueue] count] > index && [[self getterQueue] count] > index) {
		[__delegateQueue removeObjectAtIndex:index];
		[__getterQueue removeObjectAtIndex:index];
	}	
	else {
		//clean entire queue?
	}
}

-(NSMutableArray *)getterQueue {
	if (__getterQueue) {
		return __getterQueue;
	}
	
	__getterQueue = [[NSMutableArray alloc] init];
	
	return __getterQueue;
}

-(NSMutableArray *)delegateQueue {
	if (__delegateQueue) {
		return __delegateQueue;
	}
	
	__delegateQueue = [[NSMutableArray alloc] init];
	
	return __delegateQueue;
}

-(NSMutableArray *)assetQueue {
	if (__assetQueue) {
		return __assetQueue;
	}
	
	__assetQueue = [[NSMutableArray alloc] init];

	return __assetQueue;
}


@end
