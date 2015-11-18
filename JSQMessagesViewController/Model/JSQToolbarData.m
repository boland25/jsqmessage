//
//  JSQToolbarData.m
//  Pods
//
//  Created by Gregory Boland on 11/17/15.
//
//

#import "JSQToolbarData.h"
#import "JSQMessagesInputToolbar.h"

@interface JSQToolbarData () <UIPickerViewDataSource>


@end

@implementation JSQToolbarData

- (instancetype)initWithData:(JSQInputToolbarType)toolbarType choices:(NSArray *)choicesArray buttonColor:(UIColor *)buttonColor {
    self = [super init];
    if (self) {
        _toolbarType = toolbarType;
        _choices = choicesArray;
        _buttonColor = buttonColor;
    }
    return self;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.choices.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *selection = self.choices[row];
   // NSLog(@"selection %@", selection);
    return selection;
}



@end
