//
//  InputViewController.m
//  RailsDemo
//
//  Created by Joseph Levin on 1/9/13.
//  Copyright (c) 2013 Joseph Levin. All rights reserved.
//

#import "InputViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface InputViewController (private)

- (void) placehold;

@end

@implementation InputViewController
@synthesize messagePlaceholder, header;

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (id) initWithCompletionHandler:(PostInputBlock)completionBlock
{
    self = [super initWithNibName:@"InputViewController" bundle:nil];
    if (self)
    {
        block = completionBlock;
    }
    return self;
}

- (void) cancel
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void) save
{
    NSString *author = authorField.text;
    NSString *message = (contentField.tag == 0 ? @"" : contentField.text);
    
    
	BOOL shouldDismiss = block(author, message);
    
    
	if (shouldDismiss)
		[self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    headerLabel.text = header;
    
    [authorField becomeFirstResponder];
    
    contentField.layer.cornerRadius = 4;
    contentField.layer.borderColor = [[UIColor grayColor] CGColor];
    contentField.layer.borderWidth = 1;
    
    authorField.layer.cornerRadius = 4;
    authorField.layer.borderColor = [[UIColor grayColor] CGColor];
    authorField.layer.borderWidth = 1;
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    authorField.leftView = paddingView;
    authorField.leftViewMode = UITextFieldViewModeAlways;
    
    [self placehold];
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void) placehold
{
    contentField.text = messagePlaceholder;
    contentField.textColor = [UIColor grayColor];
    contentField.tag = 0;
    
    [contentField setSelectedTextRange:[contentField textRangeFromPosition:[contentField beginningOfDocument] toPosition:[contentField beginningOfDocument]]];
}

- (BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (text.length == 0 && ((range.length > 0 && range.length == textView.text.length) || (textView.tag == 0)))
    {
        [self placehold];
        return NO;
    }
    else
    {
        if (textView.tag == 0)
        {
            textView.text = @"";
        }
        textView.textColor = [UIColor blackColor];
        textView.tag = 1;
    }
    return YES;
}

- (BOOL) textViewShouldEndEditing:(UITextView *)textView
{
    if (textView.text.length == 0)
    {
        [self placehold];
    }
    return YES;
}

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if (textView.tag == 0)
    {
        [textView setSelectedTextRange:[textView textRangeFromPosition:[textView beginningOfDocument] toPosition:[textView beginningOfDocument]]];
    }
    return YES;
}

- (void) textViewDidChangeSelection:(UITextView *)textView
{
    if (textView.tag == 0)
    {
        textView.tag = -1;
        
        UITextRange *beg = [textView textRangeFromPosition:[textView beginningOfDocument] toPosition:[textView beginningOfDocument]];
        [textView setSelectedTextRange:beg];
        
        textView.tag = 0;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
