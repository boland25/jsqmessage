//
//  JSQSingleSelectResponseToolbarContentView.m
//  Pods
//
//  Created by Gregory Boland on 11/2/15.
//
//

#import "JSQSingleSelectResponseToolbarContentView.h"

@implementation JSQSingleSelectResponseToolbarContentView

#pragma mark - Class methods

+ (UINib *)nib {
    return [UINib nibWithNibName:NSStringFromClass([JSQSingleSelectResponseToolbarContentView class]) bundle:[NSBundle bundleForClass:[JSQSingleSelectResponseToolbarContentView class]]];
}

#pragma mark - Initialization

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    self.backgroundColor = [UIColor clearColor];
}

#pragma mark JSQToolbarSetup Protocol

- (void)setupToolbarWithData:(JSQToolbarData *)toolbarData {
    // TODO: for single select, this would carry in it, a UICOlor for the button, and a dictionary of picker information, also the prompt of what the answer should be
}


@end
