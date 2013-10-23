
express = require('express')
http = require('http')
path = require('path')
connect = require('connect')
multipart = require('../lib/multipart')
app = express()

app.set('port', process.env.PORT || 3000)
app.use(connect.json())
app.use(connect.urlencoded())
app.use(connect.limit('1mb'))
app.use(multipart({uploadDir: './uploads/%Y/%M/%D'}))
app.use(app.router);

app.get('/', (req, res) ->
    res.send('hello world.')    
)

app.post('/upload', (req, res, next) ->
  console.log(req.body);
  console.log(req.files);
  res.send('ok')
)

http.createServer(app).listen(app.get('port'), ->
  console.log('Express server listening on port ' + app.get('port'))
)
