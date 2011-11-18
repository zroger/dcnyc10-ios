//
//  MREntitiesConverter.h
//  https://discussions.apple.com/message/8064367?messageID=8064367#8064367
//

#import <Foundation/Foundation.h>

@interface MREntitiesConverter : NSObject <NSXMLParserDelegate> {
    NSMutableString* resultString;
}

@property (nonatomic, retain) NSMutableString* resultString;
- (NSString *)convertEntiesInString:(NSString *)s;

@end