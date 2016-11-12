const exec = require('child_process').exec;
const platform = require('os').platform();

module.exports = function() {
    return new Promise(function(resolve, reject) {


        function getWindowsInfo() {
            var parser = require('./lib/windowsParser.js');

            exec('wmic path win32_VideoController', (error, stdout, stderr) => {
                if (error) {
                    console.error(`gpu-info - exec error: ${error}`);
                    return reject(error);
                }
                resolve(parser.parse(stdout));
            });
        }

        function getLinuxInfo() {
            return reject(new Error('platform unsupported'));
        }

        function getMacInfo() {
            return reject(new Error('platform unsupported'));
        }

        switch (platform) {
            case 'win32':
                getWindowsInfo();
                break;
            case 'linux':
                getLinuxInfo();
                break;
            case 'darwin':
                getMacInfo();
                break;
            default:
                return reject(new Error('platform unsupported'));
        }

    });
}
