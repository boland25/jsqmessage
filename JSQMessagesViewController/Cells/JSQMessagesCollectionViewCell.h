//
//  Created by Jesse Squires
//  http://www.hexedbits.com
//
//
//  Documentation
//  http://cocoadocs.org/docsets/JSMessagesViewController
//
//
//  The MIT License
//  Copyright (c) 2014 Jesse Squires
//  http://opensource.org/licenses/MIT
//

#import <UIKit/UIKit.h>

#import "JSQMessagesLabel.h"


@interface JSQMessagesCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic, readonly) JSQMessagesLabel *cellTopLabel;
@property (weak, nonatomic, readonly) JSQMessagesLabel *messageBubbleTopLabel;
@property (weak, nonatomic, readonly) JSQMessagesLabel *cellBottomLabel;

@property (weak, nonatomic, readonly) UITextView *textView;

@property (weak, nonatomic) UIImageView *messageBubbleImageView;
@property (weak, nonatomic) UIImageView *avatarImageView;

@property (strong, nonatomic) UIFont *font UI_APPEARANCE_SELECTOR;

#pragma mark - Class methods

+ (UINib *)nib;

+ (NSString *)cellReuseIdentifier;

+ (UIEdgeInsets)defaultTextContainerInset;

@end
