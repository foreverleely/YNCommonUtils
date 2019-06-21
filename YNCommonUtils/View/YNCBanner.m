//
//  YNCBanner.m
//  YNCommonUtilsDemo
//
//  Created by liyangly on 2019/6/21.
//  Copyright © 2019 liyang. All rights reserved.
//

#import "YNCBanner.h"
#import "YNCMacroHeader.h"

@interface YNCBanner ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger numberOfPages;
@property (nonatomic, assign) BOOL beginDrag;
@property (nonatomic, strong) NSArray *viewList;
@property (nonatomic, assign) CGFloat timeInterval;
@property (nonatomic, strong) UIImage *placeholder;

@end

@implementation YNCBanner

- (instancetype)initViewWithFrame:(CGRect)frame ViewList:(NSArray *)viewList timeInterval:(CGFloat)timeInterval {
    if (self = [super initWithFrame:frame]) {
        self.viewList = viewList;
        self.numberOfPages = viewList.count - 2;
        self.timeInterval = timeInterval;
        [self setupContentWithView];
        [self addTimer];
        
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPageHandle)]];
    }
    return self;
}

- (void)setupContentWithView {
    NSInteger count = self.viewList.count;
    for (int i = 0; i < count; i++) {
        UIView *view = self.viewList[i];
        CGRect rect = CGRectMake(i * YNCWIDTH(self), 0, YNCWIDTH(self), YNCHEIGHT(self));
        view.frame = rect;
        [self.scrollView addSubview:view];
    }
    [self setupScrollView:count];
}

- (void)setupScrollView:(NSInteger)count {
    self.scrollView.contentSize = CGSizeMake(YNCWIDTH(self) * count, 0);
    self.scrollView.contentOffset = CGPointMake(YNCWIDTH(self), 0);
}

- (void)addTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval: self.timeInterval target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)nextImage {
    NSInteger page = self.pageControl.currentPage + 2;
    [self.scrollView setContentOffset:CGPointMake(page * YNCWIDTH(self), 0) animated:true];
}

- (void)removeTimer {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)offsetLogic {
    if (self.pageControl.currentPage == 0) {
        self.scrollView.contentOffset = CGPointMake(YNCWIDTH(self), 0);
    }
    if (self.pageControl.currentPage == self.numberOfPages - 1) {
        self.scrollView.contentOffset = CGPointMake(YNCWIDTH(self) * self.numberOfPages, 0);
    }
}

- (void)tapPageHandle {
    if (self.yn_clickPage) {
        self.yn_clickPage(self.pageControl.currentPage);
    }
}

#pragma mark - UIScrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int page = (scrollView.contentOffset.x + YNCWIDTH(self) * 0.5) / YNCWIDTH(self);
    if (page == self.numberOfPages + 1) {
        self.pageControl.currentPage = 0;
    }else if (page == 0) {
        self.pageControl.currentPage = self.numberOfPages - 1;
    }else {
        self.pageControl.currentPage = page - 1;
    }
    if (self.yn_updatePageIndex) {
        self.yn_updatePageIndex(self.pageControl.currentPage);
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.beginDrag = true;
    [self removeTimer];
    [self offsetLogic];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    int page = (scrollView.contentOffset.x + YNCWIDTH(self) * 0.5) / YNCWIDTH(self);
    if (page == self.numberOfPages + 1) {
        self.scrollView.contentOffset = CGPointMake(YNCWIDTH(self), 0);
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self offsetLogic];
    self.beginDrag = false;
    [self addTimer];
}

#pragma mark - Getter

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, YNCWIDTH(self), YNCHEIGHT(self))];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = false;
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        CGFloat width = 15 * self.numberOfPages;
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(YNCWIDTH(self) / 2 - width / 2, CGRectGetHeight(self.scrollView.frame) - 20, YNCWIDTH(self), 20)];
        _pageControl.numberOfPages = self.numberOfPages;
        [self addSubview:_pageControl];
    }
    return _pageControl;
}

@end
