#ifndef ptlWindowManager_h
#define ptlWindowManager_h

#ifdef __cplusplus
extern "C" {
#endif

#include <stdint.h> //for uint32_t

typedef uint8_t PTLBool;

#define PTL_TRUE    1
#define PTL_FALSE   0

typedef uint32_t PTLWindowStyleMask;
typedef uint64_t PTLKeyModifierMask;

typedef uint32_t VkMetalSurfaceCreateFlagsEXT;

typedef enum VkStructureType {
	VK_STRUCTURE_TYPE_METAL_SURFACE_CREATE_INFO_EXT = 1000217000
} VkStructureType; 

typedef enum PTLWindowStyleMaskBits {
    PTL_WINDOW_STYLE_BORDERLESS_BIT     = 0,
	PTL_WINDOW_STYLE_TITLED_BIT         = 0x1,
	PTL_WINDOW_STYLE_CLOSABLE_BIT       = 0x2,
	PTL_WINDOW_STYLE_MINIMIZABLE_BIT    = 0x4,
	PTL_WINDOW_STYLE_RESIZABLE_BIT      = 0x8,
    // All other bits OR'd together
	PTL_WINDOW_STYLE_DEFAULT_BIT        = 0xF	

} PTLWindowStyleMaskBits;

typedef enum PTLKeyCodes {
	PTL_KEY_A               = 0,
	PTL_KEY_B               = 11,
	PTL_KEY_C               = 8,
	PTL_KEY_D               = 2,
	PTL_KEY_E               = 14,
	PTL_KEY_F               = 3,
	PTL_KEY_G               = 5,
	PTL_KEY_H               = 4,
	PTL_KEY_I               = 34,
	PTL_KEY_J               = 38,
	PTL_KEY_K               = 40,
	PTL_KEY_L               = 37,
	PTL_KEY_M               = 46,
	PTL_KEY_N               = 45,
	PTL_KEY_O               = 31,
	PTL_KEY_P               = 35,
	PTL_KEY_Q               = 12,
	PTL_KEY_R               = 15,
	PTL_KEY_S               = 1,
	PTL_KEY_T               = 17,
	PTL_KEY_U               = 32,
	PTL_KEY_V               = 9,
	PTL_KEY_W               = 13,
	PTL_KEY_X               = 7,
	PTL_KEY_Y               = 16,
	PTL_KEY_Z               = 6,
	PTL_KEY_1               = 18,
	PTL_KEY_2               = 19,
	PTL_KEY_3               = 20,
	PTL_KEY_4               = 21,
	PTL_KEY_5               = 23,
	PTL_KEY_6               = 22,
	PTL_KEY_7               = 26,
	PTL_KEY_8               = 28,
	PTL_KEY_9               = 25,
	PTL_KEY_0               = 29,
	PTL_KEY_MINUS           = 27,
	PTL_KEY_PLUS            = 24,
	PTL_KEY_DELETE          = 51,
	PTL_KEY_LEFT_BRACKET    = 33,
	PTL_KEY_RIGHT_BRACKET   = 30,
	PTL_KEY_BACKSLASH       = 42,
	PTL_KEY_SEMICOLON       = 41,
	PTL_KEY_QUOTE           = 39,
	PTL_KEY_RETURN          = 36,
	PTL_KEY_ENTER           = 76,
	PTL_KEY_COMMA           = 43,
	PTL_KEY_PERIOD          = 47,
	PTL_KEY_FORWARDSLASH    = 44,
	PTL_KEY_TAB             = 48,
	PTL_KEY_TILDE           = 50,
	PTL_KEY_ESC             = 53,
	PTL_KEY_F1              = 122,
	PTL_KEY_F2              = 120,
	PTL_KEY_F3              = 99,
	PTL_KEY_F4              = 118,
	PTL_KEY_F5              = 96,
	PTL_KEY_F6              = 97,
	PTL_KEY_F7              = 98,
	PTL_KEY_F8              = 100,
	PTL_KEY_F9              = 101,
	PTL_KEY_F10             = 109,
	PTL_KEY_F11             = 103,
	PTL_KEY_F12             = 111,
	PTL_KEY_F13             = 105,
	PTL_KEY_F14             = 107,
	PTL_KEY_F15             = 113,
	PTL_KEY_F16             = 106,
	PTL_KEY_F17             = 64,
	PTL_KEY_F18             = 79,
	PTL_KEY_F19             = 80,
	PTL_KEY_F20             = 90,
	PTL_KEY_SPACE           = 49,
	PTL_KEY_LEFT            = 123,
	PTL_KEY_UP              = 126,
	PTL_KEY_DOWN            = 125,
	PTL_KEY_RIGHT           = 124,
	PTL_KEY_HOME            = 115,
	PTL_KEY_PAGE_UP         = 116,
	PTL_KEY_PAGE_DOWN       = 121,
	PTL_KEY_END             = 119,
} PTLKeyCodes;

typedef enum PTLKeyModifierMaskBits {
    PTL_KEY_MOD_ALPHA_SHIFT_BIT     = 0x010000,
    PTL_KEY_MOD_SHIFT_BIT           = 0x020000,
    PTL_KEY_MOD_CONTROL_BIT         = 0x040000,
    PTL_KEY_MOD_ALTERNATE_BIT       = 0x080000,
    PTL_KEY_MOD_COMMAND_BIT         = 0x100000,
    PTL_KEY_MOD_NUMERIC_PAD_BIT     = 0x200000,
    PTL_KEY_MOD_HELP_BIT            = 0x400000,
    PTL_KEY_MOD_SECONDARY_FN_BIT    = 0x800000,
    PTL_KEY_MOD_NON_COALESCED_BIT   = 0x000100,
} PTLKeyModifierMaskBits;

typedef enum PTLButtonType {
	PTL_BUTTON_TYPE_MOMENTARY_CHANGE 	= 5,
	PTL_BUTTON_TYPE_MOMENTARY_LIGHT 	= 0,
	PTL_BUTTON_TYPE_MOMENTARY_PUSH_IN 	= 7,
	PTL_BUTTON_TYPE_ON_OFF				= 6,
	PTL_BUTTON_TYPE_PUSH_ON_PUSH_OFF 	= 1,
	PTL_BUTTON_TYPE_RADIO 				= 4,
	PTL_BUTTON_TYPE_CHECKBOX 			= 3,
	PTL_BUTTON_TYPE_TOGGLE 				= 2
} PTLButtonType;

typedef enum PTLButtonState {
	PTL_BUTTON_STATE_OFF = 0,
	PTL_BUTTON_STATE_ON = 1,
	PTL_BUTTON_STATE_MIXED = -1
} PTLButtonState;

//event types
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
	PTLBool isMinimized;
} PTLWindowMinimizeEvent;

