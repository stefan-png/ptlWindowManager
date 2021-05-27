#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import <QuartzCore/CVDisplayLink.h>
#import <QuartzCore/CAMetalLayer.h>

#include "ptlWindowManager.h"

CVReturn displayCallback(CVDisplayLinkRef displayLink, const CVTimeStamp *inNow, const CVTimeStamp *inOutputTime, CVOptionFlags flagsIn, CVOptionFlags *flagsOut, void *displayLinkContext);

@interface ApplicationDelegate : NSObject <NSApplicationDelegate>

-(instancetype)init;
-(void)populateMainMenu;

@end

@implementation ApplicationDelegate

-(instancetype)init
{
	self = [super init];
	return self;
}


-(void) applicationWillFinishLaunching:(NSNotification *)notification
{
	[self populateMainMenu];
}

-(void)applicationDidFinishLaunching:(NSNotification *)notification
{
@autoreleasepool {

	NSEvent* event = [NSEvent otherEventWithType:NSEventTypeApplicationDefined
										location:NSMakePoint(0, 0)
								   modifierFlags:0
										timestamp:0
									windowNumber:0
										context:nil
										subtype:0
											data1:0
											data2:0];
	[NSApp postEvent:event atStart:YES];
	
	[NSApp stop:self];
	
} // autoreleasepool
}

- (NSMenu *)applicationDockMenu:(NSApplication *)sender
{
	return nil;
}

-(void)populateMainMenu
{
	
	NSMenu* mainMenu = [[NSMenu alloc] initWithTitle:@"MainMenu"];
	
	//App title
	NSMenuItem* appMenuItem;
	NSMenu* appSubmenu;
	NSMenuItem* menuItem;
	NSMenu* appServicesMenu = [[NSMenu alloc] initWithTitle:@"Services"];

	appMenuItem = [mainMenu addItemWithTitle:@"Apple" action:NULL keyEquivalent:@""];
	appSubmenu = [[NSMenu alloc] initWithTitle:@"Apple"];
	//[NSApp performSelector:NSSelectorFromString(@"setAppleMenu:") withObject:appSubmenu];

	NSString* appName = [[NSProcessInfo processInfo] processName];
	menuItem = [appSubmenu addItemWithTitle:[NSString stringWithFormat:@"%@ %@", @"About", appName] action:@selector(orderFrontStandardAboutPanel:) keyEquivalent:@""];
	
	[appSubmenu addItem:[NSMenuItem separatorItem]];
	
	menuItem = [appSubmenu addItemWithTitle:@"Preferences..." action:nil keyEquivalent:@","];
	
	[appSubmenu addItem:[NSMenuItem separatorItem]];
	
	[appSubmenu addItem:[NSMenuItem separatorItem]];
	menuItem = [appSubmenu addItemWithTitle:@"Services" action:nil keyEquivalent:@""];
	[menuItem setSubmenu:appServicesMenu];
	menuItem = [appServicesMenu addItemWithTitle:@"No Services" action:nil keyEquivalent:@""];
	[NSApp setServicesMenu:appServicesMenu];
	
	[appSubmenu addItem:[NSMenuItem separatorItem]];
	
	menuItem = [appSubmenu addItemWithTitle:[NSString stringWithFormat:@"%@ %@", @"Hide", appName] action:@selector(hide:) keyEquivalent:@"h"];
	menuItem = [appSubmenu addItemWithTitle:@"Hide Others" action:@selector(hideOtherApplications::) keyEquivalent:@"h"];
	[menuItem setKeyEquivalentModifierMask:NSEventModifierFlagOption | NSEventModifierFlagCommand];
	menuItem = [appSubmenu addItemWithTitle:@"Show All" action:@selector(unhideAllApplications:) keyEquivalent:@""];
	
	menuItem = [appSubmenu addItemWithTitle:[NSString stringWithFormat:@"%@ %@", @"Quit", appName] action:@selector(terminate:) keyEquivalent:@"q"];

	[mainMenu setSubmenu:appSubmenu forItem:appMenuItem];
	
	//Edit
	NSMenuItem* editMenuItem;
	NSMenu* editSubmenu;
	
	editMenuItem = [mainMenu addItemWithTitle:@"Edit" action:nil keyEquivalent:@""];
	editSubmenu = [[NSMenu alloc] initWithTitle:@"Edit"];
	
	menuItem = [editSubmenu addItemWithTitle:@"Undo" action:@selector(undo:) keyEquivalent:@"z"];
	menuItem = [editSubmenu addItemWithTitle:@"Redo" action:@selector(redo:) keyEquivalent:@"z"];
	[menuItem setKeyEquivalentModifierMask:NSEventModifierFlagShift | NSEventModifierFlagCommand];
	
	[editSubmenu addItem:[NSMenuItem separatorItem]];
	
	menuItem = [editSubmenu addItemWithTitle:@"Cut" action:@selector(cut:) keyEquivalent:@"x"];
	menuItem = [editSubmenu addItemWithTitle:@"Copy" action:@selector(copy:) keyEquivalent:@"c"];
	menuItem = [editSubmenu addItemWithTitle:@"Paste" action:@selector(paste:) keyEquivalent:@"v"];
	unichar c = NSDeleteCharacter;
	menuItem = [editSubmenu addItemWithTitle:@"Delete" action:@selector(delete:) keyEquivalent:[NSString stringWithCharacters:&c length:1]];

	[editSubmenu addItem:[NSMenuItem separatorItem]];

	menuItem = [editSubmenu addItemWithTitle:@"Select All" action:@selector(selectAll:) keyEquivalent:@"a"];

	[mainMenu setSubmenu:editSubmenu forItem:editMenuItem];

	//View
	NSMenuItem* viewMenuItem;
	NSMenu* viewSubmenu;
	
	viewMenuItem = [mainMenu addItemWithTitle:@"View" action:nil keyEquivalent:@""];
	viewSubmenu = [[NSMenu alloc] initWithTitle:@"View"];
	
	menuItem = [viewSubmenu addItemWithTitle:@"Enter Fullscreen" action:@selector(toggleFullScreen:) keyEquivalent:@"f"];
	[menuItem setKeyEquivalentModifierMask:NSEventModifierFlagControl | NSEventModifierFlagCommand ];

	[mainMenu setSubmenu:viewSubmenu forItem:viewMenuItem];
	
	//Window
	NSMenuItem* windowMenuItem;
	NSMenu* windowSubmenu;
	
	windowMenuItem = [mainMenu addItemWithTitle:@"Window" action:nil keyEquivalent:@""];
	windowSubmenu = [[NSMenu alloc] initWithTitle:@"Window"];
	
	[windowSubmenu addItem:[NSMenuItem separatorItem]];
	
	menuItem = [windowSubmenu addItemWithTitle:@"Minimize" action:@selector(miniaturize:) keyEquivalent:@"m"];
	menuItem = [windowSubmenu addItemWithTitle:@"Minimize All" action:@selector(miniaturizeAll:) keyEquivalent:@"m"];
	[menuItem setKeyEquivalentModifierMask:NSEventModifierFlagOption | NSEventModifierFlagCommand];
	menuItem = [windowSubmenu addItemWithTitle:@"Zoom" action:@selector(zoom:) keyEquivalent:@""];
	
	[windowSubmenu addItem:[NSMenuItem separatorItem]];
	
	menuItem = [windowSubmenu addItemWithTitle:@"Bring All to Front" action:@selector(orderFront:) keyEquivalent:@""];

	[mainMenu setSubmenu:windowSubmenu forItem:windowMenuItem];
	
	[NSApp setMainMenu:mainMenu];
	[NSApp setWindowsMenu:windowSubmenu];
}

