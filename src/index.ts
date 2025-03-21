import { registerPlugin } from '@capacitor/core';

export interface CloudStoragePlugin {
  saveToiCloudDrive(options: { fileName: string; data: string }): Promise<{ uri: string; path: string }>;
  readFromiCloudDrive(options: { fileName: string }): Promise<{ data: string; uri: string; path: string }>;
  listFilesFromiCloudDrive(): Promise<{ 
    files: Array<{
      name: string;
      uri: string;
      path: string;
      size: number;
      modifiedDate: number;
      createdDate: number;
    }> 
  }>;
  deleteFromiCloudDrive(options: { fileName: string }): Promise<void>;
}

const CloudStorage = registerPlugin<CloudStoragePlugin>('CloudStorage');

export default CloudStorage;