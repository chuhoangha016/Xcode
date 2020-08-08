//
//  solveExpression.m
//  Graph
//
//  Created by Mac House on 7/18/19.
//  Copyright © 2019 myself. All rights reserved.
//

#import "solveExpression.h"

@implementation solveExpression

+ (BOOL)tryBlock:(void(^)(void))tryBlock
           error:(NSError **)error
{
    @try {
        tryBlock ? tryBlock() : nil;
    }
    @catch (NSException *exception) {
        return NO;
    }
    return YES;
}

@end
