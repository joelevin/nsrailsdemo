//
//  InputViewController.h
//  RailsDemo
//
//  Created by Joseph Levin on 1/9/13.
//  Copyright (c) 2013 Joseph Levin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef BOOL (^PostInputBlock)(NSString *author, NSString *content);

@interface InputViewController : UIViewController <UITextViewDelegate>
{
    PostInputBlock block;
    
    IBOutlet UITextField *authorField;
    IBOutlet UITextView *contentField;
    IBOutlet UILabel *headerLabel;
}

@property (nonatomic, strong) NSString *header, *messagePlaceholder;

- (id) initWithCompletionHandler:(PostInputBlock)completionBlock;

- (IBAction) save;
- (IBAction) cancel;

@end
