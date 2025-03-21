import { registerPlugin } from '@capacitor/core';

import type { IcloudDrivePlugin } from './definitions';

const IcloudDrive = registerPlugin<IcloudDrivePlugin>('IcloudDrive', {
  web: () => import('./web').then((m) => new m.IcloudDriveWeb()),
});

export * from './definitions';
export { IcloudDrive };
