//
//  Post.h
//  RailsDemo
//
//  Created by Joseph Levin on 1/9/13.
//  Copyright (c) 2013 Joseph Levin. All rights reserved.
//

#import "NSRails.h"

@interface Post : NSRRemoteObject

@property (nonatomic, strong) NSString *author, *content;

@end
