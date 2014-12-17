//
//  HypnosisView.m
//  Hypnosister
//
//  Created by Ricky Pattillo on 12/14/14.
//  Copyright (c) 2014 Ricky Pattillo. All rights reserved.
//

#import "HypnosisView.h"

@interface HypnosisView ()

@property (strong, nonatomic) UIColor *circleColor;

@end

@implementation HypnosisView


#pragma mark - Initializers

- (instancetype)initWithFrame:(CGRect)frame
{
   self = [super initWithFrame:frame];
   if (self ) {
      self.backgroundColor = [UIColor clearColor];
      self.circleColor = [UIColor lightGrayColor];
   }
   
   return self;
}


#pragma mark - Accessors

- (void)setCircleColor:(UIColor *)circleColor
{
   _circleColor = circleColor;
   [self setNeedsDisplay];
}

#pragma mark - Overrides

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
   CGRect bounds = self.bounds;
   CGPoint center;
   center.x = bounds.origin.x + bounds.size.width / 2.0;
   center.y = bounds.origin.y + bounds.size.height / 2.0;
   float maxRadius = hypot(bounds.size.width, bounds.size.height) / 2.0;
   
   [self.circleColor setStroke];
   
   UIBezierPath *path = [[UIBezierPath alloc] init];
   for ( float currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20 ) {
      [path moveToPoint:CGPointMake(center.x + currentRadius, center.y)];
      [path addArcWithCenter:center
                      radius:currentRadius
                  startAngle:0
                    endAngle:M_PI * 2.0
                   clockwise:YES];
   }

   path.lineWidth = 10;
   
   [path stroke];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
   NSLog( @"%@ was touched", self );
   float red = (arc4random() % 101 ) / 100.0;
   float green = (arc4random() % 101 ) / 100.0;
   float blue = (arc4random() % 101 ) / 100.0;
   
   UIColor *randomColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
   
   self.circleColor = randomColor;
}


@end
