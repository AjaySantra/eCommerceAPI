'use strict';

var express = require('express');
var http = require('http');
var path = require('path');

var app = module.exports = express();
var connection = require('express-myconnection');
var mysql = require('mysql');

// all environments
app.set('port', process.env.PORT || 5000);
app.use(express.urlencoded());
app.use(express.json());
// app.use(app.router);

app.use(function (req, res, next) {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept,Authorization");
    next();
});

app.use(
    connection(mysql, {
        host: '127.0.0.1',
        user: 'root',
        password: 'ajay@123',
        port: 3306, 
        database: 'EcommerceDB',
        multipleStatements: true
    }, 'request')
);

require('./routes');
 
/*
* Start Server @ port 8000
*/
app.listen(app.get('port'), function () {
    console.log('Express server listening on port ' + app.get('port'));
});