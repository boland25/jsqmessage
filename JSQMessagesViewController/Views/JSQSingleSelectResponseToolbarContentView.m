//
//  JSQSingleSelectResponseToolbarContentView.m
//  Pods
//
//  Created by Gregory Boland on 11/2/15.
//
//

#import "JSQSingleSelectResponseToolbarContentView.h"
#import "JSQSingleSelectResponseTableViewCell.h"

@interface JSQSingleSelectResponseToolbarContentView () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) NSArray *choices;
@property (nonatomic, copy) NSDictionary *selectedChoice;

@end

static NSString *cellIdentifier = @"JSQSingleSelectResponseTableViewCell";

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
    [self.tableView registerNib:[UINib nibWithNibName:@"JSQSingleSelectResponseTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
}

#pragma mark JSQToolbarSetup Protocol

- (void)setupToolbarWithData:(JSQToolbarData *)toolbarData {
    // TODO: for single select, this would carry in it, a UICOlor for the button, and a dictionary of picker information, also the prompt of what the answer should be
   
    self.choices = toolbarData.choices;
    self.pickerView.showsSelectionIndicator = YES;
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    [self.pickerView reloadAllComponents];
    if (toolbarData.buttonColor != nil) {
        self.sendButton.tintColor = toolbarData.buttonColor;
    }
    if (toolbarData.answerPrefix != nil) {
        self.answerPrefixLabel.text = toolbarData.answerPrefix;
        self.answerPrefixLabel.textColor = toolbarData.promptColor;
    } else {
        self.answerPrefixLabel.text = @"";
    }
    
    self.delegate = toolbarData.toolbarDelegate;
    self.sendButton.enabled = NO;
    [self setupDefaultFirstRowChosen];
}

- (IBAction)sendButtonWasTapped:(id)sender {
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(customToolbarSendButtonWasPressed:)]) {
            [self.delegate customToolbarSendButtonWasPressed:@[self.selectedChoice]];
        }
    }
}

- (void)setupDefaultFirstRowChosen {
    [self.pickerView selectRow:0 inComponent:0 animated:false];
    self.selectedChoice = @{@(0) : self.choices[0]};
    self.sendButton.enabled = YES;
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
    self.selectedChoice = @{@(row) :self.choices[row]};
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.choices.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    JSQSingleSelectResponseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    [cell configureCell:self.choices[indexPath.row]];
    

}




@end
