//
//  JSQToolbarData.m
//  Pods
//
//  Created by Gregory Boland on 11/17/15.
//
//

#import "JSQToolbarData.h"
#import "JSQMessagesInputToolbar.h"

@interface JSQToolbarData () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) NSMutableArray *selectedChoicesArray;

@end

@implementation JSQToolbarData

- (instancetype)initWithData:(JSQInputToolbarType)toolbarType choices:(NSArray *)choicesArray buttonColor:(UIColor *)buttonColor{
    self = [super init];
    if (self) {
        _toolbarType = toolbarType;
        _choices = choicesArray;
        _buttonColor = buttonColor;
        _selectedChoicesArray = [NSMutableArray array];
        _isMultiSelect = NO;
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
    return selection;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    //NSLog(@"chosen picker row ---------------- %@", self.choices[row]);
    id chosen = self.choices[row];
    if (!self.isMultiSelect) {
        if (self.selectedChoicesArray.count > 0) {
            [self.selectedChoicesArray removeAllObjects];
        }
        [self.selectedChoicesArray addObject:chosen];
    }

}
- (NSArray *)selectedChoices {
    return [NSArray arrayWithArray:self.selectedChoicesArray];
}


@end
