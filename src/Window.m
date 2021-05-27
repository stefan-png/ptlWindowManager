//
//  Window.m
//  Test 2
//
//  Created by Stefan Antoszko on 2021-05-19.
//
#import "Window.h"
#import "View.h"
#import "main.h"


@implementation Window

-(instancetype)initWithHandle:(PTLWindow*)windowHandle Width:(int)width Height:(int)height Title:(NSString*)title Mask:(PTLWindowStyleMask)mask
{
	NSRect windowSize = NSMakeRect(0, 0, width, height);
	
	self = [super initWithContentRect:windowSize styleMask:(NSWindowStyleMask)mask backing:NSBackingStoreBuffered defer:YES];
	if(self) {
		static int windowIndex = 0;
		
		handle = windowHandle;
		self.title = title;
		self.hasShadow = YES;
		self.delegate = self;
		[self center];
		//only first window gets a display link
		if(windowIndex == 0)
		{
			CVDisplayLinkRef ref;
			CVDisplayLinkCreateWithActiveCGDisplays(&ref);
			CVDisplayLinkSetOutputCallback(ref, displayCallback, handle);
			CVDisplayLinkStart(ref);
			self->handle->displayLink = ref;
		}
		windowIndex++;
	}
	return self;
}

//screen
- (void)windowDidChangeScreen:(NSNotification *)notification
{
	//set display link displayID to the one which intersects with new screen.
	if(handle->displayLink) {
		CGDirectDisplayID display;
		uint32_t count;
		CGGetDisplaysWithPoint(self.frame.origin, 1, &display, &count);
		CVDisplayLinkSetCurrentCGDisplay(((CVDisplayLinkRef)handle->displayLink), display);
	}
}

//callbacks
- (void)windowDidResize:(NSNotification *)notification
{
	if(handle->windowResizeCallback)
		handle->windowResizeCallback((PTLWindowResizeEvent){handle, (uint32_t)self.frame.size.width, (uint32_t)self.frame.size.height});
	[self.contentView setFrameSize:self.frame.size];
}
- (void)windowDidMiniaturize:(NSNotification *)notification
{
	if(handle->windowMinimizeCallback)
		handle->windowMinimizeCallback((PTLWindowMinimizeEvent){handle, 1});
}
- (void)windowDidDeminiaturize:(NSNotification *)notification
{
	if(handle->windowMinimizeCallback)
		handle->windowMinimizeCallback((PTLWindowMinimizeEvent){handle, 0});
}
- (void)windowDidEnterFullScreen:(NSNotification *)notification
{
	if(handle->windowFullscreenCallback)
		handle->windowFullscreenCallback((PTLWindowFullscreenEvent){handle, 1});
	[self.contentView setFrameSize:self.frame.size];
}
- (void)windowDidExitFullScreen:(NSNotification *)notification
{
	if(handle->windowFullscreenCallback)
		handle->windowFullscreenCallback((PTLWindowFullscreenEvent){handle, 0});
	[self.contentView setFrameSize:self.frame.size];
}
- (BOOL)windowShouldClose:(NSWindow *)sender
{
	if(handle->windowCloseCallback)
		handle->windowCloseCallback((PTLWindowCloseEvent){handle});

	[NSApp removeWindowsItem:self];
	return YES;
}
-(void)windowDidBecomeKey:(NSNotification *)notification
{
	if(handle->windowFocusCallback)
		handle->windowFocusCallback((PTLWindowFocusEvent){handle, 1});
}
-(void)windowDidResignKey:(NSNotification *)notification
{
	if(handle->windowFocusCallback)
		handle->windowFocusCallback((PTLWindowFocusEvent){handle, 0});
}

-(void)windowDidMove:(NSNotification *)notification
{
	if(handle->windowMoveCallback)
		handle->windowMoveCallback((PTLWindowMoveEvent){handle, (uint32_t)self.frame.origin.x, (uint32_t)self.frame.origin.y});
}

//getters
-(void) getWindowSizeWidth:(uint32_t*)pWidth Height:(uint32_t*)pHeight
{
	*pWidth = self.frame.size.width;
	*pHeight = self.frame.size.height;
}
-(void) getWindowPosX:(uint32_t*)pX Y:(uint32_t*)pY
{
	*pX = self.frame.origin.x;
	*pY = self.frame.origin.y;
}
-(void) getWindowRectX:(uint32_t*)pX Y:(uint32_t*)pY Width:(uint32_t*)pWidth Height:(uint32_t*)pHeight
{
	[self getWindowPosX:pX Y:pY];
	[self getWindowSizeWidth:pWidth Height:pHeight];
}
-(PTLBOOL) getWindowFocus
{
	return self.isKeyWindow;
}
-(PTLBOOL) getWindowFullscreen
{
	return (self.styleMask & NSWindowStyleMaskFullScreen);
}
-(PTLBOOL) getWindowMinimized
{
	return self.isMiniaturized;
}
-(PTLBOOL) getWindowZoomed
{
	return self.isZoomed;
}

