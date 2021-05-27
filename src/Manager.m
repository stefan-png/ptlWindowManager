//
//  Manager.m
//  Test 2
//
//  Created by Stefan Antoszko on 2021-05-20.
//
#import <QuartzCore/CAMetalLayer.h>	//for CAMetalLayer
#import <QuartzCore/CoreVideo.h>

#import "main.h"

#import "ApplicationDelegate.h"
#import "Button.h"
#import "Text.h"
#import "Slider.h"
#import "LevelIndicator.h"

void initApplication(void)
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
void pollEvents(void)
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

void runApplication(void)
{
	[NSApp run];
}

void stopApplication(void)
{
	[NSApp stop:nil];
}

PTLWindow* createWindow(uint32_t width, uint32_t height, const char* title, PTLWindowStyleMask mask)
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
void setWindowHasShadow(PTLWindow* handle, PTLBOOL hasShadow)
{
	[(Window*)handle->window setHasShadow:hasShadow];
}
void destroyWindow(PTLWindow* handle)
{
	[(Window*)handle->window release];
	[(View*)handle->view release];
	CVDisplayLinkRelease(handle->displayLink);
	free(handle);
}

//label
PTLLabel* createLabel(uint32_t x, uint32_t y, uint32_t width, uint32_t height)
{
	PTLLabel* pOut = malloc(sizeof(PTLLabel));
	memset(pOut, 0, sizeof(PTLLabel));
	
	Text* text = [[Text alloc] initWithHandle:pOut X:x Y:y Width:width Height:height];
	
	pOut->text = text;
	return pOut;
}
void addLabelToWindow(PTLLabel* plabel, PTLWindow* pwindow)
{
	[((View*)(pwindow->view)) addSubview:(NSText*)(plabel->text)];
}
void setLabelText(PTLLabel* handle, const char * text)
{
	[(Text*)(handle->text) setString:[NSString stringWithUTF8String:text]];
}
void setLabelIsEditable(PTLLabel* handle, PTLBOOL isEditable)
{
	[(Text*)(handle->text) setEditable:isEditable];
	[(Text*)(handle->text) setSelectable:isEditable];
	[(Text*)(handle->text) setImportsGraphics:isEditable];
	[(Text*)(handle->text) setAllowsUndo:isEditable];
	[(Text*)(handle->text) setDrawsBackground:isEditable];
}
void setLabelColor(PTLLabel* handle, double r, double g, double b, double a)
{
	[(Text*)(handle->text) setTextColor:[NSColor colorWithSRGBRed:r green:g blue:b alpha:a]];
}
void destroyLabel(PTLLabel* plabel)
{
	[(NSText*)plabel->text release];
	free(plabel);
}

PTLButton* createButton(uint32_t x, uint32_t y, uint32_t width, uint32_t height)
{
	PTLButton* pOut = malloc(sizeof(PTLButton));
	memset(pOut, 0, sizeof(PTLButton));
	
	Button* button = [[Button alloc] initWithHandle:pOut X:x Y:y Width:width Height:height];
	pOut->button = button;
	return pOut;
}
void setButtonType(PTLButton* handle, PTLButtonType buttonType)
{
	[(Button*)handle->button setButtonType:(NSButtonType)buttonType];
}
void setButtonTitle(PTLButton* handle, const char* text)
{
	[(Button*)handle->button setTitle:[NSString stringWithUTF8String:text]];
}
void setButtonAlternateTitle(PTLButton* handle, const char* text)
{
	[(Button*)handle->button setAlternateTitle:[NSString stringWithUTF8String:text]];
}
void addButtonToWindow(PTLButton* buttonHandle, PTLWindow* handle)
{
	[((View*)(handle->view)) addSubview:(NSButton*)(buttonHandle->button)];
}
void destroyButton(PTLButton* handle)
{
	[(Button*)handle->button release];
	free(handle);
}

void setCursorEnabled(int isEnabled)
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

void hideCursor()
{
	[NSCursor hide];
}
void unhideCursor()
{
	[NSCursor unhide];
}

