//
//  Text.h
//  Test 2
//
//  Created by Stefan Antoszko on 2021-05-23.
//

#import <Cocoa/Cocoa.h>
#import "main.h"

@interface Text : NSTextView <NSTextViewDelegate>
{
	PTLLabel* handle;
}

- (instancetype) initWithHandle:(PTLLabel*)handle X:(uint32_t)x Y:(uint32_t)y Width:(uint32_t)width Height:(uint32_t)height;

@end

