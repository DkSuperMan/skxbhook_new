#include <stdio.h>
#include <mach-o/dyld.h>
#import <Security/Security.h>
#import "substrate.h"
#import "KeychainItemWrapper.h"

/*
UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"AngelFaceViewController postJson" message:@"postJson" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alertView show];
*/

%hook SSJailbreakCheck

+ (int)jailbroken
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

%hook SSHardwareInfo

+ (id)systemVersion
{
	return @"8.4";
}

+ (id)systemDeviceTypeFormatted:(BOOL)arg1
{
	return @"iPhone6,2";
}
%end

%hook SSDiskInfo

+ (long long)longDiskSpace
{
    return 12877746176;
}

%end

@interface AngelFaceViewController : NSObject{
    NSString *wechat_md5;
}

@property(retain, nonatomic) NSString *cc;
@property(retain, nonatomic) NSString *cs;
@property(retain, nonatomic) NSString *bs;

- (void)verifyUser:(id)arg1;
@end

%hook AngelFaceViewController

- (BOOL)myTest
{
	return NO;
}

- (void)viewDidLoad
{
	KeychainItemWrapper *keychain1 = [[KeychainItemWrapper alloc] initWithIdentifier:@"Account Number" accessGroup:nil];
	[keychain1 resetKeychainItem];
	//[keychain1 setObject:@"" forKey:@"acct"];

	KeychainItemWrapper *keychain2 = [[KeychainItemWrapper alloc] initWithIdentifier:@"Password" accessGroup:nil];
	[keychain2 resetKeychainItem];

	%orig;

	self.bs = @"63544353132343055545846484730434b000000000000010000010000000106";
	self.cc = @"216";

	return ;
}

- (id)serialNumber
{
	return @"C39LWZ6QFRC5";
}

- (id)serialNumberDescription
{
	return @"C39LWZ6QFRC5";
}

%end

%hook Des

+ (id)encryptUseDES:(id)arg1 key:(id)arg2
{
	NSLog(@"Des encryptUseDES arg1 is %@ callback symbol is %@",arg1,[NSThread callStackSymbols]);
	return %orig;
}
%end

%hook OpenUDID

+ (NSString*)value
{
    return @"7573d80c92670d96936e1034224c6f8348a5df69";
}

%end


%hook UIDevice


- (NSUUID*)identifierForVendor
{
    return [[NSUUID alloc] initWithUUIDString:@"B621E1F8-C36C-495A-93FC-0C247A3E6E6F"];
}

- (id)_deviceInfoForKey:(NSString*)key
{	
	return %orig;
}


%end
