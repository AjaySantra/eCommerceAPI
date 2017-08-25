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
var app = express();
var connection = require('express-myconnection');
var mysql = require('mysql');

// configure app to use bodyParser()
// this will let us get the data from a POST
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

// all environments
app.set('port', process.env.PORT || 8000);

app.use(function (req, res, next) {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept,Authorization");
    next();
});
var router = express.Router();
router.get('/', function (req, res) {
    res.json({ message: 'welcome to our upload module apis' });
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

/*
* Handle Customer Lavel data
*/
var customers = require('./routes/customer');
app.get('/customer', customers.list);
app.get('/customer/add', customers.add);

/*
* User Registration (Through email and social network) 
*/
var UserAuth = require('./routes/userAuth');
app.post('/register', UserAuth.register);
app.post('/login', UserAuth.login)
app.post('/user/udpate', UserAuth.Update)

/*
* Store Lavel details
*/
var store = require('./routes/store.js')
app.post('/store/get' , store.GetStore);
app.post('/store/add' , store.Add);
app.post('/store/update' , store.Update);

/*
* Address Lavel details
*/
var address = require('./routes/address.js')
app.post('/address/add' , address.Add);
app.post('/address/get' , address.Get);
app.post('/address/update' , address.Update);

/*
 *Seller Lavel details 
 */
var seller = require('./routes/seller.js')
app.post('/seller/add' , seller.Add);
app.post('/seller/get' , seller.Get);
app.post('/seller/update' , seller.Update);


/*
* Start Server @ port 8000
*/
app.listen(app.get('port'), function () {
    console.log('Express server listening on port ' + app.get('port'));
});
