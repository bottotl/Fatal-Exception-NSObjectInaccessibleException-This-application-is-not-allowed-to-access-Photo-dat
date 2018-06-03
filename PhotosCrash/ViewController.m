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

@property (nonatomic, strong) PHImageManager *manager;
@property (nonatomic, strong) NSMutableArray *assets;
@property (nonatomic, strong) dispatch_queue_t queue;
@property (nonatomic, assign) BOOL stop;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.photos = @[].mutableCopy;

    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [btn setTitle:@"按钮" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor blackColor];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    self.manager = [PHImageManager defaultManager];
    PHFetchResult *result = [PHAsset fetchAssetsWithOptions:nil];
    NSMutableArray *photos = @[].mutableCopy;;
    for (PHAsset *asset in result) {
        [photos addObject:asset];
    }
    self.assets = photos;
    
//    [self.manager startCachingImagesForAssets:self.assets targetSize:CGSizeMake(300, 300) contentMode:PHImageContentModeDefault options:nil];
    [self.assets enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx>10) {
            *stop = YES;
        }
        PHImageRequestOptions *options = [PHImageRequestOptions new];
        options.networkAccessAllowed = YES;
        [[PHImageManager defaultManager] requestImageForAsset:(PHAsset *)obj targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeDefault options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            
        }];
    }];
    
    self.queue = dispatch_queue_create("test", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(self.queue, ^{
        while (1) {
            if (self.stop) {
                [NSThread sleepForTimeInterval:1];
            }
            
            UIImage *image = [UIImage imageNamed:@"1"];
            NSData *data = UIImageJPEGRepresentation(image, 1);
            UIImage *newImage = [UIImage imageWithData:data];
            [self.photos addObject:newImage];
        }
    });
}

- (void)btnClick:(id)sender {
    NSLog(@"log ==== === ===");
}

- (void)didReceiveMemoryWarning {
    self.stop = YES;
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    NSLog(@"memory warning");
}


@end
