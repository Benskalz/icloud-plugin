export interface IcloudDrivePlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}
