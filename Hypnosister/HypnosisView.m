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


- (instancetype)initWithFrame:(CGRect)frame
{
   self = [super initWithFrame:frame];
   if (self ) {
      self.backgroundColor = [UIColor clearColor];
      self.circleColor = [UIColor lightGrayColor];
   }
   
   return self;
}


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


@end
