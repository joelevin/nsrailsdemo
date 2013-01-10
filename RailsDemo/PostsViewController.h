//
//  PostsViewController.h
//  RailsDemo
//
//  Created by Joseph Levin on 1/9/13.
//  Copyright (c) 2013 Joseph Levin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostsViewController : UITableViewController
{
    NSMutableArray *posts;
}

- (void) refresh;
- (void) addPost;

@end
