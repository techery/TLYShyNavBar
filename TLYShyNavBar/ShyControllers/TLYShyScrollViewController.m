//
//  TLYShyScrollViewController.m
//  TLYShyNavBarDemo
//
//  Created by Mazyad Alabduljaleel on 11/13/15.
//  Copyright © 2015 Telly, Inc. All rights reserved.
//

#import "TLYShyScrollViewController.h"
#import "../Categories/UIScrollView+Helpers.h"


@implementation TLYShyScrollViewController

- (void)offsetCenterBy:(CGPoint)deltaPoint
{
    [self updateLayoutIfNeeded];
}

- (CGFloat)updateLayoutIfNeeded
{
    if (self.scrollView.contentSize.height < FLT_EPSILON
        && ([self.scrollView isKindOfClass:[UITableView class]]
            || [self.scrollView isKindOfClass:[UICollectionView class]])
        )
    {
        return 0.f;
    }

    CGFloat parentMaxY = [self.parent maxYRelativeToView:self.scrollView.superview];
    CGFloat normalizedY = parentMaxY - self.scrollView.frame.origin.y;
    UIEdgeInsets insets = UIEdgeInsetsMake(self.scrollView.contentInset.top, 0, self.scrollView.contentInset.bottom, 0);
    insets.top = normalizedY;

    if (fabs(normalizedY) > FLT_EPSILON)
    {
        CGRect frame = self.scrollView.frame;
        frame.origin.y += normalizedY;
        frame.size.height -= normalizedY;
        self.scrollView.frame = frame;
        return [self updateLayoutIfNeeded];
    }

    return 0.f;
}

@end