PTLSlider* createSlider(uint32_t x, uint32_t y, uint32_t width, uint32_t height)
{
	PTLSlider* pOut = malloc(sizeof(PTLSlider));
	memset(pOut, 0, sizeof(PTLSlider));
	
	Slider* slider = [[Slider alloc] initWithHandle:pOut X:x Y:y Width:width Height:height];
	pOut->slider = slider;
	return pOut;
}
void addSliderToWindow(PTLSlider* sliderHandle, PTLWindow* windowHandle)
{
	[(View*)windowHandle->view addSubview:(Slider*)(sliderHandle->slider)];
}
void setSliderRange(PTLSlider* handle, double min, double max)
{
	[(Slider*)handle->slider setMinValue:min];
	[(Slider*)handle->slider setMaxValue:max];
}
void setSliderDiscrete(PTLSlider* handle, PTLBOOL isDiscrete)
{
	[(Slider*)handle->slider setAllowsTickMarkValuesOnly:isDiscrete];
}
void setSliderTickMarks(PTLSlider* handle, uint32_t numberOfTickMarks)
{
	[(Slider*)handle->slider setNumberOfTickMarks:numberOfTickMarks];
}
void destroySlider(PTLSlider* handle)
{
	[(Slider*)(handle->slider) release];
	free(handle);
}

PTLLevelIndicator* createLevelIndicator(uint32_t x, uint32_t y, uint32_t width, uint32_t height)
{
	PTLLevelIndicator* pOut = malloc(sizeof(PTLLevelIndicator));
	memset(pOut, 0, sizeof(PTLLevelIndicator));
	
	LevelIndicator* indicator = [[LevelIndicator alloc] initWithHandle:pOut X:x Y:y Width:width Height:height];
	pOut->levelIndicator = indicator;
	return pOut;
}
void addLevelIndicatorToWindow(PTLLevelIndicator* levelIndicatorHandle, PTLWindow* windowHandle)
{
	[(View*)windowHandle->view addSubview:(LevelIndicator*)(levelIndicatorHandle->levelIndicator)];
}
void setLevelIndicatorRange(PTLLevelIndicator* handle, double min, double max, double warning, double critical)
{
	[(LevelIndicator*)(handle->levelIndicator) setMinValue:min];
	[(LevelIndicator*)(handle->levelIndicator) setMaxValue:max ];
	[(LevelIndicator*)(handle->levelIndicator) setWarningValue:warning];
	[(LevelIndicator*)(handle->levelIndicator) setCriticalValue:critical];
}
void setLevelIndicatorDiscrete(PTLLevelIndicator* handle, PTLBOOL isDiscrete)
{
	[(LevelIndicator*)(handle->levelIndicator) setLevelIndicatorStyle:(isDiscrete?NSLevelIndicatorStyleDiscreteCapacity:NSLevelIndicatorStyleContinuousCapacity)];
}
void setLevelIndicatorTickMarks(PTLLevelIndicator* handle, uint32_t numberOfTickMarks, uint32_t numberOfMajorTickMarks)
{
	[(LevelIndicator*)(handle->levelIndicator) setNumberOfTickMarks:numberOfTickMarks];
	[(LevelIndicator*)(handle->levelIndicator) setNumberOfMajorTickMarks:numberOfMajorTickMarks];
}
void setLevelIndicatorValue(PTLLevelIndicator* handle, double value)
{
	[(LevelIndicator*)(handle->levelIndicator) setDoubleValue:value];
}
void destroyLevelIndicator(PTLLevelIndicator* handle)
{
	[(LevelIndicator*)(handle->levelIndicator) release];
	free(handle);
}


//vulkan bits
void getRequiredExtensions(uint32_t* count, const char** pExtensions)
{
	*count = 2;
	if(pExtensions)
	{
		pExtensions[0] = "VK_KHR_surface";
		pExtensions[1] = "VK_EXT_metal_surface";
	}
}

VkMetalSurfaceCreateInfoEXT getSurfaceCreateInfoEXT(PTLWindow* handle)
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
