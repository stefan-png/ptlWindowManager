//
//  ApplicationDelegate.h
//  Test 2
//
//  Created by Stefan Antoszko on 2021-05-19.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import "View.h"
#import "Window.h"
#import "main.h"

@interface ApplicationDelegate : NSObject <NSApplicationDelegate>

-(instancetype)init;
-(void)populateMainMenu;

@end

