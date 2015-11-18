//
//  JSQToolbarData.h
//  Pods
//
//  Created by Gregory Boland on 11/17/15.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class JSQMessagesInputToolbar;

typedef NS_ENUM(NSInteger, JSQInputToolbarType) {
    Standard,
    BinaryButton,
    SingleSelect,
    MultiSelect,
    Picker
};

@interface JSQToolbarData : NSObject

@property (nonatomic, assign) JSQInputToolbarType toolbarType;
@property (nonatomic, strong) NSArray *choices;
@property (nonatomic, copy) UIColor *buttonColor;


- (instancetype)initWithData:(JSQInputToolbarType)toolbarType choices:(NSArray *)choicesArray buttonColor:(UIColor *)buttonColor;

@end