@end    //  ApplicationDelegate

@interface Button : NSButton
{
	PTLButton* handle;
}

-(instancetype) initWithHandle:(PTLButton*)handle X:(uint32_t)x Y:(uint32_t)y Width:(uint32_t)width Height:(uint32_t)height;
-(void) callback;

@end

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

@end    //  Button

@interface LevelIndicator : NSLevelIndicator
{
	PTLLevelIndicator* handle;
}

-(instancetype) initWithHandle:(PTLLevelIndicator*)handle X:(uint32_t)x Y:(uint32_t)y Width:(uint32_t)width Height:(uint32_t)height;

@end

@implementation LevelIndicator

-(instancetype) initWithHandle:(PTLLevelIndicator*)handle X:(uint32_t)x Y:(uint32_t)y Width:(uint32_t)width Height:(uint32_t)height
{
	self = [super initWithFrame:NSMakeRect(x, y, width, height)];
	if(self)
	{
		self.levelIndicatorStyle = NSLevelIndicatorStyleContinuousCapacity;
		self.editable = YES;
		self.target = self;
		//self.action = @selector(callback);
	}
	return self;
}

@end    //  LevelIndicator

@interface Slider : NSSlider
{
	PTLSlider* handle;
}

- (instancetype) initWithHandle:(PTLSlider*)handle X:(uint32_t)x Y:(uint32_t)y Width:(uint32_t)width Height:(uint32_t)height;
- (void) callback;

@end

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

