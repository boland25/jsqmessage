//
//  Created by Jesse Squires
//  http://www.jessesquires.com
//
//
//  Documentation
//  http://cocoadocs.org/docsets/JSQMessagesViewController
//
//
//  GitHub
//  https://github.com/jessesquires/JSQMessagesViewController
//
//
//  License
//  Copyright (c) 2014 Jesse Squires
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#import "JSQMessagesInputToolbar.h"

#import "JSQMessagesComposerTextView.h"
#import "JSQSingleSelectResponseToolbarContentView.h"
#import "JSQMultiSelectResponseToolbarContentView.h"
#import "TestInputView.h"

#import "JSQMessagesToolbarButtonFactory.h"

#import "UIColor+JSQMessages.h"
#import "UIImage+JSQMessages.h"
#import "UIView+JSQMessages.h"

static void * kJSQMessagesInputToolbarKeyValueObservingContext = &kJSQMessagesInputToolbarKeyValueObservingContext;


@interface JSQMessagesInputToolbar ()

@property (assign, nonatomic) BOOL jsq_isObserving;

- (void)jsq_leftBarButtonPressed:(UIButton *)sender;
- (void)jsq_rightBarButtonPressed:(UIButton *)sender;

- (void)jsq_addObservers;
- (void)jsq_removeObservers;

@end



@implementation JSQMessagesInputToolbar

@dynamic delegate;

#pragma mark - Initialization

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];

    self.jsq_isObserving = NO;
    self.sendButtonOnRight = YES;

    
    //NOTE: this is where it need to manipulate what foes in the toolbar and the size that we create for it
    self.preferredDefaultHeight = 44.0;
    self.maximumHeight = NSNotFound;

    [self setToolbarContentViewByType:Standard withContent:nil];
    NSLog(@"do we have a type defined yet %i", self.inputToolbarType);
    
}

/**
    NOTE: this happens before the old contentView is off the screen is we're loading a new one after there is an old one.  so don't reference self.contentView in here hoping to get access to the new toolbar contentview
 */
- (JSQMessagesToolbarContentView *)loadToolbarContentView:(JSQInputToolbarType)toolbarType
{
    NSArray *nibViews = [[NSBundle bundleForClass:[JSQMessagesInputToolbar class]] loadNibNamed:NSStringFromClass([JSQMessagesToolbarContentView class])
                                                                                          owner:nil
                                                                                        options:nil];

 //   if (toolbarType != self.inputToolbarType) {
        JSQMessagesInputToolbar *newToolbar;
        switch (toolbarType) {
            case Standard:
                //NSLog(@"setup standard toolbar");
                 self.preferredDefaultHeight = 44.0;
                break;
            case BinaryButton:
               // NSLog(@"Binary buton");
                [self jsq_removeObservers];
                nibViews = [[NSBundle bundleForClass:[JSQMessagesInputToolbar class]] loadNibNamed:NSStringFromClass([JSQBinaryResponseToolbarContentView class]) owner:nil options:nil];
                break;
            case SingleSelect:
               // NSLog(@"SINGLE Select");
                
                [self jsq_removeObservers];
                // NOTE: this will be a picker view
                nibViews = [[NSBundle bundleForClass:[JSQMessagesInputToolbar class]] loadNibNamed:NSStringFromClass([JSQSingleSelectResponseToolbarContentView class]) owner:nil options:nil];
                self.preferredDefaultHeight = 258.0;
                break;
            case MultiSelect:
                //NOTE: this one is the multiple choice
               // NSLog(@"Multi Select");
                nibViews = [[NSBundle bundleForClass:[JSQMessagesInputToolbar class]] loadNibNamed:NSStringFromClass([JSQMultiSelectResponseToolbarContentView class]) owner:nil options:nil];
                [self jsq_removeObservers];
            case Picker:
              //  NSLog(@"Picker");
            default:
                //TODO: set up standard here
                break;
        }
  //  }
    self.inputToolbarType = toolbarType;
    //NSLog(@"should change toolbar now %i", self.inputToolbarType);
    
    return nibViews.firstObject;
}

