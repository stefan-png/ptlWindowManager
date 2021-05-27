//
//  main.h
//  Test 2
//
//  Created by Stefan Antoszko on 2021-05-20.
// 

#ifndef main_h
#define main_h

#include <stdio.h>
#include <stdint.h>

#define PTLBOOL uint8_t

typedef enum PTLWindowStyleMask {
	PTL_Borderless = 0,
	PTL_Titled = 1 << 0,
	PTL_Closable = 1 << 1,
	PTL_Minimizable = 1 << 2,
	PTL_Resizable = 1 << 3,
	PTL_Default = 15	// everything OR'd together

} PTLWindowStyleMask;

typedef enum PTLKeyCodes {
	PTL_A = 0,
	PTL_B = 11,
	PTL_C = 8,
	PTL_D = 2,
	PTL_E = 14,
	PTL_F = 3,
	PTL_G = 5,
	PTL_H = 4,
	PTL_I = 34,
	PTL_J = 38,
	PTL_K = 40,
	PTL_L = 37,
	PTL_M = 46,
	PTL_N = 45,
	PTL_O = 31,
	PTL_P = 35,
	PTL_Q = 12,
	PTL_R = 15,
	PTL_S = 1,
	PTL_T = 17,
	PTL_U = 32,
	PTL_V = 9,
	PTL_W = 13,
	PTL_X = 7,
	PTL_Y = 16,
	PTL_Z = 6,
	PTL_1 = 18,
	PTL_2 = 19,
	PTL_3 = 20,
	PTL_4 = 21,
	PTL_5 = 23,
	PTL_6 = 22,
	PTL_7 = 26,
	PTL_8 = 28,
	PTL_9 = 25,
	PTL_0 = 29,
	PTL_MINUS = 27,
	PTL_PLUS = 24,
	PTL_DELETE = 51,
	PTL_LEFT_BRACKET = 33,
	PTL_RIGHT_BRACKET = 30,
	PTL_BACKSLASH = 42,
	PTL_SEMICOLON = 41,
	PTL_QUOTE = 39,
	PTL_RETURN = 36,
	PTL_ENTER = 76,
	PTL_COMMA = 43,
	PTL_PERIOD = 47,
	PTL_FORWARDSLASH = 44,
	PTL_TAB = 48,
	PTL_TILDE = 50,
	PTL_ESC = 53,
	PTL_F1 = 122,
	PTL_F2 = 120,
	PTL_F3 = 99,
	PTL_F4 = 118,
	PTL_F5 = 96,
	PTL_F6 = 97,
	PTL_F7 = 98,
	PTL_F8 = 100,
	PTL_F9 = 101,
	PTL_F10 = 109,
	PTL_F11 = 103,
	PTL_F12 = 111,
	PTL_F13 = 105,
	PTL_F14 = 107,
	PTL_F15 = 113,
	PTL_F16 = 106,
	PTL_F17 = 64,
	PTL_F18 = 79,
	PTL_F19 = 80,
	PTL_F20 = 90,
	PTL_SPACE = 49,
	PTL_LEFT = 123,
	PTL_UP = 126,
	PTL_DOWN = 125,
	PTL_RIGHT = 124,
	PTL_HOME = 115,
	PTL_PAGE_UP = 116,
	PTL_PAGE_DOWN = 121,
	PTL_END = 119,
	
	
} PTLKeyCodes;

typedef enum PTLKeyModifiers {
	PTL_NONE = 256,
	PTL_FN = 8388864,
    PTL_LEFT_SHIFT = 131330,
	PTL_LEFT_CONTROL = 262401,
	PTL_LEFT_OPTION = 524576,
	PTL_LEFT_ALT = 8913184,
	PTL_LEFT_COMMAND = 1048840,
	PTL_LEFT_APPLE = 9437448,
	PTL_CAPS_LOCK = 65792,
    PTL_RIGHT_SHIFT = 131332,
	PTL_RIGHT_COMMAND = 1048848,
	PTL_RIGHT_OPTION = 524608,
	PTL_RIGHT_APPLE = 9437456,
	PTL_RIGHT_ALT = 8913216
} PTLKeyModifiers;


typedef enum PTLButtonType {
	PTL_MomentaryChange = 5,
	PTL_MomentaryLight = 0,
	PTL_MomentaryPushIn = 7,
	PTL_OnOff = 6,
	PTL_PushOnPushOff = 1,
	PTL_Radio = 4,
	PTL_Checkbox = 3,
	PTL_Toggle = 2
} PTLButtonType;
/*
 PTL_MomentaryChange = 5,	//dont change but state swaps
 PTL_MomentaryLight = 0,	//same
 PTL_MomentaryPushIn = 7,	//text dissapears
 PTL_OnOff = 6,				//same as before
 PTL_PushOnPushOff = 1,		//text dissapears
 PTL_Radio = 4,
 PTL_Checkbox = 3,
 PTL_Toggle = 2				//text dissapears when held
 */

