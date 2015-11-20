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
    self.toolbarData = toolbarData;
    self.pickerView.showsSelectionIndicator = YES;
    self.pickerView.dataSource = self.toolbarData;
    self.pickerView.delegate = self.toolbarData;
    [self.pickerView reloadAllComponents];
    if (self.toolbarData.buttonColor != nil) {
        self.sendButton.tintColor = self.toolbarData.buttonColor;
    }
    if (self.toolbarData.answerPrefix != nil) {
        self.answerPrefixLabel.text = self.toolbarData.answerPrefix;
    }
    
    self.delegate = toolbarData.toolbarDelegate;
}

//TODO : dont' let the Send button be active until something is chosen, although it would default to being chosen


- (IBAction)sendButtonWasTapped:(id)sender {
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(customToolbarSendButtonWasPressed:)]) {
            [self.delegate customToolbarSendButtonWasPressed:self.toolbarData.selectedChoices];
        }
    }
}
@end
