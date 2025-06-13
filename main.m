#import <Foundation/Foundation.h>
#import <FBVirtualization.h>

@interface VMLogger : NSObject <VZVirtualMachineDelegate>
@end

@implementation VMLogger

- (void)virtualMachineDidStart:(VZVirtualMachine *)vm {
    NSLog(@"[vmutil] VM started.");
}
- (void)virtualMachineDidStop:(VZVirtualMachine *)vm {
    NSLog(@"[vmutil] VM stopped.");
}
- (void)virtualMachine:(VZVirtualMachine *)vm didFailWithError:(NSError *)error {
    NSLog(@"[vmutil] VM failed: %@", [error localizedDescription]);
}

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSLog(@"[vmutil] Starting test...");

        VZVirtualMachineConfiguration *config = [VZVirtualMachineConfiguration new];
        config.CPUCount = 2;
        config.memorySize = 1024 * 1024 * 4;

        NSString *diskPath = @"/vms/testvm.img";
        VZDiskImageStorageDeviceAttachment *attachment = [[VZDiskImageStorageDeviceAttachment alloc] initWithDiskImagePath:diskPath readOnly:NO];
        VZVirtioBlockDeviceConfiguration *block = [[VZVirtioBlockDeviceConfiguration alloc] initWithAttachment:attachment];
        config.storageDevices = @[ block ];

        VZEFIBootLoader *boot = [[VZEFIBootLoader alloc] initWithFirmwarePath:@"/usr/local/share/uefi-firmware/BHYVE_UEFI.fd"];
        config.bootLoader = (VZBootLoader *)boot;

        VZVirtualMachine *vm = [[VZVirtualMachine alloc] initWithConfiguration:config];
        VMLogger *logger = [VMLogger new];
        vm.delegate = logger;

        [vm startWithCompletionHandler:^(NSError * _Nullable error) {
            if (error) {
                NSLog(@"[vmutil] Error: %@", error);
            } else {
                NSLog(@"[vmutil] Start call completed without error.");
            }
        }];
    }
    return 0;
}