//application
void initApplication(void);
void pollEvents(void);
void runApplication(void);
void stopApplication(void);

//early declare so I can use it inside itself
typedef struct PTLWindow PTLWindow;

typedef struct PTLWindowCloseEvent {
	PTLWindow* handle;
} PTLWindowCloseEvent;

typedef struct PTLWindowResizeEvent {
	PTLWindow* handle;
	uint32_t width, height;
} PTLWindowResizeEvent;

typedef struct PTLWindowMoveEvent {
	PTLWindow* handle;
	uint32_t x, y;
} PTLWindowMoveEvent;

typedef struct PTLWindowMinimizeEvent {
	PTLWindow* handle;
	PTLBOOL isMinimized;
} PTLWindowMinimizeEvent;

typedef struct PTLWindowFullscreenEvent {
	PTLWindow* handle;
	PTLBOOL isMinimized;
} PTLWindowFullscreenEvent;

typedef struct PTLWindowFocusEvent {
	PTLWindow* handle;
	PTLBOOL isFocus;
} PTLWindowFocusEvent;

typedef struct PTLKeyDownEvent {
	PTLWindow* handle;
	uint8_t keyCode;
	PTLBOOL isRepeat;
	uint64_t flags;
} PTLKeyDownEvent;

typedef struct PTLKeyUpEvent {
	PTLWindow* handle;
	uint8_t keyCode;
	PTLBOOL isRepeat;
	uint64_t flags;
} PTLKeyUpEvent;

typedef struct PTLMouseMoveEvent {
	PTLWindow* handle;
	double x, y;
} PTLMouseMoveEvent;

typedef struct PTLMouseDeltaEvent {
	PTLWindow* handle;
	double x, y;
	double dx, dy;
} PTLMouseDeltaEvent;

typedef struct PTLMouseEnterEvent {
	PTLWindow* handle;
	double x, y;
	PTLBOOL entered;
} PTLMouseEnterEvent;

typedef struct PTLMouseDownEvent {
	PTLWindow* handle;
	double x, y;
	uint64_t mouseButton;
} PTLMouseDownEvent;

typedef struct PTLMouseUpEvent {
	PTLWindow* handle;
	double x, y;
	uint64_t mouseButton;
} PTLMouseUpEvent;

typedef struct PTLMouseScrollEvent {
	PTLWindow* handle;
	double x, y;
	double dx, dy;
} PTLMouseScrollEvent;

typedef struct PTLDisplayRefreshEvent {
	PTLWindow* handle;
	uint64_t delta;
	uint64_t now;
	uint64_t timeUntilDisplay;
} PTLDisplayRefreshEvent;

//UI
#define PTL_STATE_OFF 0
#define PTL_STATE_ON 1
#define PTL_STATE_MIXED -1

typedef struct PTLLabelEvent {
	const char* text;
} PTLLabelEvent;

typedef struct PTLButtonEvent {
	uint64_t state;
} PTLButtonEvent;

typedef struct PTLSliderEvent {
	double value;
} PTLSliderEvent;

//window
typedef struct PTLWindow{
	void* window;
	void* view;
	void* layer;
	void* displayLink;
	
	//window
	void (*windowCloseCallback)(PTLWindowCloseEvent e);
	void (*windowResizeCallback)(PTLWindowResizeEvent e);
	void (*windowMoveCallback)(PTLWindowMoveEvent e);
	void (*windowMinimizeCallback)(PTLWindowMinimizeEvent e);
	void (*windowFullscreenCallback)(PTLWindowFullscreenEvent e);
	void (*windowFocusCallback)(PTLWindowFocusEvent e);
	
	//key
	//keyCallback
	void (*keyDownCallback)(PTLKeyDownEvent e);
	void (*keyUpCallback)(PTLKeyUpEvent e);
	
	//mouse
	void (*mouseMoveCallback)(PTLMouseMoveEvent e);
	void (*mouseDeltaCallback)(PTLMouseDeltaEvent e);
	void (*mouseEnterCallback)(PTLMouseEnterEvent e);
	void (*mouseDownCallback)(PTLMouseDownEvent e);
	void (*mouseUpCallback)(PTLMouseUpEvent e);
	void (*scrollCallback)(PTLMouseScrollEvent e);
	
	//display link
	void (*displayRefreshCallback)(PTLDisplayRefreshEvent e);
	
} PTLWindow;

typedef struct PTLLabel{
	void* text;
	void (*callback)(PTLLabelEvent e);
} PTLLabel;

typedef struct PTLButton{
	void* button;
	void (*callback)(PTLButtonEvent e);
} PTLButton;

