//
//  SCTextStorage.m
//  SyntaxChecker
//
//  Created by Max Seelemann on 23.12.13.
//  Copyright (c) 2013 Max Seelemann. All rights reserved.
//

#import "SCTextStorage.h"

@implementation SCTextStorage
{
	NSMutableAttributedString	*_imp;
	NSLinguisticTagger			*_tagger;
}

- (id)init
{
	self = [super init];
	
	if (self) {
		_imp = [NSMutableAttributedString new];
		_tagger = [[NSLinguisticTagger alloc] initWithTagSchemes:@[NSLinguisticTagSchemeLexicalClass] options:0];
	}
	
	return self;
}

- (NSString *)string
{
	return _imp.string;
}

- (NSDictionary *)attributesAtIndex:(NSUInteger)location effectiveRange:(NSRangePointer)range
{
	return [_imp attributesAtIndex:location effectiveRange:range];
}

- (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)str
{
	[_imp replaceCharactersInRange:range withString:str];
	
	NSInteger delta = (NSInteger)str.length - (NSInteger)range.length;
	[self edited:NSTextStorageEditedCharacters range:range changeInLength:delta];
}

- (void)setAttributes:(NSDictionary *)attrs range:(NSRange)range
{
	[_imp setAttributes:attrs range:range];
	[self edited:NSTextStorageEditedAttributes range:range changeInLength:0];
}

- (void)processEditing
{
	NSRange paragraphRange = [self.string paragraphRangeForRange: self.editedRange];
	[self removeAttribute:NSForegroundColorAttributeName range:paragraphRange];
	
	_tagger.string = self.string;
	[_tagger enumerateTagsInRange:paragraphRange scheme:NSLinguisticTagSchemeLexicalClass options:0 usingBlock:^(NSString *tag, NSRange tokenRange, NSRange sentenceRange, BOOL *stop) {
		if (tag == NSLinguisticTagAdverb)
			[self addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.8 green:0 blue:0 alpha:1] range:tokenRange];
		if (tag == NSLinguisticTagAdjective)
			[self addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0 green:0.6 blue:0 alpha:1] range:tokenRange];
		if (tag == NSLinguisticTagPreposition)
			[self addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0 green:0 blue:0.8 alpha:1] range:tokenRange];
	}];
	
	[super processEditing];
}

@end