@end    //  Slider

@interface Text : NSTextView <NSTextViewDelegate>
{
	PTLLabel* handle;
}

- (instancetype) initWithHandle:(PTLLabel*)handle X:(uint32_t)x Y:(uint32_t)y Width:(uint32_t)width Height:(uint32_t)height;

@end

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

- (void)textDidChange:(NSNotification *)notification
{
	if(handle->callback)
		handle->callback((PTLLabelEvent){[self.string UTF8String]});
}

@end    //  Text

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

@end    //  View

@interface Window : NSWindow <NSWindowDelegate>
{
	PTLWindow* handle;
}

-(instancetype)initWithHandle:(PTLWindow*)windowHandle Width:(int)width Height:(int)height Title:(NSString*)title Mask:(PTLWindowStyleMask)mask;

-(void) getWindowRectX:(uint32_t*)pX Y:(uint32_t*)pY Width:(uint32_t*)pWidth Height:(uint32_t*)pHeight;
-(void) getWindowSizeWidth:(uint32_t*)pWidth Height:(uint32_t*)pHeight;
-(void) getWindowPosX:(uint32_t*)pX Y:(uint32_t*)pY;
-(PTLBool) getWindowFocus;
-(PTLBool) getWindowFullscreen;
-(PTLBool) getWindowMinimized;
-(PTLBool) getWindowZoomed;

-(void) setWindowRectX:(uint32_t)x Y:(uint32_t)y Width:(uint32_t)width Height:(uint32_t)height;
-(void) setWindowSizeWidth:(uint32_t)width Height:(uint32_t)height;
-(void) setWindowPosX:(uint32_t)x Y:(uint32_t)y;
-(void) setWindowFocus;
-(void) setWindowFullscreen:(PTLBool)isFullscreen;
-(void) setWindowMinimized:(PTLBool)isMinimized;
-(void) setWindowZoomed:(PTLBool)isZoomed;

@end

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
-(PTLBool) getWindowFocus
{
	return self.isKeyWindow;
}
-(PTLBool) getWindowFullscreen
{
	return (self.styleMask & NSWindowStyleMaskFullScreen);
}
-(PTLBool) getWindowMinimized
{
	return self.isMiniaturized;
}
-(PTLBool) getWindowZoomed
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
-(void) setWindowFullscreen:(PTLBool)isFullscreen
{
	if(isFullscreen ^ (self.styleMask & NSWindowStyleMaskFullScreen))
	{
		[self toggleFullScreen:self];
	}
}
-(void) setWindowMinimized:(PTLBool)isMinimized
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

-(void) setWindowZoomed:(PTLBool)isZoomed
{
	if([self isZoomed] ^ isZoomed)
	{
		[self zoom:self];
	}
}

@end    //  Window

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
PTLBool getWindowFocus(PTLWindow* handle)
{
	return [((Window*)(handle->window)) getWindowFocus];
}
PTLBool getWindowFullscreen(PTLWindow* handle)
{
	return [((Window*)(handle->window)) getWindowFullscreen];
}
PTLBool getWindowMinimized(PTLWindow* handle)
{
	return [((Window*)(handle->window)) getWindowMinimized];
}
PTLBool getWindowZoomed(PTLWindow* handle)
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
void setWindowFullscreen(PTLWindow* handle, PTLBool isFullscreen)
{
	[((Window*)(handle->window)) setWindowFullscreen:isFullscreen];
}
void setWindowMinimized(PTLWindow* handle, PTLBool isMinimized)
{
	[((Window*)(handle->window)) setWindowMinimized:isMinimized];
}
void setWindowZoomed(PTLWindow* handle, PTLBool isZoomed)
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

void ptlInitApplication(void)
{
@autoreleasepool {
			
	//create the NSApp
	[NSApplication sharedApplication];
		
	//this allows the app to appear in dock, have menu, and have UI
	[NSApp setActivationPolicy:NSApplicationActivationPolicyRegular];
	
	//setup app delegate to be released at end of function.
	ApplicationDelegate* delegate = [[ApplicationDelegate alloc] init];
	[NSApp setDelegate:delegate];
	
	//run app
	[NSApp run];
}//autoreleasepool
}
void ptlPollEvents(void)
{
@autoreleasepool {
		
	for(;;)
	{
		NSEvent* event = [NSApp nextEventMatchingMask:NSEventMaskAny
													untilDate:[NSDate distantPast]
													   inMode:NSDefaultRunLoopMode
													  dequeue:YES];
		if (event == nil)
		{
			break;
		}

		[NSApp sendEvent:event];
	}
		
}	//autoreleasepool
}

