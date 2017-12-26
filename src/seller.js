"use strict";

var logger = require("./logger");
var passwordHash = require('password-hash');
var app = require('../app');

/*
* Seller details (filter ) 
*/
app.post('/seller/get' ,function (req, res) {
    var _sellerId = '';
    if (req.body.SellerId != null) {
        _sellerId = req.body.SellerId;
    }
    console.log(_sellerId);
    req.getConnection(function (err, connection) {
        let sql = 'CALL GetSellerDetails(?)';
        connection.query(sql, _sellerId, (error, results, fields) => {
            if (error) {
                logger.error(error, { 'req': req.body, 'function': 'Seller,GetSeller' });
                res.send({
                    "ResponseCode": 400,
                    "ErrorMessage": "Unknown error ocurred.",
                    "Data": {}
                });
            } else {
                if (results.length > 0) {
                    logger.info(results[0], { 'req': req.body, 'function': 'Seller,GetSeller' });
                    res.send({
                        "ResponseCode": 200,
                        "ErrorMessage": "",
                        "Data": { Seller : results[0] }
                    });
                }
                else {
                    logger.error("Seller Id does not exits", { 'req': req.body, 'function': 'Seller,GetSeller' });
                    res.send({
                        "ResponseCode": 204,
                        "ErrorMessage": "Seller Id does not exits",
                        "Data": {}
                    });
                }
            }
        });
    });
});

/*
* Add Seller (Name , UserID, Password, LoginType , Line 1 , Phone 1) 
*/
app.post('/seller/add' , function (req, res) {
    if (req.body.CompanyName == null || req.body.UserId == null || req.body.FirstName == null || req.body.MobileNo == null) {
        logger.error('Please send the value in {"UserId":"","CompanyName":"",FirstName":"","MobileNo":""} format.', { 'req': req.body, 'function': 'Seller,Add' });
        res.send({
            ResponseCode: 400,
            ErrorMessage: 'Please send the value in {"UserId":"","CompanyName":"","FirstName":"","MobileNo":""} format.',
            Data: {}
        });
        return;
    }
    var _userId = req.body.UserId;
    var _firstName = req.body.FirstName;
    var _lastName = req.body.LastName;
    var _compnayName = req.body.CompanyName;
    var _gender = req.body.Gender;
    var _landlineNo = req.body.LandlineNo;
    var _mobileNo = req.body.MobileNo;
    var _ccNumber = req.body.CCNumber;
    var _createdBy = req.body.CreatedBy;
    var _password = '';
    if (req.body.FirstName)
        _password = passwordHash.generate(req.body.FirstName + '@123');
    var _loginType = 'seller';
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
        let sql = 'CALL AddSellerDetails(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)';
        connection.query(sql, [_userId, _firstName, _lastName, _compnayName, _gender, _landlineNo,
            _mobileNo, _ccNumber, _createdBy, _password, _loginType, _line1, _line2, _line3, _landmark, _state, _city,
            _pincode, _country, _phone1, _phone2]

            , (error, results, fields) => {
                if (error) {
                    logger.error(error, { 'req': req.body, 'function': 'Seller,Add' });
                    res.send({
                        "ResponseCode": 400,
                        "ErrorMessage": "Error while add new Seller.",
                        "Data": {}
                    });
                } else {
                    if (results.length > 0) {
                        if ((results[0][0].Message.indexOf('Error') <= -1)) {
                            logger.info(results[0], { 'req': req.body, 'function': 'Seller,Add' });
                            res.send({
                                "ResponseCode": 200,
                                "ErrorMessage": "",
                                "Data": results[0][0].Message
                            });
                        }
                        else {
                            logger.error(results[0][0].Message, { 'req': req.body, 'function': 'Seller,Add' });
                            res.send({
                                "ResponseCode": 204,
                                "ErrorMessage": results[0][0].Message,
                                "Data": {}
                            });
                        }
                    }
                    else {
                        logger.error('Error while add new seller.', { 'req': req.body, 'function': 'Seller,Add' });
                        res.send({
                            "ResponseCode": 204,
                            "ErrorMessage": "Error while add new seller details.",
                            "Data": {}
                        });
                    }
                }
            });
    });
});

/*
* Update Seller (ID, Name, UserID,, Password, LoginType Line 1, Phone 1) 
*/
app.post('/seller/update' ,function (req, res) {
    if (req.body.ID == null || req.body.CompanyName == null || req.body.UserId == null || req.body.FirstName == null || req.body.MobileNo == null) {
        logger.error('Please send the value in {"ID":"","UserId":"","CompanyName":"","FirstName":"","MobileNo":"",} format.', { 'req': req.body, 'function': 'Seller,Update' });
        res.send({
            ResponseCode: 400,
            ErrorMessage: 'Please send the value in {"ID":"","UserId":"","CompanyName":"","FirstName":"","MobileNo":"",} format.',
            Data: {}
        });
        return;
    }

    var _ID = req.body.ID;
    var _userId = req.body.UserId;
    var _sellerId = req.body.SellerId;
    var _firstName = req.body.FirstName;
    var _lastName = req.body.LastName;
    var _compnayName = req.body.CompanyName;
    var _gender = req.body.Gender;
    var _landlineNo = req.body.LandlineNo;
    var _mobileNo = req.body.MobileNo;
    var _ccNumber = req.body.CCNumber;
    var _modifyBy = req.body.ModifyBy;

    req.getConnection(function (err, connection) {
        let sql = 'CALL UpdateSellerDetails(?,?,?,?,?,?,?,?,?,?,?)';
        connection.query(sql, [_ID, _sellerId, _userId, _firstName, _lastName, _compnayName, _gender, _landlineNo, _mobileNo, _ccNumber, _modifyBy]
            , (error, results, fields) => {
                if (error) {
                    logger.error(error, { 'req': req.body, 'function': 'Seller,Update' });
                    res.send({
                        "ResponseCode": 400,
                        "ErrorMessage": "Error while update seller.",
                        "Data": {}
                    });
                } else {
                    if (results.length > 0) {
                        if ((results[0][0].Message.indexOf('Error') <= -1)) {
                            logger.info(results[0], { 'req': req.body, 'function': 'Seller,Update' });
                            res.send({
                                "ResponseCode": 200,
                                "ErrorMessage": "",
                                "Data": results[0]
                            });
                        }
                        else {
                            logger.error(results[0][0].Message, { 'req': req.body, 'function': 'Seller,Update' });
                            res.send({
                                "ResponseCode": 204,
                                "ErrorMessage": results[0][0].Message,
                                "Data": {}
                            });
                        }
                    }
                    else {
                        logger.error('Error while update seller.', { 'req': req.body, 'function': 'Seller,Update' });
                        res.send({
                            "ResponseCode": 204,
                            "ErrorMessage": "Error while update seller.",
                            "Data": {}
                        });
                    }
                }
            });
    });
});