//
//  Slider.h
//  Test 2
//
//  Created by Stefan Antoszko on 2021-05-24.
//

#import <Cocoa/Cocoa.h>
#import "main.h"

@interface Slider : NSSlider
{
	PTLSlider* handle;
}

- (instancetype) initWithHandle:(PTLSlider*)handle X:(uint32_t)x Y:(uint32_t)y Width:(uint32_t)width Height:(uint32_t)height;
- (void) callback;
@end
