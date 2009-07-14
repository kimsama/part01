//
//  GameScene.m
//  kriel
//
//  Created by Hyoun Woo Kim on 09. 06. 17.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "gameScene.h"
#import "menuScene.h"
#import "ImageLoader.h"


@implementation GameScene

-(id) init 
{
	self = [super init];
	if(self != nil)
	{
		Sprite* bg = [Sprite spriteWithFile:@"game.png"];
		[bg setPosition:ccp(240, 160)];
		[self addChild:bg z:0];
		[self addChild:[GameLayer node] z:1];
	}
	
	return self;
}

@end

@implementation GameLayer

-(id) init
{
	self = [super init];
	if (self != nil)
	{
		isTouchEnabled = YES;
	
		
		NSError *error = nil;
		NSString * dataFilePath = @"kriel_spr.xml";
		ImageLoader *imageLoader = [[ImageLoader alloc] init];
		[imageLoader parseXMLWithFile:dataFilePath parseError:&error];
		
		//// strip '.xml' file extension.
		//NSString *imgFilename = [dataFilePath stringByDeletingPathExtension];
		//// appedn '.png' file extension.
		//NSString *imgFilePath = [imgFilename stringByAppendingString:@".png"];
		
		AtlasSpriteManager *mgr = [AtlasSpriteManager spriteManagerWithFile:@"kriel_spr01.png" capacity:100];
		// FIXME: hardcoding with tag!!!
		[self addChild:mgr z:0 tag:1];
		
		
		// Create sprite resource manager.
		resManager = [[ResourceManager alloc] init];
		
        // Access to the sprite info array which contains all information on the sprites.
		NSMutableArray *spr = imageLoader.spriteArray;
		
		for (int i=0; i < spr.count; i++)
		{
			SpriteElement *element = [spr objectAtIndex:i];
			
			// create AtlasSprite with the parsed key values withe the given AtlasSpriteManager
			AtlasSprite *sprite = [AtlasSprite spriteWithRect:CGRectMake(element.x, element.y, element.w, element.h) spriteManager: mgr];
			
			sprite.position = ccp(130, 40);
			
			// Add the created sprtite to the sprite manager.
			NSString* sprID = [resManager.resourceID valueForKey:element.fileName];
			[mgr addChild:sprite z:1 tag:[sprID intValue]];
		}
		
		// BEGIN OF TEST CODE!!! 
		// the following code retrieves "hero_left1.png" sprite
		NSString* resID = [resManager.resourceID objectForKey:@"hero_left1.png"];
		int myTag = [resID intValue];
		AtlasSprite* mySprite = [mgr getChildByTag:myTag];
		
		mySprite.position = ccp(150, 100);
		// END OF TEST CODE!!!
		
		[imageLoader release];
	}
	
	return self;
}

-(BOOL) ccTouchesEnabled:(NSSet*)touches withEvent: (UIEvent*)event
{
	MenuScene* ms = [MenuScene node];
	[[Director sharedDirector] replaceScene:ms];
	return kEventHandled;
}

-(void) dealloc
{
	[resManager release];
	
	[super dealloc];
}

@end
