'use strict';

/**
 * Module dependencies.
 */
var express = require('express');
var routes = require('./routes');
var http = require('http');
var path = require('path');

// // // var logger = require('logger');
// // var errorHandler = require('errorhandler');
// // var methodOverride = require('method-override');
// // var json = require('json');
// // var urlencoded = require('urlencode');
// // var favicon =require('favicon');

//load customers route
var customers = require('./routes/customer.js'); 
var index = require('./routes/index.js'); 

var app = express();
var connection  = require('express-myconnection'); 
var mysql = require('mysql');

// all environments
app.set('port', process.env.PORT || 4300);
// app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');
// // // app.use(favicon);
// // // // app.use(logger);
// // // // app.use(json);
// // // app.use(urlencoded);
// // // app.use(methodOverride());
// // // app.use(express.static(path.join(__dirname, 'public')));
// // // // development only
// // // if ('development' == app.get('env')) {
// // //   app.use(errorHandler());
// // // }
/*------------------------------------------
    connection peer, register as middleware
    type koneksi : single,pool and request 
-------------------------------------------*/
app.use(
    connection(mysql,{
        host: '192.168.0.250',
        user: 'root',
        password : 'Password@1',
        port : 3306, //port mysql
        database:'nodejstest'
    },'request')
);//route index, hello world

// app.get('/', routes.index);//route customer list
app.get('/customer', customers.list);//route add customer, get n post
app.get('/customer/add', customers.add);
app.post('/customer/add', customers.save);//route delete customer
app.get('/customer/delete/:id', customers.delete_customer);//edit customer route , get n post
app.get('/customer/edit/:id', customers.edit); 
app.post('/customer/edit/:id',customers.save_edit);
//app.use(app.router);
http.createServer(app).listen(app.get('port'), function(){
  console.log('Express server listening on port ' + app.get('port'));
});
