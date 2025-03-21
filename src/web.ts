import { WebPlugin } from '@capacitor/core';

import type { IcloudDrivePlugin } from './definitions';

export class IcloudDriveWeb extends WebPlugin implements IcloudDrivePlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}
