'use strict'

var express = require('express');
var routes = require('./routes');
var http = require('http');
var path = require('path');
var bodyParser = require('body-parser');

//load customers route
var customers = require('./routes/customer'); 
var app = express();
var connection  = require('express-myconnection'); 
var mysql = require('mysql');

// configure app to use bodyParser()
// this will let us get the data from a POST
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

// app.get('/', routes.index);//route customer list
app.get('/customer', customers.list);//route add customer, get n post
app.get('/customer/add', customers.add);
app.post('/customer/add', customers.save);//route delete customer
app.get('/customer/delete/:id', customers.delete_customer);//edit customer route , get n post
app.get('/customer/edit/:id', customers.edit); 
app.post('/customer/edit/:id',customers.save_edit);