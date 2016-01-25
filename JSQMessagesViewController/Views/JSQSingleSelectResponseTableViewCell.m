//
//  JSQSingleSelectResponseTableViewCell.m
//  Pods
//
//  Created by Gregory Boland on 1/22/16.
//
//

#import "JSQSingleSelectResponseTableViewCell.h"

@implementation JSQSingleSelectResponseTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setAsSelected:(BOOL)isSelected {
    if (isSelected) {
        self.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        self.accessoryType = UITableViewCellAccessoryNone;
    }
}


- (void)configureCell:(id)choiceData {
    NSLog(@"CHOICE Data %@", choiceData);
    self.titleLabel.text = choiceData;
}

@end
