//
//  AppDelegate.h
//  RailsDemo
//
//  Created by Joseph Levin on 1/9/13.
//  Copyright (c) 2013 Joseph Levin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navigationController;

+ (void) alertForError:(NSError *)e;

@end
