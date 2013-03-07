//
//  PlotView.m
//  iWallet
//
//  Created by lab on 1/29/13.
//  Copyright (c) 2013 lab. All rights reserved.
//

#import "PlotView.h"

@interface PlotView() {
    
    NSArray *plotSpendings;
    int paddingH;
    int paddingV;
    int plotWidth;
    int plotHeight;
}

@end


@implementation PlotView



CGColorRef CreateDeviceGrayColor(CGFloat w, CGFloat a)
{
	CGColorSpaceRef gray = CGColorSpaceCreateDeviceGray();
	CGFloat comps[] = {w, a};
	CGColorRef color = CGColorCreate(gray, comps);
	CGColorSpaceRelease(gray);
	return color;
}

CGColorRef graphBackgroundColor()
{
	static CGColorRef c = NULL;
	if(c == NULL)
	{
		c = CreateDeviceGrayColor(0.0, 0.85);
	}
	return c;
}

CGColorRef graphLineColor()
{
	static CGColorRef c = NULL;
	if(c == NULL)
	{
		c = CreateDeviceGrayColor(0.0, 1.0);
	}
	return c;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    
    // Initialization code
        // default
        paddingH = 10;
        paddingV = 15;
        plotWidth = 320;
        plotHeight = 180;
        
    self.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1.0];
//    CALayer *layer = [[CALayer alloc] init];
//    layer.frame = CGRectMake(3, 3, self.frame.size.width - 8, self.frame.size.height - 8);
//    layer.borderWidth = 1.0f;
//    layer.cornerRadius = 5;
//    layer.backgroundColor = [UIColor colorWithRed:236.0/255 green:229.0/255 blue:182.0/255 alpha:1.0].CGColor;
//    layer.borderColor = [UIColor redColor].CGColor;
//    
//    [self.layer addSublayer:layer];
    plotWidth = self.frame.size.width-paddingV;
    plotHeight = self.frame.size.height-paddingH;

    }
    return self;
}

- (void) updateDataByCategory:(Category *)cat;
{
    plotSpendings = nil;

    plotSpendings = [self.plotNaviStrategy classifyCurrentForCategory:cat];
    // update view
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void) drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(context, graphLineColor());
    // draw y axis
    CGContextBeginPath(context);
	CGContextMoveToPoint(context, paddingV, paddingH);
	CGContextAddLineToPoint(context, paddingV, plotHeight - paddingH);
    CGContextSetLineWidth(context, 1.0);
	CGContextStrokePath(context);
    
    // draw gridlines
    // get max spending
    
    //float yGridLineRange = (plotHeight / maxSpending)
    plotSpendings = [self normalizeValues:plotSpendings intoRangeFrom:0 to:plotHeight-2*paddingH];

    for (int i = 10; i < plotHeight; i+= 10) {
		
		CGContextMoveToPoint(context, paddingV, i);
		CGContextAddLineToPoint(context, plotWidth, i);
		CGContextStrokePath(context);
        
        // draw y axis labels
        int reverseIndex = (i/10);
        if(reverseIndex < 16){
            [[NSString stringWithFormat:@"%i", reverseIndex*5] drawInRect:
                 CGRectMake(4, (plotHeight-paddingH) - reverseIndex*10, paddingV, paddingH)
                                                     withFont:[UIFont systemFontOfSize:paddingH - 4]
                                                lineBreakMode:NSLineBreakByWordWrapping
                                                    alignment:NSTextAlignmentLeft];
        }
        else{
            [@"€" drawInRect:
             CGRectMake(4, (plotHeight-paddingH) - reverseIndex*10, paddingV, paddingH)
                                                                 withFont:[UIFont systemFontOfSize:paddingH - 2]
                                                            lineBreakMode:NSLineBreakByWordWrapping
                                                                alignment:NSTextAlignmentLeft];
        }
	}
    
    // draw x axis
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, paddingV, plotHeight - paddingH);
    CGContextAddLineToPoint(context, plotWidth, plotHeight - paddingH);
    CGContextStrokePath(context);

    [self drawDataColumnPlot:context];
    
}