void ptlRunApplication(void)
{
	[NSApp run];
}

void ptlStopApplication(void)
{
	[NSApp stop:nil];
}

PTLWindow* ptlCreateWindow(uint32_t width, uint32_t height, const char* title, PTLWindowStyleMask mask)
{
	PTLWindow* pOut = malloc(sizeof(PTLWindow));
	memset(pOut, 0, sizeof(PTLWindow));
	
	Window* window = [[Window alloc] initWithHandle:pOut Width:width Height:height Title:[NSString stringWithUTF8String:title] Mask:mask];
	View* view = [[View alloc] initWithHandle:pOut Frame:NSMakeRect(0, 0, width, height)];

	[window setContentView:view];
	[window makeKeyAndOrderFront:nil];
	[window setAcceptsMouseMovedEvents:YES];
	
	pOut->window = (void *)window;
	pOut->view = (void*)view;
	return pOut;
}
void ptlSetWindowHasShadow(PTLWindow* handle, PTLBool hasShadow)
{
	[(Window*)handle->window setHasShadow:hasShadow];
}
void ptlDestroyWindow(PTLWindow* handle)
{
	[(Window*)handle->window release];
	[(View*)handle->view release];
	CVDisplayLinkRelease(handle->displayLink);
	free(handle);
}

//label
PTLLabel* ptlCreateLabel(uint32_t x, uint32_t y, uint32_t width, uint32_t height)
{
	PTLLabel* pOut = malloc(sizeof(PTLLabel));
	memset(pOut, 0, sizeof(PTLLabel));
	
	Text* text = [[Text alloc] initWithHandle:pOut X:x Y:y Width:width Height:height];
	
	pOut->text = text;
	return pOut;
}
void ptlAddLabelToWindow(PTLLabel* plabel, PTLWindow* pwindow)
{
	[((View*)(pwindow->view)) addSubview:(NSText*)(plabel->text)];
}
void ptlSetLabelText(PTLLabel* handle, const char * text)
{
	[(Text*)(handle->text) setString:[NSString stringWithUTF8String:text]];
}
void ptlSetLabelIsEditable(PTLLabel* handle, PTLBool isEditable)
{
	[(Text*)(handle->text) setEditable:isEditable];
	[(Text*)(handle->text) setSelectable:isEditable];
	[(Text*)(handle->text) setImportsGraphics:isEditable];
	[(Text*)(handle->text) setAllowsUndo:isEditable];
	[(Text*)(handle->text) setDrawsBackground:isEditable];
}
void ptlSetLabelColor(PTLLabel* handle, double r, double g, double b, double a)
{
	[(Text*)(handle->text) setTextColor:[NSColor colorWithSRGBRed:r green:g blue:b alpha:a]];
}
void ptlDestroyLabel(PTLLabel* plabel)
{
	[(NSText*)plabel->text release];
	free(plabel);
}

PTLButton* ptlCreateButton(uint32_t x, uint32_t y, uint32_t width, uint32_t height)
{
	PTLButton* pOut = malloc(sizeof(PTLButton));
	memset(pOut, 0, sizeof(PTLButton));
	
	Button* button = [[Button alloc] initWithHandle:pOut X:x Y:y Width:width Height:height];
	pOut->button = button;
	return pOut;
}
void ptlSetButtonType(PTLButton* handle, PTLButtonType buttonType)
{
	[(Button*)handle->button setButtonType:(NSButtonType)buttonType];
}
void ptlSetButtonTitle(PTLButton* handle, const char* text)
{
	[(Button*)handle->button setTitle:[NSString stringWithUTF8String:text]];
}
void ptlSetButtonAlternateTitle(PTLButton* handle, const char* text)
{
	[(Button*)handle->button setAlternateTitle:[NSString stringWithUTF8String:text]];
}
void ptlAddButtonToWindow(PTLButton* buttonHandle, PTLWindow* handle)
{
	[((View*)(handle->view)) addSubview:(NSButton*)(buttonHandle->button)];
}
void ptlDestroyButton(PTLButton* handle)
{
	[(Button*)handle->button release];
	free(handle);
}

void ptlSetCursorEnabled(int isEnabled)
{
	CGAssociateMouseAndMouseCursorPosition(isEnabled);
	if(isEnabled)
	{
		[NSCursor unhide];
	} else
	{
		[NSCursor hide];
	}
}

void ptlHideCursor()
{
	[NSCursor hide];
}
void ptlUnhideCursor()
{
	[NSCursor unhide];
}

