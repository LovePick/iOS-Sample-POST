var express   =     require("express");
var bodyParser  =    require('body-parser');
var multer  =   require('multer');
var path = require('path');
var formidable = require('formidable');
var fs = require('fs');



var app       =     express();

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({
  extended: true
}));
app.use(express.static(path.join(__dirname, 'public')));


var http = require('http');

app.get('/',function(req,res){
  
  res.setHeader('Content-Type', 'application/json');
  res.send(JSON.stringify({ message: "http: GET" }, null, 3));


});

app.post('/login',function(request,response){

  console.log(request.body);      // your JSON
   response.send(request.body);    // echo the result back


});

// Post files

var storage =   multer.diskStorage({
  destination: function (req, file, callback) {
    callback(null, './uploads');
  },
  filename: function (req, file, callback) {
    callback(null, file.fieldname + '-' + Date.now());
  }
});
var upload = multer({ storage : storage}).single('userPhoto');

app.get('/',function(req,res){
      res.sendFile(__dirname + "/index.html");
});

app.post('/api/photo',function(req,res){
    upload(req,res,function(err) {
        if(err) {
            return res.end("Error uploading file.");
        }
        res.end("File is uploaded");
    });
});

app.listen(3000,function(){
  console.log("Started on PORT 3000");
})