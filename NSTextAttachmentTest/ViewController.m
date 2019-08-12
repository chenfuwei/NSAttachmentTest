//
//  ViewController.m
//  NSTextAttachmentTest
//
//  Created by net263 on 2019/8/9.
//  Copyright © 2019 net263. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "CFTableViewCell.h"
#import "CFTextModel.h"
#define MAX_COUNT 1000
@interface ViewController ()<UITextViewDelegate, UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong)UILabel*label;
@property(nonatomic, strong)UITextView *textView;
@property(nonatomic, strong)AVAudioPlayer* audioPlayer;
@property(nonatomic, strong)NSMutableAttributedString* attributeString;
@property(nonatomic, strong)NSData* audioData;
@property(nonatomic, strong)NSTextAttachment* attachment;

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSMutableArray *models;
@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(10, 80, 300, 30)];
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 80 + 30 + 30, 300, 80)];
    [self.view addSubview:_label];
    [self.view addSubview:_textView];
    [self showSimpleImg];
    [self showAudioAttachment];
    [self showGifAttachment];
}

-(void)showSimpleImg
{
    NSString* a =@"测试富文本，简单图片";
    UIImage* image = [UIImage imageNamed:@"chat_zan_day"];
    NSTextAttachment* attachment = [[NSTextAttachment alloc] init];
    attachment.image = image;
    NSMutableAttributedString* attributeString = [[NSMutableAttributedString alloc] initWithString:a];
    NSAttributedString* imgAttributeString = [NSAttributedString attributedStringWithAttachment:attachment];

    //[attributeString appendAttributedString:imgAttributeString];
    [attributeString insertAttributedString:imgAttributeString atIndex:2];
    self.label.attributedText = attributeString;
    
}

-(void)showAudioAttachment
{
    NSString* a =@"测试音频附件";
    NSString* audioPath = [[NSBundle mainBundle] pathForResource:@"audio" ofType:@"mp3"];
    NSURL *url = [NSURL URLWithString:audioPath];
    NSError* error;
    //NSData* audio = [NSData dataWithContentsOfURL:url options:NSDataReadingMappedAlways error:&error]; //只加载网络图片
    self.audioData = [NSData dataWithContentsOfFile:audioPath];
    self.attachment = [[NSTextAttachment alloc] initWithData:self.audioData ofType:@"mp3"];
//    UIImage* image = [UIImage imageNamed:@"chat_zan_day"];
//    self.attachment.image = image;   //导致contents属性内容为空
    self.attachment.contents = self.audioData;  //导致image的内容为空
    NSLog(@"attachment data1 %@ error:%@", self.attachment.contents, error);
    self.attributeString = [[NSMutableAttributedString alloc] initWithString:a];
    NSAttributedString* imgAttributeString = [NSAttributedString attributedStringWithAttachment:self.attachment];
    
    //[attributeString appendAttributedString:imgAttributeString];
    NSRange range = NSMakeRange(2, imgAttributeString.length);
    NSLog(@"NSRange:%@ attachment:%@", NSStringFromRange(range), self.attachment);
    [self.attributeString insertAttributedString:imgAttributeString atIndex:range.location];
    
    [self.attributeString addAttribute:NSLinkAttributeName value:url range:range];
    self.textView.dataDetectorTypes = UIDataDetectorTypeLink;
    self.textView.attributedText = self.attributeString;
    self.textView.delegate = self;
    self.textView.editable = NO;
    self.textView.textColor = [UIColor blueColor];
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction

{
    NSLog(@"shouldInteractWithURL URL:%@ inRange:%@", URL,NSStringFromRange(characterRange));
    if(self.attributeString)
    {
       [ self.attributeString enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, self.attributeString.length) options:NSAttributedStringEnumerationReverse usingBlock:^(NSTextAttachment*   value, NSRange range, BOOL * _Nonnull stop) {
           if(value)
           {
              
               NSError* error;
                self.audioPlayer = [[AVAudioPlayer alloc] initWithData:value.contents fileTypeHint:AVFileTypeMPEGLayer3  error:&error];//此接口播放时，需要设置内容数据的格式
                [self.audioPlayer prepareToPlay];
                [self.audioPlayer play];
               NSLog(@"parse attachment:%@ contents:%@, error:%@", value, value.contents, error);
           }
        
       }];
    }

    return YES;
}

-(void)showGifAttachment
{
    CGRect bounds = [[UIScreen mainScreen] bounds];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 200, bounds.size.width, bounds.size.height) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[CFTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    
    self.models = [[NSMutableArray alloc] init];
    for ( int i = 0; i<MAX_COUNT; i++ )
    {
        CFTextModel* model = [[CFTextModel alloc] init];
        if (i % 2)
        {
            model.contentString = @"/咸蛋超人“没人在乎你怎样在深夜痛哭，/飞翔/网络图片2/飞翔也没人在乎你辗转反侧的要熬几个这是个网络下载图片这是个网络下载图片/网络图片1这是个网络下载图片这是个网络下载图片这是个网络下载图片秋。/我撞";
        }else{
            model.contentString = @"/点头等你明白了这个道理，这是个网络下载图片/网络图片1便不会再在人前矫情，/我撞四处诉说以求宽慰。/烧烤”当你知道了许多真实、虚假的东西，这是个网络下载图片这是个网络下载图片/网络图片2也就没有那么多酸情了。你越来越沉默，越来越不想说。/心烦";
            [model.attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0, model.attributedString.length)];
        }
        [self.models addObject:model];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return MAX_COUNT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CFTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    CFTextModel *model = self.models[indexPath.row];
    cell.mode = model;
    cell.label.attributedText = model.attributedString;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CFTextModel* model = self.models[indexPath.row];
    return model.height;
}
@end
