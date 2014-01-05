//
//  SCPageViewController.m
//  SCPaggingNavbar
//
//  Created by Singro on 1/5/14.
//  Copyright (c) 2014 Singro. All rights reserved.
//

#import "SCPageViewController.h"

@interface SCPageViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIView *navbarView;

@property (nonatomic, strong) UILabel *navTitleLabel1;
@property (nonatomic, strong) UILabel *navTitleLabel2;
@property (nonatomic, strong) UILabel *navTitleLabel3;

@end

@implementation SCPageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView {
    [super loadView];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.delegate = self;
    self.scrollView.bounces = NO;
    [self.view addSubview:self.scrollView];
    
    self.scrollView.contentSize = (CGSize){320*3, CGRectGetHeight(self.view.frame)};
    
    for (int i = 0; i < 3; i ++) {
        UIView *page1View = [UIView new];
        page1View.backgroundColor = [UIColor colorWithWhite:0.5 * i alpha:1.0];
        page1View.frame = (CGRect){320 * i, 0, 320, CGRectGetHeight(self.view.frame)};
        [self.scrollView addSubview:page1View];
    }
    

    self.navbarView = [[UIView alloc] init];
    
    self.navTitleLabel1 = [UILabel new];
    self.navTitleLabel1.text = @"title1";
    self.navTitleLabel1.frame = (CGRect){140, 8, 40, 20};
    [self.navbarView addSubview:self.navTitleLabel1];

    self.navTitleLabel2 = [UILabel new];
    self.navTitleLabel2.text = @"title2";
    self.navTitleLabel2.frame = (CGRect){240, 8, 40, 20};
    [self.navbarView addSubview:self.navTitleLabel2];

    self.navTitleLabel3 = [UILabel new];
    self.navTitleLabel3.text = @"title3";
    self.navTitleLabel3.frame = (CGRect){340, 8, 40, 20};
    [self.navbarView addSubview:self.navTitleLabel3];
    
    self.pageControl = [[UIPageControl alloc] init];
    self.pageControl.frame = (CGRect){0, 35, 0, 0};
    self.pageControl.numberOfPages = 3;
    self.pageControl.currentPage = 0;
    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    self.pageControl.pageIndicatorTintColor = [UIColor greenColor];
    [self.navbarView addSubview:self.pageControl];

    [self.navigationController.navigationBar addSubview:self.navbarView];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.navbarView.frame = (CGRect){0, 0, 320, 44};
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat xOffset = scrollView.contentOffset.x;
    
    self.navTitleLabel1.frame = (CGRect){140 - xOffset/3.2, 8, 40, 20};
    self.navTitleLabel2.frame = (CGRect){240 - xOffset/3.2, 8, 40, 20};
    self.navTitleLabel3.frame = (CGRect){340 - xOffset/3.2, 8, 40, 20};
    
    self.navTitleLabel1.alpha = 1 - xOffset / 320;
    if (xOffset <= 320) {
        self.navTitleLabel2.alpha = xOffset / 320;
    } else {
        self.navTitleLabel2.alpha = 1 - (xOffset - 320) / 320;
    }
    self.navTitleLabel3.alpha = (xOffset - 320) / 320;

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGFloat xOffset = scrollView.contentOffset.x;
    
    if (xOffset < 1.0) {
        self.pageControl.currentPage = 0;
    } else if (xOffset < 321.0) {
        self.pageControl.currentPage = 1;
    } else {
        self.pageControl.currentPage = 2;
    }

}

@end
