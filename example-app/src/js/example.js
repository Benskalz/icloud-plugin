import { IcloudDrive } from 'capacitor-icloud-drive';

window.testEcho = () => {
    const inputValue = document.getElementById("echoInput").value;
    IcloudDrive.echo({ value: inputValue })
}
