//
//  ViewController.m
//  PhotosCrash
//
//  Created by jft0m on 2018/6/3.
//  Copyright © 2018年 jft0m. All rights reserved.
//

#import "ViewController.h"
#import <Photos/Photos.h>

@interface ViewController ()
@property (nonatomic, strong) NSMutableArray *photos;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.photos = @[].mutableCopy;
    
    [PHImageManager defaultManager];
    while (1) {
        UIImage *image = [UIImage imageNamed:@"1"];
        NSData *data = UIImageJPEGRepresentation(image, 1);
        [self.photos addObject:data];
    }
}

@end
