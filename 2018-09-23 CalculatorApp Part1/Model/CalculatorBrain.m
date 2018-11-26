//
//  CalculatorBrain.m
//  2018-09-22 CalulatorBrain
//
//  Created by vidhya on 9/22/18.
//  Copyright © 2018 sage design. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property (nonatomic,strong)NSMutableArray* equationArray;
@end

@implementation CalculatorBrain

//1. Initializing equation array
-(NSMutableArray*) equationArray{
    if (_equationArray == nil) {
        _equationArray = [[NSMutableArray alloc]init];
    }
    return _equationArray;
}

//2. Add object to array
-(void) pushObject:(id) object{
    [self.equationArray addObject:object];
}

//3.Add object at index to the array
-(void) pushObject:(id) object atIndex: (int) index{
    [self.equationArray insertObject:object atIndex:index];
}

//4. Return object at index from the array and then remove object from array
-(id) popEquationArrayAtIndex:(int) index{
    id object = [self.equationArray objectAtIndex:index];
    [self.equationArray removeObjectAtIndex:index];
    return object;
}

//5. Clear the array of all objects to start new equation
-(void) clearAllObjects{
    [self.equationArray removeAllObjects];
}

//6. Calculate  given two numbers with operator
-(double) calculateNumerOne:(double) num1 andNumberTwo:(double) num2 withOperator:(NSString*) operation {
    if([operation isEqualToString:@"+"]){
        return num1+num2;
    }else if([operation isEqualToString:@"-"]){
        return num1-num2;
    }else if([operation isEqualToString:@"*"]){
        return num1*num2;
    }else if([operation isEqualToString:@"/"]){
        return num1/num2;
    }else {
        NSLog(@"Error: Cannot calulate %f and %f with %@ opertar.",num1,num2,operation);
    }
    return 0.0;
}

//7. Calculate equation and insert result back into array
-(void)calculateEquationAtIndex:(int) index{
    double num1 = [[self popEquationArrayAtIndex:index] doubleValue];
    NSString *opr = [self popEquationArrayAtIndex:index];
    double num2 = [[self popEquationArrayAtIndex:index] doubleValue];
    double result = [self calculateNumerOne:num1 andNumberTwo:num2 withOperator:opr];
    [self pushObject:[NSNumber numberWithDouble:result] atIndex:index];
}

//8. Calculate equation based on BEDMAS
-(void) loopThroughEquationFromStartIndex:(int) startIndex toEndIndex:(int) endIndex{
    for (int i=startIndex; i<endIndex; i++) {
        id object = [self.equationArray objectAtIndex:i];
        if ([object isKindOfClass:[NSString class]]) {
            char opr = (char)[object characterAtIndex:0];
            if (opr == '*' || opr == '/') {
                [self calculateEquationAtIndex:(i-1)];
                endIndex = endIndex - 2;
                i = i - 1;
            }
        }
    }
    
    for (int i=startIndex; i<endIndex; i++) {
        id object = [self.equationArray objectAtIndex:i];
        if ([object isKindOfClass:[NSString class]]) {
            char opr = (char)[object characterAtIndex:0];
            if (opr == '+' || opr == '-') {
                [self calculateEquationAtIndex:(i-1)];
                endIndex = endIndex - 2;
                i = i - 1;
            }
        }
    }
}

//9. Remove brackets
-(void) removeBracketStartAt:(int) startInedx endAt:(int) endIndex{
    [self popEquationArrayAtIndex:startInedx];
    [self popEquationArrayAtIndex:(endIndex-1)];
    [self loopThroughEquationFromStartIndex:startInedx toEndIndex:(endIndex-2)];
}

//10. Find close bracket when given index of open bracket
-(void) findCloseBracketStartAt:(int) beginIndex{
    for (int i=beginIndex+1; i<[self.equationArray count]; i++) {
        id object = [self.equationArray objectAtIndex:i];
        if ([object isKindOfClass:[NSString class]]) {
            if ([object isEqualToString:@")"]) {
                [self removeBracketStartAt:beginIndex endAt:i];
                break;
            } else if ([object isEqualToString:@"("]) {
                [self findCloseBracketStartAt:i];
            }
        }
    }
}

//11.Find open bracket
-(void) findOpenBracketStartAt:(int) index{
    for (int i=index; i<[self.equationArray count]; i++) {
        id object = [self.equationArray objectAtIndex:i];
        if ([object isKindOfClass:[NSString class]]) {
            if ([object isEqualToString:@"("]) {
                [self findCloseBracketStartAt:i];
            }
        }
    }
}

//12. Remove empty elements arrays
-(void) removeEmpty {
    for (int i=0; i<[self.equationArray count]; i++) {
        if ([[self.equationArray objectAtIndex:i] isKindOfClass:[NSString class]]) {
            if ([[self.equationArray objectAtIndex:i] isEqualToString:@")"]) {
                [self popEquationArrayAtIndex:(i+1)];
            }
        }
    }
}

//13. Start calculating the user input
-(double) startCalulation {
    [self removeEmpty];
    [self findOpenBracketStartAt:0];
    while ([self.equationArray count] > 1) {
        int endIndex = (int)[self.equationArray count];
        [self loopThroughEquationFromStartIndex:0 toEndIndex:endIndex];
    }
    return [[self.equationArray objectAtIndex:0] doubleValue];
}
@end
