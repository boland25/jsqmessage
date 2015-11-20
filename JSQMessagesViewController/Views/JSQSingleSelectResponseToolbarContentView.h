//
//  JSQSingleSelectResponseToolbarContentView.h
//  Pods
//
//  Created by Gregory Boland on 11/2/15.
//
//

#import <UIKit/UIKit.h>
#import "JSQMessagesInputToolbar.h"


@interface JSQSingleSelectResponseToolbarContentView : UIView <JSQToolbarSetup>

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UILabel *answerPrefixLabel;

@property (nonatomic, weak) id<JSQMessagesCustomToolbarDelegate> delegate;


- (IBAction)sendButtonWasTapped:(id)sender;

@end
