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
@property (nonatomic, assign) NSInteger selectedRow;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *bottomConstraint;

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
    [self.tableView registerNib:[UINib nibWithNibName:@"JSQSingleSelectResponseTableViewCell" bundle:[NSBundle bundleForClass:[JSQMessagesInputToolbar class]]] forCellReuseIdentifier:cellIdentifier];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

#pragma mark JSQToolbarSetup Protocol

- (void)setupToolbarWithData:(JSQToolbarData *)toolbarData {
    // TODO: for single select, this would carry in it, a UICOlor for the button, and a dictionary of picker information, also the prompt of what the answer should be
   
    self.choices = toolbarData.choices;
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
    [self calculateBottomConstraint:self.choices.count];
}

- (IBAction)sendButtonWasTapped:(id)sender {
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(customToolbarSendButtonWasPressed:)]) {
            [self.delegate customToolbarSendButtonWasPressed:@[self.selectedChoice]];
        }
    }
}

- (void)setupDefaultFirstRowChosen {
    self.selectedChoice = @{@(0) : self.choices[0]};
    self.sendButton.enabled = YES;
}

- (void)calculateBottomConstraint:(NSInteger)choiceCount {
    if (choiceCount == 3) {
        self.bottomConstraint.constant += 44;
        ;
    } else if (choiceCount == 2 ){
        self.bottomConstraint.constant += 88;
    } else {
        return;
    }
}

#pragma mark - UIPickerViewDataSource


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
    JSQSingleSelectResponseTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"JSQSingleSelectResponseTableViewCell" forIndexPath:indexPath];
    [cell configureCell:self.choices[indexPath.row]];
    if (indexPath.row == 0) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:[NSIndexPath indexPathWithIndex:self.selectedRow] animated:NO];
}



@end
