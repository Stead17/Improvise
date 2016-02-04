//
//  ViewController.m
//  Improvise
//
//  Created by Ваня Ткаченко on 20.08.15.
//  Copyright © 2015 Stead_Company. All rights reserved.
//

#import "ViewController.h"
#import "SettingViewController.h"

@interface ViewController () {
    SettingViewController *settingViewController;
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    NSLog(@"In viewdidload");
//    DifferentColors color;
    
    animationMode = 1;
    
//    UIColor *myColor = [UIColor colorWithRed:0.0 green:10/255.0 blue:102/255.0 alpha:1.0];
    UIColor *myColor = [UIColor blackColor];
    mainColor = myColor;
    self.view.backgroundColor = mainColor;
    
    UIPanGestureRecognizer *tapper = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [self.view addGestureRecognizer:tapper];
 
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressTapped:)];
    longPress.numberOfTapsRequired = 1;
    longPress.minimumPressDuration = 0.0;
    
    [self tapped:tapper];
    [self longPressTapped:longPress];
    [self buttonCreator];
    


}

-(void) tapped: (UIPanGestureRecognizer*) tapper {
    CGPoint tappedPoint = [tapper locationInView:self.view];
    [self animations:tappedPoint];
}

-(void) longPressTapped: (UILongPressGestureRecognizer *) longPress {
    
    unsigned int toolBarActivatorSizeParametr = 40;
    UIView *toolBarActivator = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - toolBarActivatorSizeParametr, toolBarActivatorSizeParametr, toolBarActivatorSizeParametr)];
    toolBarActivator.backgroundColor = mainColor;
    [self.view addSubview:toolBarActivator];
    [toolBarActivator addGestureRecognizer:longPress];
    
    [self.navigationController setToolbarHidden:NO animated:YES];
    
}

-(void) animations: (CGPoint) tappedPoint {
        NSLog(@"In animations");
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 20, self.view.frame.size.height / 2 - 20, 40, 40)];
    view.backgroundColor = [UIColor blueColor];
    view.layer.cornerRadius = 20;
    
    if (animationMode == 1) {
        view.center = self.view.center;
    } else if (animationMode == 2) {
        view.center = tappedPoint;
    }
    
    view.alpha = 0.0;
    view.transform = CGAffineTransformMakeScale(0.0, 0.0);
    [self.view addSubview:view];
    
    [UIView animateWithDuration:5.0 animations:^{
        view.alpha = 1.0;
        
        if (animationMode == 1) {
            view.center = tappedPoint;
        } else if (animationMode == 2) {
            view.center = self.view.center;
        }
        
        view.transform = CGAffineTransformMakeScale(1.0, 1.0);
        view.backgroundColor = [UIColor yellowColor];
        
        [UIView animateWithDuration:3.0 delay:4.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            view.alpha = 0.0;
        } completion:^(BOOL finished) {
            [view removeFromSuperview ];
        }];
    }];
}


-(void) buttonCreator {
    UIBarButtonItem *barButtonAlligment = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    // mode 1 - from center to tapped point
    UIBarButtonItem *barButtonOne = [[UIBarButtonItem alloc] initWithTitle:@"From center" style:UIBarButtonItemStylePlain
                                            target:self action:nil];
    [barButtonOne setTintColor:[UIColor redColor]];
    [barButtonOne setTag:1];
    [barButtonOne setAction:@selector(animationModeChange:)];
    
    // mode 2 - form tapped point to center
    UIBarButtonItem *barButtonTwo = [[UIBarButtonItem alloc] initWithTitle:@"To center" style:UIBarButtonItemStylePlain
                                            target: self action:nil];
    [barButtonTwo setTintColor:[UIColor redColor]];
    [barButtonTwo setTag:2];
    [barButtonTwo setAction:@selector(animationModeChange:)];
    
    UIImage *settingIcon = [UIImage imageNamed:(@"settingIcon")];
    
    UIBarButtonItem *barButtonThree = [[UIBarButtonItem alloc] initWithImage:settingIcon style:UIBarButtonItemStylePlain target:self action:nil];
    [barButtonThree setTag:3];
    [barButtonThree setAction:@selector(animationModeChange:)];
    
    NSMutableArray *barButtonArray = [[NSMutableArray alloc] initWithObjects:barButtonAlligment, barButtonOne, barButtonTwo, barButtonAlligment, barButtonThree, nil];
    self.toolbarItems = barButtonArray;
    
}

-(void) animationModeChange: (UIBarButtonItem*) barButton {
    if([barButton isKindOfClass:[UIBarButtonItem class]]) {
        NSLog(@"%li", (long)[barButton tag]);
        switch ([barButton tag]) {
            case 1: {
                animationMode = 1;
                [self.navigationController setToolbarHidden:YES animated:YES];
                break;
            }
            case 2: {
                animationMode = 2;
                [self.navigationController setToolbarHidden:YES animated:YES];
                break;
            }
            case 3: {
                UITableViewController *setViewController = [[SettingViewController alloc] initWithStyle:UITableViewStyleGrouped];
                [self.navigationController pushViewController:setViewController animated:YES];
                break;
            }
            default: {
                NSLog(@"Bad😕 %li", (long)[barButton tag]);
                break;
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"viewWillAppear");
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.navigationController.toolbar.backgroundColor = [UIColor blueColor];
    [self.navigationController setToolbarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
}

@end