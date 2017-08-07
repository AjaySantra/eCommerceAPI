'use strict';

/**
 * Module dependencies.
 */
var express = require('express');
var routes = require('./routes');
var http = require('http');
var path = require('path');
var bodyParser = require('body-parser');

//load customers route
var customers = require('./routes/customer'); 
// var index = require('./routes/index.js'); 

var app = express();
var connection  = require('express-myconnection'); 
var mysql = require('mysql');


// configure app to use bodyParser()
// this will let us get the data from a POST
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

// var router = express.Router();  
// all environments
app.set('port', process.env.PORT || 4300);

app.use(
    connection(mysql,{
        host: '127.0.0.1',
        user: 'root',
        password : 'ajay@123',
        port : 3306, //port mysql
        database:'eCommerceDB'
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
