"use strict";
var logger = require("./logger");
var passwordHash = require('password-hash');
var app = require('../app');


/*
* Store details (filter ) 
*/
app.post('/store/get' ,function (req, res) {
    var _storeId = '';
    if (req.body.StoreId != null) {
        _storeId = req.body.StoreId;
    }
    // console.log(_storeId);
    req.getConnection(function (err, connection) {
        let sql = 'CALL GetStoreDetails(?)';
        connection.query(sql, _storeId, (error, results, fields) => {
            if (error) {
                logger.error(error, { 'req': req.body, 'function': 'Store,GetStore' });
                res.send({
                    "ResponseCode": 400,
                    "ErrorMessage": "Unknown error ocurred.",
                    "Data": {}
                });
            } else {
                if (results.length > 0) {
                    logger.info(results[0], { 'req': req.body, 'function': 'Store,GetStore' });
                    res.send({
                        "ResponseCode": 200,
                        "ErrorMessage": "",
                        "Data": { Addresses: results[0] }
                    });
                }
                else {
                    logger.error("Store Id does not exits", { 'req': req.body, 'function': 'Store,GetStore' });
                    res.send({
                        "ResponseCode": 204,
                        "ErrorMessage": "Store Id does not exits.",
                        "Data": {}
                    });
                }
            }
        });
    });
});


/*
* Add Store (Name , UserId , SellerID , Mobile NO) 
*/
app.post('/store/add' ,function (req, res) {

    if (req.body.StoreName == null || req.body.UserId == null || req.body.SellerId == null || req.body.MobileNo == null) {
        logger.error('Please send the value in {"StoreName":"","UserId":"","SellerId":"","MobileNo":""} format.', { 'req': req.body, 'function': 'Store,Add' });
        res.send({
            ResponseCode: 400,
            ErrorMessage: 'Please send the value in {"StoreName":"","UserId":"","SellerId":"","MobileNo":""} format.',
            Data: {}
        });
        return;
    }

    var _userId = req.body.UserId;
    var _sellerId = req.body.SellerId;
    var _storeName = req.body.StoreName;
    var _firstName = req.body.FirstName;
    var _lastName = req.body.LastName;
    var _mobileNo = req.body.MobileNo;
    var _landlineNo = req.body.LandlineNo;
    var _ccNumber = req.body.CCNumber;
    var _specialOfferEmails = req.body.SpecialOfferEmails;
    var _latitude = req.body.Latitude;
    var _longitude = req.body.Longitude;
    var _createdBy = req.body.CreatedBy;
    var _password = '';
    if (req.body.FirstName)
        _password = passwordHash.generate(req.body.FirstName + '@123');

    var _loginType = 'store';
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

    req.getConnection(function (err, connection) {
        let sql = 'CALL AddStoreDetails(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)';
        connection.query(sql, [_userId, _sellerId, _storeName, _firstName, _lastName, _mobileNo,
            _landlineNo, _ccNumber, _specialOfferEmails, _latitude, _longitude, _createdBy, _password, _loginType, _line1, _line2, _line3, _landmark, _state, _city,
            _pincode, _country, _phone1, _phone2]
            , (error, results, fields) => {
                if (error) {
                    logger.error(error, { 'req': req.body, 'function': 'Store,Add' });
                    res.send({
                        "ResponseCode": 400,
                        "ErrorMessage": "Error while add new store.",
                        "Data": {}
                    });
                } else {
                    if (results.length > 0) {
                        if ((results[0][0].Message.indexOf('Error') <= -1)) {
                            logger.info(results[0], { 'req': req.body, 'function': 'Store,Add' });
                            res.send({
                                "ResponseCode": 200,
                                "ErrorMessage": "",
                                "Data": results[0][0].Message
                                
                            });
                        }
                        else {
                            logger.error(results[0][0].Message, { 'req': req.body, 'function': 'Store,Add' });
                            res.send({
                                "ResponseCode": 204,
                                "ErrorMessage": results[0][0].Message,
                                "Data": {}
                            });
                        }
                    }
                    else {
                        logger.error('Error while add new address.', { 'req': req.body, 'function': 'Store,Add' });
                        res.send({
                            "ResponseCode": 204,
                            "ErrorMessage": "Error while add new Store Details.",
                            "Data": {}
                        });
                    }
                }
            });
    });
});


/*
* Update Store (ID, Name , UserID , SellerId , MobileNo) 
*/
app.post('/store/update' , function (req, res) {

    if (req.body.ID == null || req.body.StoreName == null || req.body.UserId == null || req.body.SellerId == null || req.body.MobileNo == null) {
        logger.error('Please send the value in {"ID":"","StoreName":"","UserId":"","SellerId":"","MobileNo":"",} format.', { 'req': req.body, 'function': 'Store,Update' });
        res.send({
            ResponseCode: 400,
            ErrorMessage: 'Please send the value in {"ID:"","StoreName":"","UserId":"","SellerID":"","MobileNo":"",} format.',
            Data: {}
        });
        return;
    }
    var _ID = req.body.ID;
    var _userId = req.body.UserId;
    var _sellerId = req.body.SellerId;
    var _storeName = req.body.StoreName;
    var _firstName = req.body.FirstName;
    var _lastName = req.body.LastName;
    var _mobileNo = req.body.MobileNo;
    var _landlineNo = req.body.LandlineNo;
    var _ccNumber = req.body.CCNumber;
    var _specialOfferEmails = req.body.SpecialOfferEmails;
    var _latitude = req.body.Latitude;
    var _longitude = req.body.Longitude;
    var _modifyBy = req.body.ModifyBy;

    req.getConnection(function (err, connection) {
        let sql = 'CALL UpdateStoreDetails(?,?,?,?,?,?,?,?,?,?,?,?,?)';
        connection.query(sql, [_ID, _userId, _sellerId, _storeName, _firstName, _lastName, _mobileNo,
            _landlineNo, _ccNumber, _specialOfferEmails, _latitude, _longitude, _modifyBy]
            , (error, results, fields) => {
                if (error) {
                    logger.error(error, { 'req': req.body, 'function': 'Store,Update' });
                    res.send({
                        "ResponseCode": 400,
                        "ErrorMessage": "Error while update address.",
                        "Data": {}
                    });
                } else {
                    if (results.length > 0) {
                        if ((results[0][0].Message.indexOf('Error') <= -1)) {
                            logger.info(results[0], { 'req': req.body, 'function': 'Store,Update' });
                            res.send({
                                "ResponseCode": 200,
                                "ErrorMessage": "",
                                "Data": results[0][0]
                            });
                        }
                        else {
                            logger.error(results[0][0].Message, { 'req': req.body, 'function': 'Store,Update' });
                            res.send({
                                "ResponseCode": 204,
                                "ErrorMessage": results[0][0].Message,
                                "Data": {}
                            });
                        }
                    }
                    else {
                        logger.error('Error while add new address.', { 'req': req.body, 'function': 'Store,Update' });
                        res.send({
                            "ResponseCode": 204,
                            "ErrorMessage": "Error while update Store Details.",
                            "Data": {}
                        });
                    }
                }
            });
    });
});