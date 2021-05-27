//
//  LevelIndicator.m
//  Test 2
//
//  Created by Stefan Antoszko on 2021-05-24.
//

#import "LevelIndicator.h"

@implementation LevelIndicator

-(instancetype) initWithHandle:(PTLLevelIndicator*)handle X:(uint32_t)x Y:(uint32_t)y Width:(uint32_t)width Height:(uint32_t)height
{
	self = [super initWithFrame:NSMakeRect(x, y, width, height)];
	if(self)
	{
		self.levelIndicatorStyle = NSLevelIndicatorStyleContinuousCapacity;
		self.editable = YES;
		self.target = self;
		self.action = @selector(callback);
	}
	return self;
}

-(void) callback
{
	NSLog(@"yesiiirrr");
}
@end