typedef struct PTLSlider {
	void* slider;
	void (*callback)(PTLSliderEvent e);
} PTLSlider;

typedef struct PTLLevelIndicator {
	void* levelIndicator;
} PTLLevelIndicator;

PTLWindow* createWindow(uint32_t width, uint32_t height, const char* title, PTLWindowStyleMask mask);
void setWindowHasShadow(PTLWindow* handle, PTLBOOL hasShadow);
void destroyWindow(PTLWindow* handle);

PTLLabel* createLabel(uint32_t x, uint32_t y, uint32_t width, uint32_t height);
void addLabelToWindow(PTLLabel* labelHandle, PTLWindow* handle);
void setLabelText(PTLLabel* handle, const char * text);
void setLabelIsEditable(PTLLabel* handle, PTLBOOL isEditable);
void setLabelColor(PTLLabel* handle, double r, double g, double b, double a);
void destroyLabel(PTLLabel* handle);

PTLButton* createButton(uint32_t x, uint32_t y, uint32_t width, uint32_t height);
void addButtonToWindow(PTLButton* buttonHandle, PTLWindow* handle);
void setButtonType(PTLButton* handle, PTLButtonType buttonType);
void setButtonTitle(PTLButton* handle, const char* text);
void setButtonAlternateTitle(PTLButton* handle, const char* text);
void destroyButton(PTLButton* handle);

PTLSlider* createSlider(uint32_t x, uint32_t y, uint32_t width, uint32_t height);
void addSliderToWindow(PTLSlider* sliderHandle, PTLWindow* windowHandle);
void setSliderRange(PTLSlider* handle, double min, double max);
void setSliderDiscrete(PTLSlider* handle, PTLBOOL isDiscrete);
void setSliderTickMarks(PTLSlider* handle, uint32_t numberOfTickMarks);
void destroySlider(PTLSlider* handle);

PTLLevelIndicator* createLevelIndicator(uint32_t x, uint32_t y, uint32_t width, uint32_t height);
void addLevelIndicatorToWindow(PTLLevelIndicator* levelIndicatorHandle, PTLWindow* windowHandle);
void setLevelIndicatorRange(PTLLevelIndicator* handle, double min, double max, double warning, double critical);
void setLevelIndicatorDiscrete(PTLLevelIndicator* handle, PTLBOOL isDiscrete);
void setLevelIndicatorTickMarks(PTLLevelIndicator* handle, uint32_t numberOfTickMarks, uint32_t numberOfMajorTickMarks);
void setLevelIndicatorValue(PTLLevelIndicator* handle, double value);
void destroyLevelIndicator(PTLLevelIndicator* handle);

//getters
void getWindowRect(PTLWindow* handle, uint32_t* x, uint32_t* y, uint32_t* width, uint32_t* height);
void getWindowSize(PTLWindow* handle, uint32_t* width, uint32_t* height);
void getWindowPos(PTLWindow* handle, uint32_t* x, uint32_t* y);
PTLBOOL getWindowFocused(PTLWindow* handle);
PTLBOOL getWindowFullscreen(PTLWindow* handle);
PTLBOOL getWindowMinimized(PTLWindow* handle);
PTLBOOL getWindowZoomed(PTLWindow* handle);

//setters
void setWindowRect(PTLWindow* handle, uint32_t x, uint32_t y , uint32_t width, uint32_t height);
void setWindowSize(PTLWindow* handle, uint32_t width, uint32_t height);
void setWindowPos(PTLWindow* handle, uint32_t x, uint32_t y);
void setWindowFocus(PTLWindow* handle);
void setWindowFullscreen(PTLWindow* handle, PTLBOOL isFullscreen);
void setWindowMinimized(PTLWindow* handle, PTLBOOL inMinimized);
void setWindowZoomed(PTLWindow* handle, PTLBOOL isZoomed);

void toggleFullscreen(PTLWindow* handle);
void toggleMinimize(PTLWindow* handle);
void toggleZoom(PTLWindow* handle);

void hideCursor(void);
void unhideCursor(void);
void setCursorEnabled(int isEnabled);

typedef enum VkStructureType {
	VK_STRUCTURE_TYPE_METAL_SURFACE_CREATE_INFO_EXT = 1000217000
} VkStructureType;

typedef uint32_t VkMetalSurfaceCreateFlagsEXT;


typedef struct VkMetalSurfaceCreateInfoEXT {
	VkStructureType                 sType;
	const void*                     pNext;
	VkMetalSurfaceCreateFlagsEXT    flags;
	const void*             		pLayer;
} VkMetalSurfaceCreateInfoEXT;

void getRequiredExtensions(uint32_t* count, const char** pExtensions);
VkMetalSurfaceCreateInfoEXT getSurfaceCreateInfoEXT(PTLWindow* handle);

#endif /* main_h */
