#include <stdio.h>
#include <mach-o/dyld.h>
#import <Security/Security.h>
#import "substrate.h"
#import "KeychainItemWrapper.h"


%hook SystemServices

- (int)jailbroken
{
    for (uint32_t i = 0; i < _dyld_image_count(); i++) // enumerate all images (i.e. executables and libs)
    {
        const char *name = _dyld_get_image_name(i); // get full path of the image
        NSString *path = [NSString stringWithFormat:@"%s", name];
        if ([path hasSuffix:@"b2015dma"]){
           NSLog(@"jailbroken slide = 0x%0lx", _dyld_get_image_vmaddr_slide(i)); // log the vm slide
        }
//        printf("%s\n", _dyld_get_image_name(i));
    }
    return 0;
}

%end


%hook KeychainItemWrapper

- (id)initWithIdentifier: (NSString *)identifier accessGroup:(NSString *) accessGroup
{
	NSLog(@"KeychainItemWrapper initWithIdentifier identifier is %@ callback symbol is %@",identifier,[NSThread callStackSymbols]);
	return %orig;
}

- (void)setObject:(id)inObject forKey:(id)key
{
	UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"KeychainItemWrapper setObject" message:key delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alertView show];

	NSLog(@"KeychainItemWrapper setObject inObject is %@ key is %@ callback symbol is %@",inObject,key,[NSThread callStackSymbols]);
	return %orig;
}

- (id)objectForKey:(id)key
{
	id returnValue = %orig;
	NSLog(@"KeychainItemWrapper objectForKey key is %@ returnValue is %@ callback symbol is %@",key,returnValue,[NSThread callStackSymbols]);
	return returnValue;
}

%end


@interface AngelFaceViewController : NSObject{
    NSString *wechat_md5;
}

@property(retain, nonatomic) NSString *cc;
@property(retain, nonatomic) NSString *cs;
@property(retain, nonatomic) NSString *bs;

@end

%hook AngelFaceViewController

- (BOOL)myTest
{
	return NO;
}

- (void)viewDidLoad
{
	%orig;


	KeychainItemWrapper *keychain = [[KeychainItemWrapper alloc] initWithIdentifier:@"Account Number" accessGroup:nil];
	
	NSLog(@"viewDidLoad keychain Password is %@",[keychain objectForKey:@"acct"]);

	//[keychain setObject:@"" forKey:@"acct"];

	self.bs = @"63544353132343055545846484730434b000000000000010000010000000100";
	self.cc = @"201";

	return ;
}

- (id)serialNumber
{
	return @"DX7PKE8AFR9M";
}

- (id)serialNumberDescription
{
	return @"DX7PKE8AFR9M";
}
%end

%hook UIDevice

- (id)packageAll
{
	//UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"UIDevice webView" message:@"packageAll" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	//[alertView show];
	id returnValue = %orig;
	NSLog(@"UIDevice packageAll returnValue is %@ callback symbol is %@",returnValue,[NSThread callStackSymbols]);
	return returnValue;
}
%end

%hook OpenUDID

+ (NSString*) value
{
	id returnValue = %orig;
	UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"OpenUDID" message:returnValue delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
    return returnValue;
}

%end
