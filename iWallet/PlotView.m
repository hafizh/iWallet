//
//  PlotView.m
//  iWallet
//
//  Created by lab on 1/29/13.
//  Copyright (c) 2013 lab. All rights reserved.
//

#import "PlotView.h"

@interface PlotView() {
    
    NSArray *plotSpendings;     // Array of float values(Not spending item entities only amount)
    NSArray *normalizedItems;   // above values normalized to fit into the height of plot view
    float paddingH;
    float paddingV;
    float plotWidth;
    float plotHeight;
    float minValue;     // min amount of spending
    float maxValue;     // max amount of spendings
    int yGridLineRange; // range between y axis data lines

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

    self.backgroundColor = [UIColor colorWithRed:250.0/255 green:247.0/255 blue:198.0/255 alpha:1.0];

        
    }
    return self;
}

- (void) updateDataByCategory:(Category *)cat;
{
    plotSpendings = nil;

    paddingH = self.frame.size.height*0.05555556; //horizontal
    paddingV = self.frame.size.width*0.0375;    // vertical
    plotWidth = self.frame.size.width-paddingV;
    plotHeight = self.frame.size.height-paddingH/2;
    
    yGridLineRange = 10;
    
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
	CGContextMoveToPoint(context, 1.5*paddingV, paddingH);
	CGContextAddLineToPoint(context, 1.5*paddingV, plotHeight - paddingH);
	CGContextStrokePath(context);
    
    // normalize value into a range [0 - to plotHeight] nearly
    normalizedItems = [self normalizeValues:plotSpendings intoRangeFrom:0 to:plotHeight-2.5*paddingH];
    
    float interval = (maxValue - minValue)/10; // 10 gridlines, interval of labels

    minValue = 0;
    yGridLineRange = ceilf((plotHeight-2.5*paddingH)/10);   

    // start from bottom
    for (int i = plotHeight-paddingH; i > 3; i-= yGridLineRange) {
        CGContextBeginPath(context);
		CGContextMoveToPoint(context, 1.5*paddingV, i);
		CGContextAddLineToPoint(context, plotWidth+paddingV/2, i);
		CGContextStrokePath(context);
        
        // draw y axis labels
        [[NSString stringWithFormat:@"%.0f", minValue] drawInRect:
                 CGRectMake(0, i-paddingH+3, 1.5*paddingV, paddingH)
                                                     withFont:[UIFont systemFontOfSize:paddingH-2]
                                                lineBreakMode:NSLineBreakByWordWrapping
                                                    alignment:NSTextAlignmentCenter];
        minValue+=interval;
	}
    
    // draw x axis
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 1.5*paddingV, plotHeight - paddingH);
    CGContextAddLineToPoint(context, plotWidth+paddingV/2, plotHeight - paddingH);
    CGContextStrokePath(context);

    // draw the columns
    [self drawDataColumnPlot:context];
    
}


- (void) drawDataColumnPlot:(CGContextRef)context
{
    // init variables
    float xAxisLength = (plotWidth - 2*paddingV)/(plotSpendings.count-1); // the width of a column
    float originx = 1.5*paddingV+xAxisLength/2; float originy = plotHeight - paddingH;
    float destX = originx;

    for (int i=1; i<normalizedItems.count;i++) {
        float xValue = [[normalizedItems objectAtIndex:i] floatValue];
        
        // if value == 0 do not draw anything
        if(xValue > 0){
            // draw the column
            [self drawLineInContext:context
                            originX:originx
                            originY:originy
                              destX:destX
                              destY:(plotHeight - paddingH) - xValue
                              width:xAxisLength - 0.5];
            
            // draw actual value label
            float actualValue = [[plotSpendings objectAtIndex:i] floatValue];
            if(actualValue > 0){
                [[NSString stringWithFormat:@"%.0f", actualValue] drawInRect:
                 CGRectMake(destX-xAxisLength, (plotHeight - paddingH*0.8) - xValue, 2*xAxisLength, paddingH)
                                                                    withFont:[UIFont systemFontOfSize:paddingH-1]
                                                               lineBreakMode:NSLineBreakByWordWrapping
                                                                   alignment:NSTextAlignmentCenter];
            }
        }
        
        // draw x axis label
        if(i%2==0){
            [[NSString stringWithFormat:@"%i", i] drawInRect:
             CGRectMake(destX-xAxisLength, plotHeight - paddingH, 2*xAxisLength, paddingH)
                                                    withFont:[UIFont systemFontOfSize:paddingH-1]
                                               lineBreakMode:NSLineBreakByWordWrapping
                                                   alignment:NSTextAlignmentCenter];
        }
        
        originx +=xAxisLength;
        destX +=xAxisLength;
    }
    
}

- (void)drawLineInContext:(CGContextRef)context originX:(float)x1 originY:(float)y1 destX:(float)x2 destY:(float)y2 width:(float)width
{
        CGContextSetRGBStrokeColor(context, 226.0/255, 83.0/255, 85.0/255, 0.8);
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, x1, y1);
        CGContextAddLineToPoint(context, x2, y2);
        CGContextSetLineWidth(context, width);
        CGContextStrokePath(context);
}

-(NSArray*) normalizeValues:(NSArray*)array intoRangeFrom:(float)x to:(float)y
{
    
    maxValue = [[array valueForKeyPath:@"@max.floatValue"] floatValue];
    minValue = [[array valueForKeyPath:@"@min.floatValue"] floatValue];
    float range = maxValue - minValue;
    
    NSMutableArray *normalizedArray = [[NSMutableArray alloc] init];
    
    for (id value in array) {
        [normalizedArray addObject:[NSNumber numberWithFloat:([value floatValue] - minValue)/range]];
    }
    
    float range2 = y - x;
    for (int i = 0; i< normalizedArray.count; i++) {
        NSNumber *normalV = [NSNumber numberWithFloat:([[normalizedArray objectAtIndex:i] floatValue]*range2 + x)];
        [normalizedArray replaceObjectAtIndex:i withObject:normalV];
        
    }

    return normalizedArray;
}


@end
