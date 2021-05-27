//
//  Text.m
//  Test 2
//
//  Created by Stefan Antoszko on 2021-05-23.
//

#import "Text.h"

@implementation Text

- (instancetype) initWithHandle:(PTLLabel*)handle X:(uint32_t)x Y:(uint32_t)y Width:(uint32_t)width Height:(uint32_t)height
{
	self = [super initWithFrame:NSMakeRect(x, y, width, height)];
	if(self)
	{
		self->handle = handle;
		self.delegate = self;
		self.richText = NO;
		self.horizontallyResizable = YES;
		self.verticallyResizable = NO;
	}
	return self;
}

- (void) setText:(const char*) text
{
	self.string = [NSString stringWithUTF8String:text];
}
- (void) setIsEditable:(PTLBOOL) isEditable
{
	
}

- (void)textDidChange:(NSNotification *)notification
{
	if(handle->callback)
		handle->callback((PTLLabelEvent){[self.string UTF8String]});
}

@end
