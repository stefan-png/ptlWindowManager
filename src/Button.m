//
//  Button.m
//  Test 2
//
//  Created by Stefan Antoszko on 2021-05-21.
//

#import "Button.h"

@implementation Button

-(instancetype) initWithHandle:(PTLButton*)handle X:(uint32_t)x Y:(uint32_t)y Width:(uint32_t)width Height:(uint32_t)height
{
	self = [super initWithFrame:NSMakeRect(x, y, width, height)];
	if(self)
	{
		self->handle = handle;
		[self setTarget:self];
		[self setAction:@selector(callback)];
		[self setButtonType:NSButtonTypeToggle];
		[self setBezelStyle:NSBezelStyleRounded];
	}
	return self;
}
-(void) callback
{
	if(handle->callback)
		handle->callback((PTLButtonEvent){self.state});
}

@end
