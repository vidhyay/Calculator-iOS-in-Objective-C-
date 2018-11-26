//
//  ViewController.m
//  2018-09-23 CalculatorApp Part1
//
//  Created by vidhya on 9/23/18.
//  Copyright © 2018 sage design. All rights reserved.
//

#import "ViewController.h"
#import "CalculatorBrain.h"

@interface ViewController ()
@property (nonatomic,strong) CalculatorBrain *calculator;
@property (weak, nonatomic) IBOutlet UILabel *Display;
@property (nonatomic,strong) NSString *placeHolder;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CalculatorBrain*) calculator {
    if (_calculator == nil) {
        _calculator = [[CalculatorBrain alloc]init];
    }
    return _calculator;
}

-(NSString*) placeHolder {
    if (_placeHolder == nil) {
        _placeHolder = [[NSString alloc]init];
    }
    return _placeHolder;
}

- (IBAction)DigitPressed:(id)sender {
    UIButton *digit = (UIButton *)sender;
    NSString *oldDigit = self.Display.text;
    NSString *newDigit = [NSString stringWithFormat:@"%@%@",oldDigit,digit.currentTitle];
    self.placeHolder = [NSString stringWithFormat:@"%@%@",self.placeHolder,digit.currentTitle];
    self.Display.text = newDigit;
}
- (IBAction)OperatorPressed:(id)sender {
    UIButton *operator = (UIButton *)sender;
    double result = [self.placeHolder doubleValue];
    [self.calculator pushObject:[NSNumber numberWithDouble:result]];
    [self.calculator pushObject:operator.currentTitle];
    self.Display.text = [NSString stringWithFormat:@"%@%@",self.Display.text,operator.currentTitle];
    self.placeHolder = @"";
}

- (IBAction)EnterPressed:(id)sender {
    double result = [self.placeHolder doubleValue];
    [self.calculator pushObject:[NSNumber numberWithDouble:result]];
    self.Display.text = [NSString stringWithFormat:@"%0.02f",[self.calculator startCalulation]];
}

- (IBAction)ClearPressed:(id)sender {
    self.Display.text = @"";
    self.placeHolder = @"";
    [self.calculator clearAllObjects];
}

- (IBAction)BracketPressed:(id)sender {
    UIButton *operator = (UIButton *)sender;
    double result = [self.placeHolder doubleValue];
    if (result > 0) {
        [self.calculator pushObject:[NSNumber numberWithDouble:result]];
        self.placeHolder = @"";
    }
    [self.calculator pushObject:operator.currentTitle];
    self.Display.text = [NSString stringWithFormat:@"%@%@",self.Display.text,operator.currentTitle];
}

@end
