//
//  SCViewController.m
//  SyntaxChecker
//
//  Created by Max Seelemann on 23.12.13.
//  Copyright (c) 2013 Max Seelemann. All rights reserved.
//

#import "SCViewController.h"
#import "SCTextStorage.h"

@interface SCViewController ()
{
	SCTextStorage *_textStorage;
}
@end

@implementation SCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	_textStorage = [SCTextStorage new];
	[_textStorage replaceCharactersInRange:NSMakeRange(0, 0) withString:@"\"Boiler plate\" originally referred to the maker's label used to identify the builder of steam boilers.\n\nIn the field of printing, the term dates back to the early 1900s. From the 1890s onwards, printing plates of text for widespread reproduction such as advertisements or syndicated columns were cast or stamped in steel (instead of the much softer and less durable lead alloys used otherwise) ready for the printing press and distributed to newspapers around the United States. They came to be known as 'boilerplates'. Until the 1950s, thousands of newspapers received and used this kind of boilerplate from the nation's largest supplier, the Western Newspaper Union."];
	
	[_textStorage addLayoutManager: self.textView.layoutManager];
}

- (BOOL)prefersStatusBarHidden
{
	return YES;
}

@end
