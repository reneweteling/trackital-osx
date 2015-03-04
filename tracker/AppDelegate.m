//
//  AppDelegate.m
//  tracker
//
//  Created by Rene Weteling on 03-03-15.
//  Copyright (c) 2015 Weteling support. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property (strong, nonatomic) NSStatusItem *statusItem;
@property (assign, nonatomic) BOOL darkModeOn;
@property (weak) IBOutlet WebView *webview;
@property (weak) IBOutlet NSMenu *menu;
@property (weak) IBOutlet NSView *view;



@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    

    
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    
    


    
    _statusItem.image = [NSImage imageNamed:@"switchIcon.png"];
    [_statusItem.image setTemplate:YES];
    
    _statusItem.highlightMode = NO;
    _statusItem.toolTip = @"command-click to quit";
    
    
    
    
    [_statusItem setAction:@selector(clickStatusBar:)];

    [[_webview mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.nu.nl"]]];
    
    //[_window close];
    
    [self clickStatusBar:nil];
    
}


- (void)clickStatusBar:(id)sender {
    
    // close the window with the ctrl click
    NSEvent *event = [NSApp currentEvent];
    if([event modifierFlags] & NSControlKeyMask) {
        [[NSApplication sharedApplication] terminate:self];
        return;
    }
    
    // lets get the X of the statusicon, and locatie the window
    float statusBarX = [[_statusItem valueForKey:@"window"] frame].origin.x;
    float statusBarY = [[_statusItem valueForKey:@"window"] frame].origin.y;
    float statusBarW = [[_statusItem valueForKey:@"window"] frame].size.width;
    float windowWidth = 300;
    float windowHeight = 400;
    CGRect newFrame = CGRectMake(  statusBarX - (windowWidth / 2) + ( statusBarW / 2 ), statusBarY, windowWidth, windowHeight);
    
    // set the new frame
    [_window setFrame:newFrame display:YES animate:YES];
    
    // open the window
    [NSApp arrangeInFront:sender];
    [_window makeKeyAndOrderFront:sender];
    [NSApp activateIgnoringOtherApps:YES];

}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
