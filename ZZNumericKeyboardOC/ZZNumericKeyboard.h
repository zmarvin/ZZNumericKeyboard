//
//  ZZNumericKeyboard.h
//  ZZNumericKeyboard
//
//  Created by zz on 15/7/30.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZZNumericKeyboardDelegate <NSObject>

- (void) numberKeyboardInput:(NSInteger)number;
- (void) stringKeyboardInput:(NSString *)str;
- (void) numberKeyboardBackspace;

@end

@interface ZZNumericKeyboard : UIView
{
    NSArray *arrLetter;
}
@property (nonatomic,weak) id<ZZNumericKeyboardDelegate> delegate;

@end
