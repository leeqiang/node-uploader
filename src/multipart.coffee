# require connect#2.9.0

connect = require('connect')
moment = require('moment')
mv = require('mv')
path = require('path')


_rename = (dirname, name) ->
	ext = path.extname(name)
	fn = moment().format("YYYYMDHms")
	fn = fn + '_' + Math.floor(Math.random() * 1000 + 1)
	name = path.join(dirname, fn + ext)
	return name

exports = module.exports = multipart = (options) ->
	
	formattingTokens = /(MM?M?M?|DD?D?D?|YYYYY|YYYY|YY)/g
	
	uploadDir = options.uploadDir
	delete options.uploadDir
	
	if uploadDir
		uploadDir = uploadDir
		.replace('%Y', 'YYYY')
		.replace('%M', 'MM')
		.replace('%D', 'DD')
		formatArray = uploadDir.match(formattingTokens)
		if formatArray.length > 0
			formatSuffix = moment().format(formatArray.join('/'))
			prefix = uploadDir[0..uploadDir.indexOf(formatArray.join('/'))-1]
			uploadDir = prefix + formatSuffix
			
	_multipart = connect.multipart(options)
	return multipart = (req, res, next) ->
		_multipart req, res, (err) ->
			for key, file of req.files
				name = _rename(uploadDir, file.originalFilename)
				mv(
					file.path,
					name,
					{ mkdirp: true },
					->
				)
			next()
				