PTLSlider* ptlCreateSlider(uint32_t x, uint32_t y, uint32_t width, uint32_t height)
{
	PTLSlider* pOut = malloc(sizeof(PTLSlider));
	memset(pOut, 0, sizeof(PTLSlider));
	
	Slider* slider = [[Slider alloc] initWithHandle:pOut X:x Y:y Width:width Height:height];
	pOut->slider = slider;
	return pOut;
}
void ptlAddSliderToWindow(PTLSlider* sliderHandle, PTLWindow* windowHandle)
{
	[(View*)windowHandle->view addSubview:(Slider*)(sliderHandle->slider)];
}
void ptlSetSliderRange(PTLSlider* handle, double min, double max)
{
	[(Slider*)handle->slider setMinValue:min];
	[(Slider*)handle->slider setMaxValue:max];
}
void ptlSetSliderDiscrete(PTLSlider* handle, PTLBool isDiscrete)
{
	[(Slider*)handle->slider setAllowsTickMarkValuesOnly:isDiscrete];
}
void ptlSetSliderTickMarks(PTLSlider* handle, uint32_t numberOfTickMarks)
{
	[(Slider*)handle->slider setNumberOfTickMarks:numberOfTickMarks];
}
void ptlDestroySlider(PTLSlider* handle)
{
	[(Slider*)(handle->slider) release];
	free(handle);
}

PTLLevelIndicator* ptlCreateLevelIndicator(uint32_t x, uint32_t y, uint32_t width, uint32_t height)
{
	PTLLevelIndicator* pOut = malloc(sizeof(PTLLevelIndicator));
	memset(pOut, 0, sizeof(PTLLevelIndicator));
	
	LevelIndicator* indicator = [[LevelIndicator alloc] initWithHandle:pOut X:x Y:y Width:width Height:height];
	pOut->levelIndicator = indicator;
	return pOut;
}
void ptlAddLevelIndicatorToWindow(PTLLevelIndicator* levelIndicatorHandle, PTLWindow* windowHandle)
{
	[(View*)windowHandle->view addSubview:(LevelIndicator*)(levelIndicatorHandle->levelIndicator)];
}
void ptlSetLevelIndicatorRange(PTLLevelIndicator* handle, double min, double max, double warning, double critical)
{
	[(LevelIndicator*)(handle->levelIndicator) setMinValue:min];
	[(LevelIndicator*)(handle->levelIndicator) setMaxValue:max ];
	[(LevelIndicator*)(handle->levelIndicator) setWarningValue:warning];
	[(LevelIndicator*)(handle->levelIndicator) setCriticalValue:critical];
}
void ptlSetLevelIndicatorDiscrete(PTLLevelIndicator* handle, PTLBool isDiscrete)
{
	[(LevelIndicator*)(handle->levelIndicator) setLevelIndicatorStyle:(isDiscrete?NSLevelIndicatorStyleDiscreteCapacity:NSLevelIndicatorStyleContinuousCapacity)];
}
void ptlSetLevelIndicatorTickMarks(PTLLevelIndicator* handle, uint32_t numberOfTickMarks, uint32_t numberOfMajorTickMarks)
{
	[(LevelIndicator*)(handle->levelIndicator) setNumberOfTickMarks:numberOfTickMarks];
	[(LevelIndicator*)(handle->levelIndicator) setNumberOfMajorTickMarks:numberOfMajorTickMarks];
}
void ptlSetLevelIndicatorValue(PTLLevelIndicator* handle, double value)
{
	[(LevelIndicator*)(handle->levelIndicator) setDoubleValue:value];
}
void ptlDestroyLevelIndicator(PTLLevelIndicator* handle)
{
	[(LevelIndicator*)(handle->levelIndicator) release];
	free(handle);
}

void ptlGetRequiredExtensions(uint32_t* count, const char** pExtensions)
{
	*count = 2;
	if(pExtensions)
	{
		pExtensions[0] = "VK_KHR_surface";
		pExtensions[1] = "VK_EXT_metal_surface";
	}
}

VkMetalSurfaceCreateInfoEXT ptlGetSurfaceCreateInfoEXT(PTLWindow* handle)
{
	handle->layer = [CAMetalLayer layer];
	[(View*)handle->view setWantsLayer:YES];
	[(View*)handle->view setLayer:handle->layer];
	
	VkMetalSurfaceCreateInfoEXT createInfo;
	memset(&createInfo, 0, sizeof(createInfo));
	
	createInfo.sType = VK_STRUCTURE_TYPE_METAL_SURFACE_CREATE_INFO_EXT;
	createInfo.pNext = nil;
	createInfo.flags = 0;
	createInfo.pLayer = handle->layer;
	return createInfo;
}