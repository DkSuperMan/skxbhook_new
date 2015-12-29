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
@end

%hook AngelFaceViewController

- (BOOL)myTest
{
	return NO;
}


- (void)getMesgUrl:(id)arg1
{
	/*
	UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"getMesgUrl" message:@"getMesgUrl" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alertView show];

	NSLog(@"getMesgUrl arg1 is %@ callback symbol is %@",arg1,[NSThread callStackSymbols]);

	NSString* _testVariableHooked = MSHookIvar<NSString *>(self, "wechat_md5");

	NSLog(@"_testVariableHooked is %@ callback symbol is %@",_testVariableHooked,[NSThread callStackSymbols]);
*/
	return %orig;
}

- (NSString*)bs
{
	UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"AngelFaceViewController" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alertView show];
	NSLog(@"setbs arg1 is %@ callback symbol is %@",@"",[NSThread callStackSymbols]);
	return %orig;
}

- (NSString*)wechat_md5
{

	UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"wechat_md5" message:@"wechat_md5" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alertView show];


	return %orig;
}

- (void)postUrl:(id)arg1
{
	NSLog(@"postUrl arg1 is %@ callback symbol is %@",arg1,[NSThread callStackSymbols]);
	return %orig;
}

- (id)postUrl:(id)arg1 u:(id)arg2 m:(id)arg3
{
	NSLog(@"postUrl arg1 is %@ arg2 is %@ arg3 is %@ callback symbol is %@",arg1,arg2,arg3,[NSThread callStackSymbols]);
	return %orig;
}

- (id)postUrl:(id)arg1 u:(id)arg2
{
	NSLog(@"postUrl arg1 is %@ arg2 is %@ callback symbol is %@",arg1,arg2,[NSThread callStackSymbols]);
	return %orig;
}

- (void)sendPackage
{
	NSLog(@"sendPackage callback symbol is %@",[NSThread callStackSymbols]);
	return %orig;
}

- (void)getResults
{
	NSLog(@"getResults callback symbol is %@",[NSThread callStackSymbols]);
	return %orig;
}

- (void)postValidateUrl:(id)arg1
{
	NSLog(@"postValidateUrl arg1 is %@ callback symbol is %@",arg1,[NSThread callStackSymbols]);
	return %orig;
}


- (void)viewDidLoad
{
	KeychainItemWrapper *keychain = [[KeychainItemWrapper alloc] initWithIdentifier:@"Account Number" accessGroup:nil];
	
	NSLog(@"viewDidLoad keychain Password is %@",[keychain objectForKey:@"acct"]);

	//[keychain setObject:@"" forKey:@"acct"];
/*
UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"AngelFaceViewController viewDidLoad" message:[keychain objectForKey:@"acct"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
    */

	return %orig;
}


/*
- (id)getMd5_16Bit_String:(id)arg1
{
	id returnValue = %orig;
	NSLog(@"getMd5_16Bit_String arg1 is %@ returnValue is %@ callback symbol is %@",arg1,returnValue,[NSThread callStackSymbols]);
	return returnValue;
}

- (id)getMd5_32Bit_String:(id)arg1
{
	id returnValue = %orig;
	NSLog(@"getMd5_32Bit_String arg1 is %@ returnValue is %@ callback symbol is %@",arg1,returnValue,[NSThread callStackSymbols]);
	return returnValue;
}
*/

- (id)dcToy:(id)arg1
{
	id returnValue = %orig;
	NSLog(@"dcToy arg1 is %@ returnValue is %@ callback symbol is %@",arg1,returnValue,[NSThread callStackSymbols]);
	return returnValue;
}

- (id)eyToc:(id)arg1
{
	id returnValue = %orig;
	NSLog(@"eyToc arg1 is %@ returnValue is %@ callback symbol is %@",arg1,returnValue,[NSThread callStackSymbols]);
	return returnValue;
}

- (void)unionidHandler:(id)arg1
{
	NSLog(@"unionidHandler arg1 is %@ callback symbol is %@",arg1,[NSThread callStackSymbols]);
	return %orig;
}

/*
- (void)notificationHandler:(id)arg1
{

	UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"AngelFaceViewController webView" message:@"notificationHandler" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
    NSLog(@"notificationHandler is %@ callback symbol is %@",arg1,[NSThread callStackSymbols]);

    
	return %orig;
	
}

- (void)OpenScheme:(id)arg1
{
	NSLog(@"OpenScheme arg1 is %@",arg1);
	return %orig;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{

    NSString* url = request.mainDocumentURL.absoluteString;
	UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"AngelFaceViewController webView" message:url delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
    NSLog(@"webView url is %@",url);

    return %orig;
}
*/
%end

%hook AppDelegate

- (BOOL)application:(id)arg1 openURL:(id)arg2 sourceApplication:(id)arg3 annotation:(id)arg4
{

	return %orig;
}

- (id)getDeviceToken
{
	id returnValue = %orig;


    return returnValue;
}

- (void)application:(id)arg1 didRegisterForRemoteNotificationsWithDeviceToken:(id)deviceToken
{

	NSLog(@"DeviceToken: {%@}",deviceToken);
    //这里进行的操作，是将Device Token发送到服务端
    
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"DeviceToken:%@",deviceToken] delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
    return %orig;
}

%end

%hook UIApplication

- (BOOL)openURL:(NSURL*)url
{

/*
	UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"UIApplication" message:url.absoluteString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alertView show];
*/

	NSLog(@"UIApplication openURL is %@ call symblo is %@",url.absoluteString,[NSThread callStackSymbols]);
	return %orig;
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

