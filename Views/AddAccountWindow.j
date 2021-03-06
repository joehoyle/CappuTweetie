@implementation AddAccountWindow : CPWindow
{
    CPTextField usernameField;
    CPTextField passwordField;
    CPButton addButton;
    id delegate;
}

- (void)initWithDelegate:(id)aDelegate
{
    var styleMask = [CPPlatform isBrowser] ? CPDocModalWindowMask : CPTitledWindowMask|CPClosableWindowMask
    self = [super initWithContentRect:CGRectMake(0, 0, 330, 133) styleMask:styleMask];
    
    if(![CPPlatform isBrowser])
    {
        [self setTitle:"Add Account"];
        [self center];
    }
    
    var contentView = [self contentView];
    
    delegate = aDelegate;
    
    var usernameLabel = [[CPTextField alloc] initWithFrame:CGRectMake(50, 20, 70, 20)];
    [usernameLabel setStringValue:"Username:"];
    
    usernameField = [[CPTextField alloc] initWithFrame:CGRectMake(115, 14, 200, 28)];
    [usernameField setEditable:YES];
    [usernameField setBezeled:YES];
    [usernameField setDelegate:self];
    
    var passwordLabel = [[CPTextField alloc] initWithFrame:CGRectMake(53, 55, 70, 20)];
    [passwordLabel setStringValue:"Password:"];
    
    passwordField = [[CPTextField alloc] initWithFrame:CGRectMake(115, 49, 200, 28)];
    [passwordField setEditable:YES];
    [passwordField setBezeled:YES];
    [passwordField setSecure:YES];
    [passwordField setDelegate:self];
        
    addButton = [[CPButton alloc] initWithFrame:CGRectMakeZero()];
    [addButton setTitle:"Add Account"];
    [addButton sizeToFit];
    [addButton setFrameOrigin:CGPointMake(330 - 19 - CGRectGetWidth([addButton frame]), 90)];
    [addButton setKeyEquivalent:CPNewlineCharacter];
    [addButton setEnabled:NO];
    [addButton setTarget:self];
    [addButton setAction:@selector(addAccount:)];
    
    var cancelButton = [[CPButton alloc] initWithFrame:CGRectMakeZero()];
    [cancelButton setTitle:"Cancel"];
    [cancelButton sizeToFit];
    [cancelButton setFrameOrigin:CGPointMake(CGRectGetMinX([addButton frame]) - CGRectGetWidth([cancelButton frame]) - 10, 90)];
    [cancelButton setTarget:self];
    [cancelButton setAction:@selector(hideSheet:)];
    
    [contentView setSubviews:[usernameLabel, usernameField, passwordLabel, passwordField, cancelButton, addButton]];
    
    return self;
}

- (void)controlTextDidChange:(CPNotification)aNotification
{
    var enabled = [usernameField stringValue].length > 0 && [passwordField stringValue].length > 0;
    [addButton setEnabled:enabled];
}

- (void)hideSheet:(id)sender
{
    if([CPPlatform isBrowser])
        [CPApp endSheet:self];
    else
        [self close];
}

- (void)addAccount:(id)sender
{
    var hide = [delegate addAccountWithUsername:[usernameField stringValue] password:[passwordField stringValue]];
    if(hide)
        [self hideSheet:nil];
}

+ (void)showSheetForWindow:(CPWindow)aWindow
{
    // FIXME: RangeError: Maximum call stack size exceeded error in NativeHost (bug in NH)
    var sheet = [[AddAccountWindow alloc] initWithDelegate:aWindow];
    
    if([CPPlatform isBrowser])
        [CPApp beginSheet:sheet modalForWindow:aWindow modalDelegate:nil didEndSelector:nil contextInfo:nil];
    else
        [sheet makeKeyAndOrderFront:self];
    
    [sheet.usernameField becomeFirstResponder];
    return sheet;
}

@end