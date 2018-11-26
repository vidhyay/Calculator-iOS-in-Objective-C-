//
//  CustomButton.m
//  2018-09-23 CalculatorApp Part1
//
//  Created by vidhya on 09/23/18.
//  Copyright © 2018 sage design. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

- (void)drawRect:(CGRect)rect {
    // Drawing code
    self.layer.cornerRadius = 20;
    self.clipsToBounds = YES;
}

@end
