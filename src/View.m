//
//  View.m
//  Test 2
//
//  Created by Stefan Antoszko on 2021-05-19.
//

#import "View.h"

@implementation View

-(instancetype) initWithHandle:(PTLWindow*) windowHandle Frame:(NSRect)frame {
	self = [super initWithFrame:frame];
	if(self)
	{
		handle = windowHandle;
		//for mouseEnter/Exit
		[self addTrackingRect:frame owner:self userData:nil assumeInside:NO];
	}
	return self;
}

-(BOOL)acceptsFirstResponder
{
	return YES;
}

- (BOOL)acceptsFirstMouse:(NSEvent *)event
{
	return YES;
}
- (void)updateTrackingAreas
{
	for(int i = 0; i < self.trackingAreas.count; i++)
	{
		[self removeTrackingArea:self.trackingAreas[i]];
	}
	[self addTrackingRect:self.frame owner:self userData:nil assumeInside:NO];
}

- (void)keyDown:(NSEvent *)event
{
	if(handle->keyDownCallback) {
		PTLKeyDownEvent e = {handle, [event keyCode], [event isARepeat], [event modifierFlags]};
		handle->keyDownCallback((PTLKeyDownEvent)e);
	}
}
- (void)keyUp:(NSEvent *)event
{
	if(handle->keyUpCallback)
		handle->keyUpCallback((PTLKeyUpEvent){handle, [event keyCode], [event isARepeat], [event modifierFlags]});
}

- (void)mouseEntered:(NSEvent *)event
{
	if(handle->mouseEnterCallback)
		handle->mouseEnterCallback((PTLMouseEnterEvent){handle, [event locationInWindow].x, [event locationInWindow].y, 1});
}
- (void)mouseExited:(NSEvent *)event
{
	if(handle->mouseEnterCallback)
		handle->mouseEnterCallback((PTLMouseEnterEvent){handle, [event locationInWindow].x, [event locationInWindow].y, 0});
}

- (void)mouseDown:(NSEvent *)event
{
	if(handle->mouseDownCallback)
		handle->mouseDownCallback((PTLMouseDownEvent){handle, [event locationInWindow].x, [event locationInWindow].y, [event buttonNumber]});
}
- (void)mouseMoved:(NSEvent *)event
{
	if(handle->mouseMoveCallback)
		handle->mouseMoveCallback((PTLMouseMoveEvent){handle, [event locationInWindow].x, [event locationInWindow].y});
	
	if(handle->mouseDeltaCallback)
		handle->mouseDeltaCallback((PTLMouseDeltaEvent){handle, [event locationInWindow].x, [event locationInWindow].y, [event deltaX], [event deltaY]});
}
- (void) mouseDragged:(NSEvent *)event
{
	[self mouseMoved:event];
}
- (void)mouseUp:(NSEvent *)event
{
	if(handle->mouseUpCallback)
		handle->mouseUpCallback((PTLMouseUpEvent){handle, [event locationInWindow].x, [event locationInWindow].y, [event buttonNumber]});
}
- (void)rightMouseDown:(NSEvent *)event
{
	if(handle->mouseDownCallback)
		handle->mouseDownCallback((PTLMouseDownEvent){handle, [event locationInWindow].x, [event locationInWindow].y, [event buttonNumber]});
}
- (void)rightMouseDragged:(NSEvent *)event
{
	[self mouseMoved:event];
}
- (void)rightMouseUp:(NSEvent *)event
{
	if(handle->mouseUpCallback)
		handle->mouseUpCallback((PTLMouseUpEvent){handle, [event locationInWindow].x, [event locationInWindow].y, [event buttonNumber]});
}
- (void)otherMouseDown:(NSEvent *)event
{
	if(handle->mouseDownCallback)
		handle->mouseDownCallback((PTLMouseDownEvent){handle, [event locationInWindow].x, [event locationInWindow].y, [event buttonNumber]});
}
- (void)otherMouseDragged:(NSEvent *)event
{
	[self mouseMoved:event];
}
- (void)otherMouseUp:(NSEvent *)event
{
	if(handle->mouseUpCallback)
		handle->mouseUpCallback((PTLMouseUpEvent){handle, [event locationInWindow].x, [event locationInWindow].y, [event buttonNumber]});
}

- (void)scrollWheel:(NSEvent *)event
{
	if(handle->scrollCallback)
	{
		double dx =[event scrollingDeltaX];
		double dy =[event scrollingDeltaY];
		if(![event hasPreciseScrollingDeltas])
		{
			dx *= 0.1;
			dy *= 0.1;
		}
		handle->scrollCallback((PTLMouseScrollEvent){handle, [event locationInWindow].x, [event locationInWindow].y, dx, dy});
	}
}


@end
