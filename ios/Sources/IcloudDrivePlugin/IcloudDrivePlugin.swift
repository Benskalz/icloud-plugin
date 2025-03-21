import Foundation
import Capacitor

@objc(CloudStoragePlugin)
public class CloudStoragePlugin: CAPPlugin {
    
    @objc func saveToiCloudDrive(_ call: CAPPluginCall) {
        guard let fileName = call.getString("fileName") else {
            call.reject("Must provide a filename")
            return
        }
        
        guard let data = call.getString("data") else {
            call.reject("Must provide data")
            return
        }
        
        // Get the URL for the iCloud container directory
        guard let containerURL = FileManager.default.url(forUbiquityContainerIdentifier: "iCloud.com.nanwallet.app") else {
            call.reject("iCloud Drive not available or not properly configured")
            return
        }
        
        // Create Documents directory if it doesn't exist
        let documentsURL = containerURL.appendingPathComponent("Documents")
        
        do {
            try FileManager.default.createDirectory(at: documentsURL, withIntermediateDirectories: true)
        } catch {
            call.reject("Failed to create Documents directory: \(error.localizedDescription)")
            return
        }
        
        // Create file URL
        let fileURL = documentsURL.appendingPathComponent(fileName)
        
        do {
            // Write the data to the file
            try data.write(to: fileURL, atomically: true, encoding: .utf8)
            
            // Tell iCloud to synchronize this file
//            do {
//                try (fileURL as NSURL).setUbiquitous(true, itemAt: fileURL, destinationURL: fileURL)
//            } catch {
//                print("Warning: Could not set file as ubiquitous: \(error.localizedDescription)")
//                // Continue anyway as the file is still in iCloud directory
//            }
            
            call.resolve([
                "uri": fileURL.absoluteString,
                "path": fileURL.path
            ])
        } catch {
            call.reject("Failed to write file: \(error.localizedDescription)")
        }
    }
    
    @objc func readFromiCloudDrive(_ call: CAPPluginCall) {
        guard let fileName = call.getString("fileName") else {
            call.reject("Must provide a filename")
            return
        }
        
        // Get the URL for the iCloud container directory
        guard let containerURL = FileManager.default.url(forUbiquityContainerIdentifier: "iCloud.com.nanwallet.app") else {
            call.reject("iCloud Drive not available or not properly configured")
            return
        }
        
        // Create file URL
        let fileURL = containerURL.appendingPathComponent("Documents").appendingPathComponent(fileName)
        
        do {
            // Read the data from the file
            let data = try String(contentsOf: fileURL, encoding: .utf8)
            call.resolve([
                "data": data,
                "uri": fileURL.absoluteString,
                "path": fileURL.path
            ])
        } catch {
            call.reject("Failed to read file: \(error.localizedDescription)")
        }
    }
    @objc func listFilesFromiCloudDrive(_ call: CAPPluginCall) {
            // Get the URL for the iCloud container directory
            guard let containerURL = FileManager.default.url(forUbiquityContainerIdentifier: "iCloud.com.nanwallet.app") else {
                call.reject("iCloud Drive not available or not properly configured")
                return
            }

            let documentsURL = containerURL.appendingPathComponent("Documents")

            do {
                // Check if the directory exists
                var isDirectory: ObjCBool = false
                guard FileManager.default.fileExists(atPath: documentsURL.path, isDirectory: &isDirectory) else {
                    call.resolve(["files": []])
                    return
                }

                // Get the contents of the directory
                let fileURLs = try FileManager.default.contentsOfDirectory(at: documentsURL,
                                                                         includingPropertiesForKeys: [.fileResourceTypeKey,
                                                                                                    .creationDateKey,
                                                                                                    .contentModificationDateKey,
                                                                                                    .fileSizeKey],
                                                                         options: [.skipsHiddenFiles])

                // Convert file information to dictionary array
                let filesInfo = try fileURLs.map { url -> [String: Any] in
                    let attributes = try FileManager.default.attributesOfItem(atPath: url.path)

                    return [
                        "name": url.lastPathComponent,
                        "uri": url.absoluteString,
                        "path": url.path,
                        "size": attributes[.size] as? Int64 ?? 0,
                        "modifiedDate": (attributes[.modificationDate] as? Date)?.timeIntervalSince1970 ?? 0,
                        "createdDate": (attributes[.creationDate] as? Date)?.timeIntervalSince1970 ?? 0
                    ]
                }

                call.resolve(["files": filesInfo])

            } catch {
                call.reject("Failed to list files: \(error.localizedDescription)")
            }
        }

        @objc func deleteFromiCloudDrive(_ call: CAPPluginCall) {
            guard let fileName = call.getString("fileName") else {
                call.reject("Must provide a filename")
                return
            }

            // Get the URL for the iCloud container directory
            guard let containerURL = FileManager.default.url(forUbiquityContainerIdentifier: "iCloud.com.nanwallet.app") else {
                call.reject("iCloud Drive not available or not properly configured")
                return
            }

            let fileURL = containerURL.appendingPathComponent("Documents").appendingPathComponent(fileName)

            do {
                try FileManager.default.removeItem(at: fileURL)
                call.resolve()
            } catch {
                call.reject("Failed to delete file: \(error.localizedDescription)")
            }
        }
}