- (void)setToolbarContentViewByType:(JSQInputToolbarType)toolbarType withContent:(JSQToolbarData *)toolbarData {
    
    JSQMessagesToolbarContentView *toolbarContentView = [self loadToolbarContentView:toolbarType];
    toolbarContentView.frame = self.contentView.frame;
    [self jsq_removeObservers];
    [self.contentView removeFromSuperview];
    if (self.inputToolbarType != Standard) {
        // TODO: load the toolbardata
        [(<JSQToolbarSetup>)toolbarContentView setupToolbarWithData:toolbarData];
    }
    [self addSubview:toolbarContentView];
    [self jsq_pinAllEdgesOfSubview:toolbarContentView];
    [self setNeedsUpdateConstraints];
    _contentView = toolbarContentView;
    if (self.inputToolbarType == Standard) {
        [self jsq_addObservers];
        self.contentView.leftBarButtonItem = [JSQMessagesToolbarButtonFactory defaultAccessoryButtonItem];
        self.contentView.rightBarButtonItem = [JSQMessagesToolbarButtonFactory defaultSendButtonItem];
        [self toggleSendButtonEnabled];

    }

}

- (void)dealloc
{
    [self jsq_removeObservers];
    _contentView = nil;
}

#pragma mark - Setters

- (void)setPreferredDefaultHeight:(CGFloat)preferredDefaultHeight
{
    NSParameterAssert(preferredDefaultHeight > 0.0f);
    _preferredDefaultHeight = preferredDefaultHeight;
}

#pragma mark - Actions

- (void)jsq_leftBarButtonPressed:(UIButton *)sender
{
    [self.delegate messagesInputToolbar:self didPressLeftBarButton:sender];
}

- (void)jsq_rightBarButtonPressed:(UIButton *)sender
{
    [self.delegate messagesInputToolbar:self didPressRightBarButton:sender];
}

#pragma mark - Input toolbar

- (void)toggleSendButtonEnabled
{
    BOOL hasText = [self.contentView.textView hasText];

    if (self.sendButtonOnRight) {
        self.contentView.rightBarButtonItem.enabled = hasText;
    }
    else {
        self.contentView.leftBarButtonItem.enabled = hasText;
    }
}

#pragma mark - Key-value observing

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == kJSQMessagesInputToolbarKeyValueObservingContext) {
        if (object == self.contentView) {

            if ([keyPath isEqualToString:NSStringFromSelector(@selector(leftBarButtonItem))]) {

                [self.contentView.leftBarButtonItem removeTarget:self
                                                          action:NULL
                                                forControlEvents:UIControlEventTouchUpInside];

                [self.contentView.leftBarButtonItem addTarget:self
                                                       action:@selector(jsq_leftBarButtonPressed:)
                                             forControlEvents:UIControlEventTouchUpInside];
            }
            else if ([keyPath isEqualToString:NSStringFromSelector(@selector(rightBarButtonItem))]) {

                [self.contentView.rightBarButtonItem removeTarget:self
                                                           action:NULL
                                                 forControlEvents:UIControlEventTouchUpInside];

                [self.contentView.rightBarButtonItem addTarget:self
                                                        action:@selector(jsq_rightBarButtonPressed:)
                                              forControlEvents:UIControlEventTouchUpInside];
            }

            [self toggleSendButtonEnabled];
        }
    }
}

- (void)jsq_addObservers
{
    if (self.jsq_isObserving) {
        return;
    }

    [self.contentView addObserver:self
                       forKeyPath:NSStringFromSelector(@selector(leftBarButtonItem))
                          options:0
                          context:kJSQMessagesInputToolbarKeyValueObservingContext];

    [self.contentView addObserver:self
                       forKeyPath:NSStringFromSelector(@selector(rightBarButtonItem))
                          options:0
                          context:kJSQMessagesInputToolbarKeyValueObservingContext];

    self.jsq_isObserving = YES;
}

- (void)jsq_removeObservers
{
    if (!_jsq_isObserving) {
        return;
    }

    @try {
        [_contentView removeObserver:self
                          forKeyPath:NSStringFromSelector(@selector(leftBarButtonItem))
                             context:kJSQMessagesInputToolbarKeyValueObservingContext];

        [_contentView removeObserver:self
                          forKeyPath:NSStringFromSelector(@selector(rightBarButtonItem))
                             context:kJSQMessagesInputToolbarKeyValueObservingContext];
    }
    @catch (NSException *__unused exception) { }
    
    _jsq_isObserving = NO;
}

@end
