### Node-uploader
文件上传成功后移动到指定的目录.
支持`/%Y/%M/%D or /YYYY/MM/DD`时间格式生成目录.

## Setup
```
	uploader = require('uploader')	
	app.use(multipart({uploadDir: './uploads/%Y/%M/%D'}))
```

## PS
不支持与 `express.bodyParser`和 `connect.bodyParser` 一同使用，此模块用于替代`connect.multipart`(2.3.0已不支持).

## example
见 example 目录
```
	coffee app.coffee
	 or 
	node app.js
```