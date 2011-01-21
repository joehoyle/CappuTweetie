@import "TwitterUser.j"

@implementation Tweet : CPObject
{
	CPString 	text @accessors;
	TwitterUser	author @accessors;
}

- (Tweet)initWithJSObject:(JSObject)aJSObject
{
	self = [super init];
	[self setText:aJSObject.text];
	[self setAuthor:
		[[TwitterUser alloc] initWithJSObject:aJSObject.user]];
		
	return self;
}

@end