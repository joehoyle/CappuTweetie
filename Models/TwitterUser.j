@implementation TwitterUser : CPObject
{
	int			id	@accessors;
	CPString	name @accessors;
	CPString	screenName @accessors;
	CPImage		profileImage @accessors;
	
}

- (TwitterUser)initWithJSObject:(JSObject)aJSObject
{
	self = [super init];
	
	[self setId:aJSObject.id];
	[self setName:aJSObject.name];
	[self setScreenName:aJSObject.screen_name];
	[self setProfileImage:
		[[CPImage alloc] initWithContentsOfFile:aJSObject.profile_image_url]];
		
	return self;
}

@end