typedef struct PTLWindowFullscreenEvent {
	PTLWindow* handle;
	PTLBool isMinimized;
} PTLWindowFullscreenEvent;

typedef struct PTLWindowFocusEvent {
	PTLWindow* handle;
	PTLBool isFocus;
} PTLWindowFocusEvent;

typedef struct PTLKeyDownEvent {
	PTLWindow* handle;
	uint8_t keyCode;
	PTLBool isRepeat;
	uint64_t flags;
} PTLKeyDownEvent;

typedef struct PTLKeyUpEvent {
	PTLWindow* handle;
	uint8_t keyCode;
	PTLBool isRepeat;
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
	PTLBool entered;
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

typedef struct PTLLabelEvent {
	const char* text;
} PTLLabelEvent;

typedef struct PTLButtonEvent {
	PTLButtonState state;
} PTLButtonEvent;

typedef struct PTLSliderEvent {
	double value;
} PTLSliderEvent;

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

//application functions
void ptlInitApplication(void);
void ptlPollEvents(void);
void ptlRunApplication(void);
void ptlStopApplication(void);

PTLWindow* ptlCreateWindow(uint32_t width, uint32_t height, const char* title, PTLWindowStyleMask mask);
void ptlSetWindowHasShadow(PTLWindow* handle, PTLBool hasShadow);
void ptlDestroyWindow(PTLWindow* handle);

PTLLabel* ptlCreateLabel(uint32_t x, uint32_t y, uint32_t width, uint32_t height);
void ptlAddLabelToWindow(PTLLabel* labelHandle, PTLWindow* handle);
void ptlSetLabelText(PTLLabel* handle, const char * text);
void ptlSetLabelIsEditable(PTLLabel* handle, PTLBool isEditable);
void ptlSetLabelColor(PTLLabel* handle, double r, double g, double b, double a);
void ptlDestroyLabel(PTLLabel* handle);

PTLButton* createButton(uint32_t x, uint32_t y, uint32_t width, uint32_t height);
void ptlAddButtonToWindow(PTLButton* buttonHandle, PTLWindow* handle);
void ptlSetButtonType(PTLButton* handle, PTLButtonType buttonType);
void ptlSetButtonTitle(PTLButton* handle, const char* text);
void ptlSetButtonAlternateTitle(PTLButton* handle, const char* text);
void ptlDestroyButton(PTLButton* handle);

PTLSlider* createSlider(uint32_t x, uint32_t y, uint32_t width, uint32_t height);
void ptlAddSliderToWindow(PTLSlider* sliderHandle, PTLWindow* windowHandle);
void ptlSetSliderRange(PTLSlider* handle, double min, double max);
void ptlSetSliderDiscrete(PTLSlider* handle, PTLBool isDiscrete);
void ptlSetSliderTickMarks(PTLSlider* handle, uint32_t numberOfTickMarks);
void ptlDestroySlider(PTLSlider* handle);

PTLLevelIndicator* createLevelIndicator(uint32_t x, uint32_t y, uint32_t width, uint32_t height);
void ptlAddLevelIndicatorToWindow(PTLLevelIndicator* levelIndicatorHandle, PTLWindow* windowHandle);
void ptlSetLevelIndicatorRange(PTLLevelIndicator* handle, double min, double max, double warning, double critical);
void ptlSetLevelIndicatorDiscrete(PTLLevelIndicator* handle, PTLBool isDiscrete);
void ptlSetLevelIndicatorTickMarks(PTLLevelIndicator* handle, uint32_t numberOfTickMarks, uint32_t numberOfMajorTickMarks);
void ptlSetLevelIndicatorValue(PTLLevelIndicator* handle, double value);
void ptlDestroyLevelIndicator(PTLLevelIndicator* handle);

//getters
void ptlGetWindowRect(PTLWindow* handle, uint32_t* x, uint32_t* y, uint32_t* width, uint32_t* height);
void ptlGetWindowSize(PTLWindow* handle, uint32_t* width, uint32_t* height);
void ptlGetWindowPos(PTLWindow* handle, uint32_t* x, uint32_t* y);
PTLBool ptlGetWindowFocused(PTLWindow* handle);
PTLBool ptlGetWindowFullscreen(PTLWindow* handle);
PTLBool ptlGetWindowMinimized(PTLWindow* handle);
PTLBool ptlGetWindowZoomed(PTLWindow* handle);

//ptlSetters
void ptlSetWindowRect(PTLWindow* handle, uint32_t x, uint32_t y , uint32_t width, uint32_t height);
void ptlSetWindowSize(PTLWindow* handle, uint32_t width, uint32_t height);
void ptlSetWindowPos(PTLWindow* handle, uint32_t x, uint32_t y);
void ptlSetWindowFocus(PTLWindow* handle);
void ptlSetWindowFullscreen(PTLWindow* handle, PTLBool isFullscreen);
void ptlSetWindowMinimized(PTLWindow* handle, PTLBool inMinimized);
void ptlSetWindowZoomed(PTLWindow* handle, PTLBool isZoomed);

void ptlToggleFullscreen(PTLWindow* handle);
void ptlToggleMinimize(PTLWindow* handle);
void ptlToggleZoom(PTLWindow* handle);

void ptlHideCursor(void);
void ptlUnhideCursor(void);
void ptlSetCursorEnabled(int isEnabled);

//vulkan
typedef struct VkMetalSurfaceCreateInfoEXT {
	VkStructureType                 sType;
	const void*                     pNext;
	VkMetalSurfaceCreateFlagsEXT    flags;
	const void*             		pLayer;
} VkMetalSurfaceCreateInfoEXT;

void getRequiredExtensions(uint32_t* count, const char** pExtensions);
VkMetalSurfaceCreateInfoEXT getSurfaceCreateInfoEXT(PTLWindow* handle);

#ifdef __cplusplus
}
#endif

#endif  //ifdef ptlWindowManager