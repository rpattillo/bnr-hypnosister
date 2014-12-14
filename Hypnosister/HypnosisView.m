//
//  HypnosisView.m
//  Hypnosister
//
//  Created by Ricky Pattillo on 12/14/14.
//  Copyright (c) 2014 Ricky Pattillo. All rights reserved.
//

#import "HypnosisView.h"

@implementation HypnosisView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
   CGRect bounds = self.bounds;
   CGPoint center;
   center.x = bounds.origin.x + bounds.size.width / 2.0;
   center.y = bounds.origin.y + bounds.size.height / 2.0;
   float radius = (MIN(bounds.size.width, bounds.size.height) / 2.0);
   
   [[UIColor lightGrayColor] setStroke];
   
   UIBezierPath *path = [[UIBezierPath alloc] init];
   [path addArcWithCenter:center
                   radius:radius
               startAngle:0
                 endAngle:2 * M_PI
                clockwise:YES];

   path.lineWidth = 10;
   
   [path stroke];
}


@end
