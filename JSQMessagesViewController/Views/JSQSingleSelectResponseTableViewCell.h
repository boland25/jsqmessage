//
//  JSQSingleSelectResponseTableViewCell.h
//  Pods
//
//  Created by Gregory Boland on 1/22/16.
//
//

#import <UIKit/UIKit.h>

@interface JSQSingleSelectResponseTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

- (void)configureCell:(id)choiceData;

@end
