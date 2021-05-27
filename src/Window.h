//
//  Window.h
//  Test 2
//
//  Created by Stefan Antoszko on 2021-05-19.
//

#import <Cocoa/Cocoa.h>
#import <QuartzCore/CVDisplayLink.h>

#import "main.h"

@interface Window : NSWindow <NSWindowDelegate>
{
	PTLWindow* handle;
}

-(instancetype)initWithHandle:(PTLWindow*)windowHandle Width:(int)width Height:(int)height Title:(NSString*)title Mask:(PTLWindowStyleMask)mask;

-(void) getWindowRectX:(uint32_t*)pX Y:(uint32_t*)pY Width:(uint32_t*)pWidth Height:(uint32_t*)pHeight;
-(void) getWindowSizeWidth:(uint32_t*)pWidth Height:(uint32_t*)pHeight;
-(void) getWindowPosX:(uint32_t*)pX Y:(uint32_t*)pY;
-(PTLBOOL) getWindowFocus;
-(PTLBOOL) getWindowFullscreen;
-(PTLBOOL) getWindowMinimized;
-(PTLBOOL) getWindowZoomed;

-(void) setWindowRectX:(uint32_t)x Y:(uint32_t)y Width:(uint32_t)width Height:(uint32_t)height;
-(void) setWindowSizeWidth:(uint32_t)width Height:(uint32_t)height;
-(void) setWindowPosX:(uint32_t)x Y:(uint32_t)y;
-(void) setWindowFocus;
-(void) setWindowFullscreen:(PTLBOOL)isFullscreen;
-(void) setWindowMinimized:(PTLBOOL)isMinimized;
-(void) setWindowZoomed:(PTLBOOL)isZoomed;

@end

CVReturn displayCallback(CVDisplayLinkRef displayLink, const CVTimeStamp *inNow, const CVTimeStamp *inOutputTime, CVOptionFlags flagsIn, CVOptionFlags *flagsOut, void *displayLinkContext);
