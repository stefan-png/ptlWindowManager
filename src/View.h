//
//  View.h
//  Test 2
//
//  Created by Stefan Antoszko on 2021-05-19.
//

#import <Cocoa/Cocoa.h>
#import "main.h"

@interface View : NSView
{
	PTLWindow* handle;
}

-(instancetype) initWithHandle:(PTLWindow*) windowHandle Frame:(NSRect)frame;

- (BOOL)acceptsFirstMouse:(NSEvent *)event;

- (void)keyDown:(NSEvent *)event;
- (void)keyUp:(NSEvent *)event;

- (void)mouseEntered:(NSEvent *)event;
- (void)mouseExited:(NSEvent *)event;

- (void)mouseDown:(NSEvent *)event;
- (void)mouseMoved:(NSEvent *)event;
- (void)mouseUp:(NSEvent *)event;
- (void)rightMouseDown:(NSEvent *)event;
- (void)rightMouseUp:(NSEvent *)event;
- (void)otherMouseDown:(NSEvent *)event;
- (void)otherMouseUp:(NSEvent *)event;

- (void)scrollWheel:(NSEvent *)event;

@end

