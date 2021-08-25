#include <stdio.h>
#import <Foundation/Foundation.h>


#define kIOReturnSuccess         KERN_SUCCESS
typedef mach_port_t io_object_t;
typedef io_object_t io_iterator_t;
typedef io_object_t io_registry_entry_t;
typedef UInt32 IOOptionBits;
io_object_t IOIteratorNext(io_iterator_t iterator);
const mach_port_t kIOMasterPortDefault;
CFMutableDictionaryRef IOServiceMatching(const char *name);
kern_return_t IOServiceGetMatchingServices(mach_port_t masterPort, CFDictionaryRef matching, io_iterator_t *existing);
kern_return_t IORegistryEntryCreateCFProperties(io_registry_entry_t entry, CFMutableDictionaryRef *properties, CFAllocatorRef allocator, IOOptionBits options);
CFTypeRef IOPSCopyPowerSourcesByType(int type);
CFTypeRef IOPSCopyPowerSourcesInfo(void);



int main(int argc, char *argv[], char *envp[]) {
	@autoreleasepool {
		CFMutableDictionaryRef matching = IOServiceMatching("IOPMPowerSource");
		if(!matching) {
			NSLog(@"Matching failed");
			return 0;
		}
		io_iterator_t iter;
		kern_return_t battery = IOServiceGetMatchingServices(kIOMasterPortDefault, matching, &iter);
		if(battery == KERN_SUCCESS) {
			CFMutableDictionaryRef batteryProperties = 0;
			io_object_t batteryEntry = 0;
			batteryEntry = IOIteratorNext(iter);
			if(IORegistryEntryCreateCFProperties(batteryEntry, &batteryProperties, kCFAllocatorDefault, kNilOptions) == KERN_SUCCESS) {
				 NSDictionary *properties = CFBridgingRelease(batteryProperties);
				 NSLog(@"properties:%@", properties);
				//  NSLog(@"BatteryData:%@", properties[@"BatteryData"]);
				//  NSLog(@"ChargerData:%@", properties[@"ChargerData"]);
			} else {
				NSLog(@"Create Properties failed!");
			}
		} else {
			NSLog(@"Get Services failed!");
		}

		return 0;
	}
}
