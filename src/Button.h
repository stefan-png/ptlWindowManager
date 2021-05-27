//
//  Button.h
//  Test 2
//
//  Created by Stefan Antoszko on 2021-05-21.
//

#import <Cocoa/Cocoa.h>
#import "main.h"

@interface Button : NSButton
{
	PTLButton* handle;
}

-(instancetype) initWithHandle:(PTLButton*)handle X:(uint32_t)x Y:(uint32_t)y Width:(uint32_t)width Height:(uint32_t)height;
-(void) callback;

@end
