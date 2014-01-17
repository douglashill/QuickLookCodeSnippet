@import Foundation;
#include <CoreFoundation/CoreFoundation.h>
#include <CoreServices/CoreServices.h>
#include <QuickLook/QuickLook.h>
#import "CodeSnippetConstants.h"

OSStatus GeneratePreviewForURL(void *thisInterface, QLPreviewRequestRef preview, CFURLRef url, CFStringRef contentTypeUTI, CFDictionaryRef options);
void CancelPreviewGeneration(void *thisInterface, QLPreviewRequestRef preview);

/* -----------------------------------------------------------------------------
   Generate a preview for file

   This function's job is to create preview for designated file
   ----------------------------------------------------------------------------- */

OSStatus GeneratePreviewForURL(void *thisInterface, QLPreviewRequestRef preview, CFURLRef url, CFStringRef contentTypeUTI, CFDictionaryRef options)
{
	NSDictionary *snippet = [NSDictionary dictionaryWithContentsOfURL:(__bridge NSURL *)(url)];
	NSError *templateReadError;
	NSString *template = [NSString stringWithContentsOfURL:[[NSBundle bundleWithIdentifier:@"co.douglashill.QuickLookCodeSnippet"] URLForResource:@"template" withExtension:@"html"]
												  encoding:NSUTF8StringEncoding
													 error:&templateReadError];
	if (template == nil) {
		NSLog(@"Error reading template file: %@", templateReadError);
		// Should return an error
	}
	
	NSString *htmlString = [NSString stringWithFormat:template,
							snippet[QLCSTitleKey],
							snippet[QLCSSummaryKey],
							snippet[QLCSCompletionPrefixKey],
							snippet[QLCSContentsKey]];
	NSData *htmlData = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
	
	QLPreviewRequestSetDataRepresentation(preview, (__bridge CFDataRef)(htmlData), kUTTypeHTML, NULL);
	
	return noErr;
}

void CancelPreviewGeneration(void *thisInterface, QLPreviewRequestRef preview)
{
    // Implement only if supported
}
