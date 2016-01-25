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
}

#pragma mark JSQToolbarSetup Protocol

- (void)setupToolbarWithData:(JSQToolbarData *)toolbarData {
    // TODO: for single select, this would carry in it, a UICOlor for the button, and a dictionary of picker information, also the prompt of what the answer should be
    self.selectedRow = 0;
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
    self.selectedChoice = @{@(self.selectedRow) : self.choices[0]};
    self.sendButton.enabled = YES;
}

- (UIView *)createBorder {
    UIView *border = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 1)];
    border.backgroundColor = [UIColor colorWithRed:0.83 green:0.83 blue:0.84 alpha:1.0];
    return border;
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
    if (indexPath.row == self.selectedRow) {
        [cell setAsSelected:YES];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //deselect the hightled row
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    //get the checkmarked cell and uncheck it
    NSLog(@"selected row %i", self.selectedRow);
    NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:self.selectedRow inSection:0];
    JSQSingleSelectResponseTableViewCell *cell = [tableView cellForRowAtIndexPath:selectedIndexPath];
    [cell setAsSelected:NO];
    
    //checkmark the new cell
    cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setAsSelected:YES];
    
    self.selectedRow = indexPath.row;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [self createBorder];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 1.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [self createBorder];
}


@end
