//
//  ViewController.m
//  AmazingRunningMatrixLED
//
//  Created by Hoàng Thái on 12/15/15.
//  Copyright © 2015 HOANGTHAI. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    CGFloat _margin;
    CGFloat _ballDiameter;
    int _numberOfColumn;
    int _numberOfRow;
    int _tag1, _tag2;
    NSTimer* _timer;
    int dem;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _margin = 40.0;
    _ballDiameter = 24.0;
    _numberOfRow = 15;
    _numberOfColumn = 10;
    _tag1 = 1;
    dem = 1;
    [self drawBallsMatrixWithNumberOfRow:_numberOfRow andNumberOfColumn:_numberOfColumn];
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(runningLedZigZag1) userInfo:nil repeats:true];
}

- (void) placeGreenBallAtX: (CGFloat) x 
                      andY: (CGFloat) y 
                   withTag: (int) tag
{
    UIImageView* ball = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"green"]];
    ball.center = CGPointMake(x, y);
    ball.tag = tag;
    [self.view addSubview:ball];
}

- (CGFloat) spaceBetweenColumnWithNumberOfColumn: (int) Column {
    return (self.view.bounds.size.width - 2 * _margin) / (Column - 1);
}

- (CGFloat) spaceBetweenRowWithNumberOfRow: (int) Row {
    return (self.view.bounds.size.height - 2 * _margin) / (Row - 1);
}

- (void) drawBallsMatrixWithNumberOfRow: (int) numberOfRow 
                      andNumberOfColumn: (int) numberOfColumn
{
    for (int i = 0; i < numberOfRow; i++)
    {
        for (int j = 0; j < numberOfColumn; j++)
        {
            [self placeGreenBallAtX:_margin + j * [self spaceBetweenColumnWithNumberOfColumn:numberOfColumn]
                               andY:_margin + i * [self spaceBetweenRowWithNumberOfRow:numberOfRow]
                            withTag:i * numberOfColumn + j + 1];
        }
    }
}

- (void) turnONLed: (int) tag {
    UIView* view = [self.view viewWithTag:tag];
    if (view && [view isMemberOfClass:[UIImageView class]]) {
        UIImageView* ball = (UIImageView*) view;
        ball.image = [UIImage imageNamed:@"blue"];
    }
}

- (void) turnOFFLed: (int) tag {
    UIView* view = [self.view viewWithTag:tag];
    if (view && [view isMemberOfClass:[UIImageView class]]) {
        UIImageView* ball = (UIImageView*) view;
        ball.image = [UIImage imageNamed:@"green"];
    }
}

- (BOOL) checkTag: (int) tag {
    for (int i = 1; i <= _numberOfRow; i++)
    {
        int temp = i * _numberOfColumn;
        if (tag == temp) {
            return true;
        }
    }
    return false;
}

- (BOOL) checkTag2: (int) tag {
    for (int i = 1; i <= _numberOfRow; i++)
    {
        int temp = i * _numberOfColumn + 1;
        if (tag == temp) {
            return true;
        }
    }
    return false;
}

- (BOOL) checkNumber: (int) temp {
    if (temp % 2 == 0) {
        return true;
    }
    return false;
}

- (void) runningLedZigZag1 {
    if (true) {
        [self turnOFFLed:_tag1];
    }
    if (![self checkTag:_tag1] && ![self checkNumber:dem]) {
        _tag1++;
    }
    else if ([self checkTag:_tag1]) {
        dem++;
        _tag1 = dem * _numberOfColumn;
    }
    if (![self checkTag2:_tag1] && [self checkNumber:dem]) {
        _tag1--;
    }
    else if ([self checkTag2:_tag1]) {
        _tag1 = dem * _numberOfColumn + 2;
        dem++;
    }
    [self turnONLed:_tag1];
}

@end
