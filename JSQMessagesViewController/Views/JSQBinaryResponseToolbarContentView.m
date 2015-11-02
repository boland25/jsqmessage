//
//  JSQBinaryResponseToolbarContentView.m
//  Pods
//
//  Created by Gregory Boland on 10/30/15.
//
//

#import "JSQBinaryResponseToolbarContentView.h"

@implementation JSQBinaryResponseToolbarContentView


#pragma mark - Class methods

+ (UINib *)nib {
    return [UINib nibWithNibName:NSStringFromClass([JSQBinaryResponseToolbarContentView class]) bundle:[NSBundle bundleForClass:[JSQBinaryResponseToolbarContentView class]]];
}

#pragma mark - Initialization

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    self.backgroundColor = [UIColor clearColor];
}

#pragma mark - Setters

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
   // self.leftBarButtonContainerView.backgroundColor = backgroundColor;
   // self.rightBarButtonContainerView.backgroundColor = backgroundColor;
}

- (void)setLeftBarButtonItem:(UIButton *)leftBarButtonItem {
    
}

- (IBAction)binaryButtonWasTapped:(id)sender {
    NSLog(@"TEST HIT");
}


@end
