//
//  GameScene.h
//  kriel
//
//  Created by Hyoun Woo Kim on 09. 06. 17.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"

#import "resourceManager.h"

@interface GameScene : Scene 
{
}

@end

@interface GameLayer: Layer
{

	ResourceManager *resManager;
}

@end
