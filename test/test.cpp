#include "../dense/ptlWindowManager.h"

//  gcc dense/ptlWindowManager.m test.cpp -o out/main -framework Foundation -framework Cocoa -framework QuartzCore

void closeApp(PTLWindowCloseEvent e);

int main() {

    ptlInitApplication();
    PTLWindow* window = ptlCreateWindow(300, 300, "Default Window", PTL_WINDOW_STYLE_DEFAULT_BIT);
    window->windowCloseCallback = closeApp;
    ptlRunApplication();

    ptlDestroyWindow(window);
    return 0;
}

void closeApp(PTLWindowCloseEvent e)
{
    ptlStopApplication();
}
