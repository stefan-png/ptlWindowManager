//
//  ApplicationDelegate.m
//  Test 2
//
//  Created by Stefan Antoszko on 2021-05-19.
//

#import "ApplicationDelegate.h"
#import "main.h"

@implementation ApplicationDelegate

-(instancetype)init
{
	self = [super init];
	return self;
}


-(void) applicationWillFinishLaunching:(NSNotification *)notification
{
	[self populateMainMenu];
}

-(void)applicationDidFinishLaunching:(NSNotification *)notification
{
@autoreleasepool {

	NSEvent* event = [NSEvent otherEventWithType:NSEventTypeApplicationDefined
										location:NSMakePoint(0, 0)
								   modifierFlags:0
										timestamp:0
									windowNumber:0
										context:nil
										subtype:0
											data1:0
											data2:0];
	[NSApp postEvent:event atStart:YES];
	
	[NSApp stop:self];
	
} // autoreleasepool
}

- (NSMenu *)applicationDockMenu:(NSApplication *)sender
{
	return nil;
}

-(void)populateMainMenu
{
	
	NSMenu* mainMenu = [[NSMenu alloc] initWithTitle:@"MainMenu"];
	
	//App title
	NSMenuItem* appMenuItem;
	NSMenu* appSubmenu;
	NSMenuItem* menuItem;
	NSMenu* appServicesMenu = [[NSMenu alloc] initWithTitle:@"Services"];

	appMenuItem = [mainMenu addItemWithTitle:@"Apple" action:NULL keyEquivalent:@""];
	appSubmenu = [[NSMenu alloc] initWithTitle:@"Apple"];
	//[NSApp performSelector:NSSelectorFromString(@"setAppleMenu:") withObject:appSubmenu];

	NSString* appName = [[NSProcessInfo processInfo] processName];
	menuItem = [appSubmenu addItemWithTitle:[NSString stringWithFormat:@"%@ %@", @"About", appName] action:@selector(orderFrontStandardAboutPanel:) keyEquivalent:@""];
	
	[appSubmenu addItem:[NSMenuItem separatorItem]];
	
	menuItem = [appSubmenu addItemWithTitle:@"Preferences..." action:nil keyEquivalent:@","];
	
	[appSubmenu addItem:[NSMenuItem separatorItem]];
	
	[appSubmenu addItem:[NSMenuItem separatorItem]];
	menuItem = [appSubmenu addItemWithTitle:@"Services" action:nil keyEquivalent:@""];
	[menuItem setSubmenu:appServicesMenu];
	menuItem = [appServicesMenu addItemWithTitle:@"No Services" action:nil keyEquivalent:@""];
	[NSApp setServicesMenu:appServicesMenu];
	
	[appSubmenu addItem:[NSMenuItem separatorItem]];
	
	menuItem = [appSubmenu addItemWithTitle:[NSString stringWithFormat:@"%@ %@", @"Hide", appName] action:@selector(hide:) keyEquivalent:@"h"];
	menuItem = [appSubmenu addItemWithTitle:@"Hide Others" action:@selector(hideOtherApplications::) keyEquivalent:@"h"];
	[menuItem setKeyEquivalentModifierMask:NSEventModifierFlagOption | NSEventModifierFlagCommand];
	menuItem = [appSubmenu addItemWithTitle:@"Show All" action:@selector(unhideAllApplications:) keyEquivalent:@""];
	
	menuItem = [appSubmenu addItemWithTitle:[NSString stringWithFormat:@"%@ %@", @"Quit", appName] action:@selector(terminate:) keyEquivalent:@"q"];

	[mainMenu setSubmenu:appSubmenu forItem:appMenuItem];
	
	//Edit
	NSMenuItem* editMenuItem;
	NSMenu* editSubmenu;
	
	editMenuItem = [mainMenu addItemWithTitle:@"Edit" action:nil keyEquivalent:@""];
	editSubmenu = [[NSMenu alloc] initWithTitle:@"Edit"];
	
	menuItem = [editSubmenu addItemWithTitle:@"Undo" action:@selector(undo:) keyEquivalent:@"z"];
	menuItem = [editSubmenu addItemWithTitle:@"Redo" action:@selector(redo:) keyEquivalent:@"z"];
	[menuItem setKeyEquivalentModifierMask:NSEventModifierFlagShift | NSEventModifierFlagCommand];
	
	[editSubmenu addItem:[NSMenuItem separatorItem]];
	
	menuItem = [editSubmenu addItemWithTitle:@"Cut" action:@selector(cut:) keyEquivalent:@"x"];
	menuItem = [editSubmenu addItemWithTitle:@"Copy" action:@selector(copy:) keyEquivalent:@"c"];
	menuItem = [editSubmenu addItemWithTitle:@"Paste" action:@selector(paste:) keyEquivalent:@"v"];
	unichar c = NSDeleteCharacter;
	menuItem = [editSubmenu addItemWithTitle:@"Delete" action:@selector(delete:) keyEquivalent:[NSString stringWithCharacters:&c length:1]];

	[editSubmenu addItem:[NSMenuItem separatorItem]];

	menuItem = [editSubmenu addItemWithTitle:@"Select All" action:@selector(selectAll:) keyEquivalent:@"a"];

	[mainMenu setSubmenu:editSubmenu forItem:editMenuItem];

	//View
	NSMenuItem* viewMenuItem;
	NSMenu* viewSubmenu;
	
	viewMenuItem = [mainMenu addItemWithTitle:@"View" action:nil keyEquivalent:@""];
	viewSubmenu = [[NSMenu alloc] initWithTitle:@"View"];
	
	menuItem = [viewSubmenu addItemWithTitle:@"Enter Fullscreen" action:@selector(toggleFullScreen:) keyEquivalent:@"f"];
	[menuItem setKeyEquivalentModifierMask:NSEventModifierFlagControl | NSEventModifierFlagCommand ];

	[mainMenu setSubmenu:viewSubmenu forItem:viewMenuItem];
	
	//Window
	NSMenuItem* windowMenuItem;
	NSMenu* windowSubmenu;
	
	windowMenuItem = [mainMenu addItemWithTitle:@"Window" action:nil keyEquivalent:@""];
	windowSubmenu = [[NSMenu alloc] initWithTitle:@"Window"];
	
	[windowSubmenu addItem:[NSMenuItem separatorItem]];
	
	menuItem = [windowSubmenu addItemWithTitle:@"Minimize" action:@selector(miniaturize:) keyEquivalent:@"m"];
	menuItem = [windowSubmenu addItemWithTitle:@"Minimize All" action:@selector(miniaturizeAll:) keyEquivalent:@"m"];
	[menuItem setKeyEquivalentModifierMask:NSEventModifierFlagOption | NSEventModifierFlagCommand];
	menuItem = [windowSubmenu addItemWithTitle:@"Zoom" action:@selector(zoom:) keyEquivalent:@""];
	
	[windowSubmenu addItem:[NSMenuItem separatorItem]];
	
	menuItem = [windowSubmenu addItemWithTitle:@"Bring All to Front" action:@selector(orderFront:) keyEquivalent:@""];

	[mainMenu setSubmenu:windowSubmenu forItem:windowMenuItem];
	
	[NSApp setMainMenu:mainMenu];
	[NSApp setWindowsMenu:windowSubmenu];
}

@end
