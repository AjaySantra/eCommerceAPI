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




// /**
//  * Seller
//  */
// var _userId = req.body.UserId;
// var _firstName = req.body.FirstName;
// var _lastName = req.body.LastName;
// var _compnayName = req.body.CompanyName;
// var _gender = req.body.Gender;
// var _landlineNo = req.body.LandlineNo;
// var _mobileNo = req.body.MobileNo;
// var _ccNumber = req.body.CCNumber;
// var _createdBy = req.body.CreatedBy;

// var _pencardNo = req.body.PanCardNo;
// var _accountDetails = req.body.AccountDetails;


// /**
//  * Store
//  */
// var _userId = req.body.UserId;
// var _sellerId = req.body.SellerId;
// var _storeName = req.body.StoreName;
// var _firstName = req.body.FirstName;
// var _lastName = req.body.LastName;
// var _mobileNo = req.body.MobileNo;
// var _landlineNo = req.body.LandlineNo;
// var _ccNumber = req.body.CCNumber;
// var _specialOfferEmails = req.body.SpecialOfferEmails;
// var _latitude = req.body.Latitude;
// var _longitude = req.body.Longitude;
// var _createdBy = req.body.CreatedBy;


/**
 *  var _name = req.body.Name;
    var _userId = req.body.UserId;
    var _userType = req.body.UserType;
    var _line1 = req.body.Line1;
    var _line2 = req.body.Line2;
    var _line3 = req.body.Line3;
    var _landmark = req.body.Landmark;
    var _state = req.body.State;
    var _city = req.body.City;
    var _pincode = req.body.Pincode;
    var _country = req.body.Country;
    var _phone1 = req.body.Phone1;
    var _phone2 = req.body.Phone2;
    var _isDefault = req.body.IsDefault;
 */