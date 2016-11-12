# gpu-info
## Provides nodejs with information about the system's GPUs.
Currently only supports gpu detection on Windows.

#### Usage
Returns an array of GPUs.
```javascript
const gpuInfo = require('gpu-info');
gpuInfo().then(function(data) {
    console.log('GPUS:', data);
});
```
