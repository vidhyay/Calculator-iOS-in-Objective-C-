//
//  CalculatorBrain.h
//  2018-09-22 CalulatorBrain
//
//  Created by vidhya on 9/22/18.
//  Copyright © 2018 sage design. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject
-(double) startCalulation;
-(void) pushObject:(id) object;
-(void) clearAllObjects;
@end
