//
//  JSQMultiSelectResponseToolbarContentView.m
//  Pods
//
//  Created by Gregory Boland on 11/17/15.
//
//

#import "JSQMultiSelectResponseToolbarContentView.h"

@implementation JSQMultiSelectResponseToolbarContentView

+ (UINib *)nib {
    return [UINib nibWithNibName:NSStringFromClass([JSQMultiSelectResponseToolbarContentView class]) bundle:[NSBundle bundleForClass:[JSQMultiSelectResponseToolbarContentView class]]];
}

#pragma mark - Initialization

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    self.backgroundColor = [UIColor clearColor];
}


@end