- (void)drawDataNormalPlot:(CGContextRef) context
{
    // init variables
    float originx = paddingV; float originy = plotHeight - paddingH;
    float xAxisLength = (plotWidth - 2*paddingV)/30; // 30 days in monthly mode
    float destX = paddingV + xAxisLength;
    int counter = 1;
    
    // draw x axis label 0
    [[NSString stringWithFormat:@"%i", 0] drawInRect:
     CGRectMake(paddingV, plotHeight - 6, paddingV, paddingH)
                                                  withFont:[UIFont systemFontOfSize:paddingH - 4]
                                             lineBreakMode:NSLineBreakByWordWrapping
                                                 alignment:NSTextAlignmentLeft];
    
    
    for (NSString *str in plotSpendings) {
        float xValue = [str floatValue];
        // draw 1 data line
        [self drawLineInContext:context
                        originX:originx
                        originY:originy
                          destX:destX
                          destY:(plotHeight-paddingH) - xValue*2
                          width:1];
        
        
        // draw x axis label
        [[NSString stringWithFormat:@"%i", counter] drawInRect:
         CGRectMake(destX, plotHeight - 6, xAxisLength, paddingH)
                                                             withFont:[UIFont systemFontOfSize:paddingH - 3]
                                                        lineBreakMode:NSLineBreakByWordWrapping
                                                            alignment:NSTextAlignmentLeft];
        originx = destX;
        destX +=xAxisLength;
        originy = (plotHeight-paddingH) - xValue*2;
        //NSLog(@"data item:%@, originx:%f, originy:%f", str, originx, originy);
        
        counter++;
    }
    
}

- (void) drawDataColumnPlot:(CGContextRef)context
{
    // init variables
    float xAxisLength = (plotWidth - 2*paddingV)/(plotSpendings.count-1);
    float originx = paddingV+xAxisLength/2; float originy = plotHeight - paddingH;
    float destX = originx;
    int counter = 1;

    for (NSNumber *str in plotSpendings) {
        float xValue = [str floatValue];
        // draw 1 data line
        [self drawLineInContext:context
                        originX:originx
                        originY:originy
                          destX:destX
                          destY:(plotHeight - paddingH) - xValue
                          width:xAxisLength - 0.5];
        
        
        // draw x axis label
        [[NSString stringWithFormat:@"%i", counter] drawInRect:
         CGRectMake(destX-2, plotHeight - 6, xAxisLength, paddingH)
                                                      withFont:[UIFont systemFontOfSize:paddingH - 3]
                                                 lineBreakMode:NSLineBreakByWordWrapping
                                                     alignment:NSTextAlignmentLeft];

        originx +=xAxisLength;
        destX +=xAxisLength;
        //originy = (plotHeight-paddingH) - xValue*2;
        
        counter++;
    }
    
}

- (void)drawLineInContext:(CGContextRef)context originX:(float)x1 originY:(float)y1 destX:(float)x2 destY:(float)y2 width:(float)width
{
        CGContextSetRGBStrokeColor(context, 0.6, 0.3, 0.7, 1.0);
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, x1, y1);
        CGContextAddLineToPoint(context, x2, y2);
        CGContextSetLineWidth(context, width);
        CGContextStrokePath(context);
}

-(NSArray*) normalizeValues:(NSArray*)array intoRangeFrom:(float)x to:(float)y
{
    
    float maxValue = [[array valueForKeyPath:@"@max.floatValue"] floatValue];
    float minValue = [[array valueForKeyPath:@"@min.floatValue"] floatValue];
    float range = maxValue - minValue;
    
    NSMutableArray *normalizedArray = [[NSMutableArray alloc] init];
    
    for (id value in array) {
        [normalizedArray addObject:[NSNumber numberWithFloat:([value floatValue] - minValue)/range]];
    }
    
    float range2 = y - x;
    for (int i = 0; i< normalizedArray.count; i++) {
        NSNumber *normalV = [NSNumber numberWithFloat:([[normalizedArray objectAtIndex:i] floatValue]*range2 + x)];
        [normalizedArray replaceObjectAtIndex:i withObject:normalV];
        
        //NSLog(@" %.2f - %.2f", [[array objectAtIndex:i] floatValue], [normalV floatValue]);
    }

    return normalizedArray;
}


@end
