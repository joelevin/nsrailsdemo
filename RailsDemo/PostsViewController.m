//
//  PostsViewController.m
//  RailsDemo
//
//  Created by Joseph Levin on 1/9/13.
//  Copyright (c) 2013 Joseph Levin. All rights reserved.
//

#import "PostsViewController.h"
#import "InputViewController.h"
#import "AppDelegate.h"

#import "Post.h"

@interface PostsViewController ()

@end

@implementation PostsViewController

//- (id)initWithStyle:(UITableViewStyle)style
//{
//    self = [super initWithStyle:style];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void) deletePostAtIndexPath:(NSIndexPath *)indexPath
{
	NSError *error;
	
	Post *post = [posts objectAtIndex:indexPath.row];
	if ([post remoteDestroy:&error])
	{
		// Remember to delete the object from our local array too
		[posts removeObject:post];
		
		[self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
	}
	else
	{
		[AppDelegate alertForError:error];
	}
}


- (void)viewDidLoad
{
    posts = [[NSMutableArray alloc] init];
    
    [self refresh];
    
    self.title = @"Posts";
    
    //Add refresh button
    UIBarButtonItem *refresh = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];
    
    self.navigationItem.leftBarButtonItem = refresh;
    
    
    //Add + button
    UIBarButtonItem *add = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addPost)];
    
    self.navigationItem.rightBarButtonItem = add;
    
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) refresh
{
    NSError *error;
    
    if ([posts remoteFetchAll:[Post class] error:&error])
    {
        [self.tableView reloadData];
    }
    else
    {
        [AppDelegate alertForError:error];
    }
}

- (void) addPost
{
    InputViewController *newPostViewController = [[InputViewController alloc] initWithCompletionHandler:^BOOL(NSString *author, NSString *content)
    {
        NSError *error;
        
        Post *newPost = [[Post alloc] init];
        newPost.author = author;
        newPost.content = content;
        
        if (![newPost remoteCreate:&error])
        {
            [AppDelegate alertForError:error];
            
            //don't dismiss the input VC
            return NO;
        }
        
        [posts insertObject:newPost atIndex:0];
        [self.tableView reloadData];
        
        return YES;
    }];
    
    newPostViewController.header = @"Post something to localhost";
    newPostViewController.messagePlaceholder = @"This is pretty cool";
    
    [self presentModalViewController:newPostViewController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return posts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    Post *post = [posts objectAtIndex:indexPath.row];
    cell.textLabel.text = post.content;
    cell.detailTextLabel.text = post.author;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self deletePostAtIndexPath:indexPath];
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Post *post = [posts objectAtIndex:indexPath.row];
    
    NSLog(@"responses");
}

@end
