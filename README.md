# ptlWindowManager

MacOS GLFW replacement.

![image](https://user-images.githubusercontent.com/74995040/119889114-6e317f00-bef3-11eb-8d05-1e6eaee02869.png)

## build!

1. download or clone repo
2. open terminal
3. `cd <download location>`
4. `make dynamic`
5. `make test`


## Features
### Application
- Can choose to propogate window events each fram manually from main thread, or have it done automatically. 
- Can choose to implement diplayRefreshCallback function, which will be called in sync with the display's refresh rate.

### Window
- Customize window with a title, shadow, size, position, and unique event callbacks.

### UI
- Add custom labels, buttons, sliders and level indicators to each window.

### Events (all callbacks are non-static)
- Window Close
- Window Resize
- Window Move
- Window Minimize
- Window Fullscreen
- Window Focus
- Key Down
- Key Up
- Mouse Move
- Mouse Enter / Exit
- Mouse Down
- Mouse Up
- Mouse Scroll
- Label Edit
- Button Press
- Slider Move

### Vulkan
- Create a `VkMetalSurfaceCreateInfo` object.
- Get needed extensions.

