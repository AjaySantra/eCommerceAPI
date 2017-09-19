"use strict";
var logger = require("./logger");
var passwordHash = require('password-hash');

/*
* Store details (filter ) 
*/
exports.GetStore = function (req, res) {
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
                        "Data": results[0]
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
}


/*
* Add Store (Name , UserId , SellerID , Mobile NO) 
*/
exports.Add = function (req, res) {

    if (req.body.StoreName == null || req.body.UserId == null || req.body.Password == null || req.body.LoginType == null || req.body.SellerId == null || req.body.MobileNo == null) {
        logger.error('Please send the value in {"StoreName":"","UserId":"","Password":"","LoginType":"","SellerId":"","MobileNo":""} format.', { 'req': req.body, 'function': 'Store,Add' });
        res.send({
            ResponseCode: 400,
            ErrorMessage: 'Please send the value in {"StoreName":"","UserId":"","Password":"","LoginType":"","SellerId":"","MobileNo":""} format.',
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
    if (req.body.Password)
        _password = passwordHash.generate(req.body.Password);
    var _loginType = req.body.LoginType;

    req.getConnection(function (err, connection) {
        let sql = 'CALL AddStoreDetails(?,?,?,?,?,?,?,?,?,?,?,?,?,?)';
        connection.query(sql, [_userId, _sellerId, _storeName, _firstName, _lastName, _mobileNo,
            _landlineNo, _ccNumber, _specialOfferEmails, _latitude, _longitude, _createdBy, _password, _loginType]
            , (error, results, fields) => {
                if (error) {
                    logger.error(error, { 'req': req.body, 'function': 'Store,Add' });
                    res.send({
                        "ResponseCode": 400,
                        "ErrorMessage": "Error while add new address.",
                        "Data": {}
                    });
                } else {
                    if (results.length > 0) {
                        if ((results[0][0].Message.indexOf('Error') <= -1)) {
                            logger.info(results[0], { 'req': req.body, 'function': 'Store,Add' });
                            res.send({
                                "ResponseCode": 200,
                                "ErrorMessage": "",
                                "Data": results[0][0]
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
};


/*
* Update Store (ID, Name , UserID , SellerId , MobileNo) 
*/
exports.Update = function (req, res) {

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
};