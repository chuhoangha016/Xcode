//
//  solveExpression.h
//  Graph
//
//  Created by Mac House on 7/18/19.
//  Copyright © 2019 myself. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface solveExpression : NSObject

+ (BOOL)tryBlock:(void(^)(void))tryBlock
           error:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
