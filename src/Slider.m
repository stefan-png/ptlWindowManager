//
//  Slider.m
//  Test 2
//
//  Created by Stefan Antoszko on 2021-05-24.
//

#import "Slider.h"

@implementation Slider

- (instancetype) initWithHandle:(PTLSlider*)handle X:(uint32_t)x Y:(uint32_t)y Width:(uint32_t)width Height:(uint32_t)height
{
	self = [super initWithFrame:NSMakeRect(x, y, width, height)];
	if(self)
	{
		self->handle = handle;
		self.minValue = 0;
		self.maxValue = 1;
		self.doubleValue = 0.5;
		
		self.target = self;
		self.action = @selector(callback);
	}
	return self;
}

- (void) callback
{
	if(handle->callback)
		handle->callback((PTLSliderEvent){self.doubleValue});
}


@end