//setters
-(void) setWindowRectX:(uint32_t)x Y:(uint32_t)y Width:(uint32_t)width Height:(uint32_t)height
{
	[self setFrame: NSMakeRect(x, y, width, height) display: YES animate: YES];
}
-(void) setWindowSizeWidth:(uint32_t)width Height:(uint32_t)height
{
	[self setWindowRectX:self.frame.origin.x Y:self.frame.origin.y Width:width Height:height];
}
-(void) setWindowPosX:(uint32_t)x Y:(uint32_t)y
{
	[self setWindowRectX:x Y:y Width:self.frame.size.width Height:self.frame.size.height];
}

-(void) setWindowFocus
{
	[self makeKeyAndOrderFront:self];
}
-(void) setWindowFullscreen:(PTLBOOL)isFullscreen
{
	if(isFullscreen ^ (self.styleMask & NSWindowStyleMaskFullScreen))
	{
		[self toggleFullScreen:self];
	}
}
-(void) setWindowMinimized:(PTLBOOL)isMinimized
{
	if(isMinimized)
	{
		[self miniaturize:self];
	}
	else
	{
		[self deminiaturize:self];
	}
}

-(void) setWindowZoomed:(PTLBOOL)isZoomed
{
	if([self isZoomed] ^ isZoomed)
	{
		[self zoom:self];
	}
}

@end


//c
void getWindowRect(PTLWindow* handle, uint32_t* px, uint32_t* py, uint32_t* pwidth, uint32_t* pheight)
{
	[((Window*)(handle->window)) getWindowRectX:px Y:py Width:pwidth Height:pheight];
}
void getWindowSize(PTLWindow* handle, uint32_t* pwidth, uint32_t* pheight)
{
	[((Window*)(handle->window)) getWindowSizeWidth:pwidth Height:pheight];
}
void getWindowPos(PTLWindow* handle, uint32_t* px, uint32_t* py)
{
	[((Window*)(handle->window)) getWindowPosX:px Y:py];
}
PTLBOOL getWindowFocus(PTLWindow* handle)
{
	return [((Window*)(handle->window)) getWindowFocus];
}
PTLBOOL getWindowFullscreen(PTLWindow* handle)
{
	return [((Window*)(handle->window)) getWindowFullscreen];
}
PTLBOOL getWindowMinimized(PTLWindow* handle)
{
	return [((Window*)(handle->window)) getWindowMinimized];
}
PTLBOOL getWindowZoomed(PTLWindow* handle)
{
	return [((Window*)(handle->window)) getWindowZoomed];
}

void setWindowRect(PTLWindow* handle, uint32_t x, uint32_t y, uint32_t width, uint32_t height)
{
	[((Window*)(handle->window)) setWindowRectX:x Y:y Width:width Height:height];
}
void setWindowSize(PTLWindow* handle, uint32_t width, uint32_t height)
{
	[(Window*)handle->window setWindowSizeWidth:width Height:height];
}
void setWindowPos(PTLWindow* handle, uint32_t x, uint32_t y)
{
	[((Window*)(handle->window)) setWindowPosX:x Y:y];
}
void setWindowFocus(PTLWindow* handle)
{
	[((Window*)(handle->window)) setWindowFocus];
}
void setWindowFullscreen(PTLWindow* handle, PTLBOOL isFullscreen)
{
	[((Window*)(handle->window)) setWindowFullscreen:isFullscreen];
}
void setWindowMinimized(PTLWindow* handle, PTLBOOL isMinimized)
{
	[((Window*)(handle->window)) setWindowMinimized:isMinimized];
}
void setWindowZoomed(PTLWindow* handle, PTLBOOL isZoomed)
{
	[((Window*)(handle->window)) setWindowZoomed:isZoomed];
}

void toggleFullscreen(PTLWindow* handle)
{
	[((Window*)(handle->window)) toggleFullScreen:nil];
}
void toggleMinimize(PTLWindow* handle)
{
	if([((Window*)(handle->window)) isMiniaturized])
	{
		[((Window*)(handle->window)) deminiaturize:nil];
	}
	else
	{
		[((Window*)(handle->window)) miniaturize:nil];
	}
}
void toggleZoom(PTLWindow* handle)
{
	[((Window*)(handle->window)) zoom:nil];
}

CVReturn displayCallback(CVDisplayLinkRef displayLink, const CVTimeStamp *inNow, const CVTimeStamp *inOutputTime, CVOptionFlags flagsIn, CVOptionFlags *flagsOut, void *displayLinkContext)
{
	static uint64_t lastTime;
	if(((PTLWindow*)displayLinkContext)->displayRefreshCallback)
	{
		((PTLWindow*)displayLinkContext)->displayRefreshCallback((PTLDisplayRefreshEvent){(PTLWindow*)displayLinkContext, (inNow->hostTime - lastTime), inNow->hostTime, (inOutputTime->hostTime - inNow->hostTime)});
	}
	lastTime = inNow->hostTime;
	return kCVReturnSuccess;
}
