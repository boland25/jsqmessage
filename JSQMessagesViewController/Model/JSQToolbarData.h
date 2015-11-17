//
//  JSQToolbarData.h
//  Pods
//
//  Created by Gregory Boland on 11/17/15.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, JSQInputToolbarType) {
    Standard,
    BinaryButton,
    SingleSelect,
    MultiSelect,
    Picker
};

@interface JSQToolbarData : NSObject

@property (nonatomic, assign) JSQInputToolbarType toolbarType;

@end
