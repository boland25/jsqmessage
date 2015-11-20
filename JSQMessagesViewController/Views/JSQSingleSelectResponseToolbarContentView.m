//
//  JSQSingleSelectResponseToolbarContentView.m
//  Pods
//
//  Created by Gregory Boland on 11/2/15.
//
//

#import "JSQSingleSelectResponseToolbarContentView.h"

@interface JSQSingleSelectResponseToolbarContentView () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) NSArray *choices;
@property (nonatomic, copy) NSString *selectedChoice;

@end

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
    self.choices = toolbarData.choices;
    self.pickerView.showsSelectionIndicator = YES;
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    [self.pickerView reloadAllComponents];
    if (self.toolbarData.buttonColor != nil) {
        self.sendButton.tintColor = self.toolbarData.buttonColor;
    }
    if (self.toolbarData.answerPrefix != nil) {
        self.answerPrefixLabel.text = self.toolbarData.answerPrefix;
    }
    
    self.delegate = toolbarData.toolbarDelegate;
    self.sendButton.enabled = NO;
}

- (IBAction)sendButtonWasTapped:(id)sender {
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(customToolbarSendButtonWasPressed:)]) {
            [self.delegate customToolbarSendButtonWasPressed:@[self.selectedChoice]];
        }
    }
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.choices.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *selection = self.choices[row];
    return selection;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    //NSLog(@"chosen picker row ---------------- %@", self.choices[row]);
    self.sendButton.enabled = YES;
    self.selectedChoice = self.choices[row];
}

@end
