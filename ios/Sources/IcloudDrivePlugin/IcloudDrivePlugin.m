#import <Foundation/Foundation.h>
#import <Capacitor/Capacitor.h>

// Define the plugin using the CAP_PLUGIN macro.
CAP_PLUGIN(CloudStoragePlugin, "CloudStorage",
           CAP_PLUGIN_METHOD(saveToiCloudDrive, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(readFromiCloudDrive, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(listFilesFromiCloudDrive, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(deleteFromiCloudDrive, CAPPluginReturnPromise);
)