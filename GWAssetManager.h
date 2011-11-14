//
//  GWAssetManager.h
//  rototray
//
//  Created by Glenn Wolters on 11/14/11.
//  Copyright (c) 2011 Glnn!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GWAssetManagerDelegate.h"
#import "GWAssetImageGetter.h"

@interface GWAssetManager : NSObject <GWAssetManagerDelegate> {
	
	dispatch_queue_t dispatchQueue;
}

//@property (nonatomic, assign) id<GWAssetManagerDelegate> delegate;

@property (nonatomic, readonly) NSMutableArray *assetQueue;
@property (nonatomic, readonly) NSMutableArray *delegateQueue;
@property (nonatomic, readonly) NSMutableArray *getterQueue;


@property (nonatomic, readonly) ALAssetsLibrary *library;
-(void)reloadLibrary;

+(GWAssetManager *)sharedAssetManager;

-(void)thumbnailWithAssetURL:(NSURL *)assetURL forDelegate:(id)delegate;
-(void)fullScreenImageWithAssetURL:(NSURL *)assetURL forDelegate:(id)delegate;

-(void)cancelForDelegate:(id)delegate;

@end
