//
//  main.c
//  Test 2
//
//  Created by Stefan Antoszko on 2021-05-20.
//gcc main.c Manager.m ApplicationDelegate.m Button.m LevelIndicator.m Slider.m Text.m View.m Window.m -o out/main -framework Foundation -framework Cocoa -framework QuartzCore
#define PTL_VULKAN
#include "main.h"
#include <string.h>
#include <stdlib.h>

int running = 1;

void mouseMove(PTLMouseDeltaEvent);
void mouseDown(PTLMouseDownEvent);
void _windowWillClose(PTLWindowCloseEvent);

void keyDown(PTLKeyDownEvent);
void mouseEntered(PTLMouseEnterEvent);

void buttonFunction(PTLButtonEvent);

void textChanged(PTLLabelEvent e);
void sliderChanged(PTLSliderEvent e);

void refreshDisplay(PTLDisplayRefreshEvent e);

PTLLabel* l1;
PTLWindow* w2;
PTLLevelIndicator* i1;

int main(int argc, char *argv[]) {
			
	initApplication();
	
	PTLWindow* w1 = createWindow(400, 300, "window 1", (PTL_Default));
	w2 = createWindow(200, 200, "window 2", (PTL_Closable | PTL_Titled));

	w1->windowCloseCallback = _windowWillClose;

	w1->mouseDownCallback = mouseDown;
	w1->mouseDeltaCallback = mouseMove;

	w1->keyDownCallback = keyDown;

	w1->displayRefreshCallback = refreshDisplay;
	
	l1 = createLabel(20, 10, 200, 20);
	addLabelToWindow(l1, w1);
	l1->callback = textChanged;
	
	PTLButton* b1 = createButton(300, 10, 100, 24);
	PTLButton* b2 = createButton(300, 45, 100, 20);
	b1->callback = buttonFunction;
	b2->callback = buttonFunction;
	addButtonToWindow(b1, w1);
	addButtonToWindow(b2, w1);

	setButtonTitle(b1, "SetColor");
	setButtonAlternateTitle(b1, "alternate");
	setButtonTitle(b2, "Open");
	setButtonAlternateTitle(b2, "hahahahah");
	
	PTLSlider* s1 = createSlider(20, 60, 250, 20);
	addSliderToWindow(s1, w1);
	setSliderTickMarks(s1, 11);
	s1->callback = sliderChanged;
	setSliderRange(s1, -5, 5);
	
	i1 = createLevelIndicator(20, 90, 250, 15);
	setLevelIndicatorRange(i1, -5, 5, 1, 3);
	setLevelIndicatorTickMarks(i1, 11, 5);
	addLevelIndicatorToWindow(i1, w1);
	
	uint32_t count;
	getRequiredExtensions(&count, NULL);
	const char* extensions[count];
	getRequiredExtensions(&count, extensions);
	printf("extensions are: \n\t%s\n\t%s\n", extensions[0], extensions[1]);
	getSurfaceCreateInfoEXT(w1);

	printf("none %x\n", PTL_NONE);
	printf("fn %x\n", PTL_FN);
	printf("shift %x %x\n", PTL_LEFT_SHIFT, PTL_RIGHT_SHIFT);
	printf("cntrl %x\n", PTL_LEFT_CONTROL);
	printf("command %x %x\n", PTL_LEFT_COMMAND, PTL_RIGHT_COMMAND);
	printf("option %x %x\n", PTL_LEFT_OPTION, PTL_RIGHT_OPTION);
	printf("alt %x %x\n", PTL_LEFT_ALT, PTL_RIGHT_ALT);
	printf("apple %x %x\n\n", PTL_LEFT_APPLE, PTL_RIGHT_APPLE);
	
	runApplication();
	
	printf("reached after while loop\n");
	destroyWindow(w1);
	destroyWindow(w2);
	
	destroyLabel(l1);
	destroyButton(b1);
	destroyButton(b2);
	destroySlider(s1);
	destroyLevelIndicator(i1);
	return 0;
}

void mouseMove(PTLMouseDeltaEvent e) {
	char c[20];
	sprintf(c, "x:%.2f y:%.2f", e.dx, e.dy);
	setLabelText(l1, c);
}

void _windowWillClose(PTLWindowCloseEvent e)
{
	stopApplication();
}

void mouseDown(PTLMouseDownEvent e)
{
	char c[30];
	sprintf(c, "button %llu pressed!", e.mouseButton);
	setLabelText(l1, c);
}

void keyDown(PTLKeyDownEvent e)
{
	static int i = 0;
	printf("key code pressed %d %d\n", e.flags, e.keyCode);
	if(e.keyCode == PTL_ESC)
	{
		setCursorEnabled(1);
	}
	
	setLevelIndicatorDiscrete(i1, i);
	i = !i;
}

void mouseEntered(PTLMouseEnterEvent e)
{
	printf("mousentered %d\n", e.entered);
}
void buttonFunction(PTLButtonEvent e)
{
	printf("%llu\n", e.state);
	setLabelColor(l1, 1, (e.state)?0.9:0.1, 0.3, 1);
}

void textChanged(PTLLabelEvent e)
{
	setCursorEnabled(strcmp(e.text, "hide"));
}

void sliderChanged(PTLSliderEvent e)
{
	char c[7];
	sprintf(c, "%.2f", e.value);
	setLabelText(l1, c);
	setLevelIndicatorValue(i1, 0 - e.value);
}

void refreshDisplay(PTLDisplayRefreshEvent e)
{
//	static int i = 60;
//	if( i == 60)
//	{
//		i = 0;
//		printf("delta: %.2f until: %.2f now: %.2f\n", e.delta/1000000.0, e.timeUntilDisplay/1000000.0, e.now/1000000.0);
//	}
//	i++;
}
