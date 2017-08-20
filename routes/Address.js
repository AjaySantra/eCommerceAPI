"use strict";
var fs = require('fs');

var logger = require('tracer').console({
    transport: function (data) {
        // console.log(data.output);
        fs.open('./TraceLog.log', 'a', parseInt('0644', 8), function (e, id) {
            fs.write(id, data.output + "\n", null, 'utf8', function () {
                fs.close(id, function () {
                });
            });
        });
    }
});

/*
* Add Address (Name , UserID , Line 1 , Phone 1) 
*/
exports.Add = function (req, res) {

    if (req.body.Name == null || req.body.UserId == null || req.body.Line1 == null || req.body.Phone1 == null) {
        logger.error('Address', 'AddAddress', results[0], req.body, [4], 'Please send the value in {"Name":"","UserId":"","Line1":"","Phone1":"",} format.');
        
        res.send({
            ResponseCode: 400,
            ErrorMessage: 'Please send the value in {"Name":"","UserId":"","Line1":"","Phone1":"",} format.',
            Data: {}
        });
        return;
    }

    var _name = req.body.Name;
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

    req.getConnection(function (err, connection) {
        let sql = 'CALL AddAddressDetails(?,?,?,?,?,?,?,?,?,?,?,?,?,?)';
        connection.query(sql, [_name, _userId, _userType, _line1, _line2, _line3,
             _landmark, _state, _city, _pincode, _country, _phone1, _phone2, _isDefault]
             , (error, results, fields) => {
            if (error) {
                logger.error('Address', 'GetAddress', results[0], req.body, [4], error);
                res.send({
                    "ResponseCode": 400,
                    "ErrorMessage": "Error while add new address."
                });
            } else {
                if (results.length > 0) {
                    if ((results[0][0].Message.indexOf('Error') <= -1)) {
                        logger.info('Address', 'AddAddress', results[0], req.body);
                        res.send({
                            "ResponseCode": 200,
                            "ErrorMessage": "",
                            "Data": { User: results[0][0], Cart: results[1][0] }
                        });
                    }
                    else {
                        logger.info('Address', 'AddAddress', results[0], req.body);
                        res.send({
                            "ResponseCode": 204,
                            "ErrorMessage": results[0][0].Message,
                            "Data": {}
                        });
                    }
                }
                else {
                    logger.info('Address', 'AddAddress', results[0], req.body);
                    res.send({
                        "ResponseCode": 204,
                        "ErrorMessage": "Error while add new address.",
                        "Data": {}
                    });
                }
            }
        });
    });
};

/*
* Get User Address (UserID) 
*/
exports.Get = function (req, res) {
    if (req.body.UserId == null) {
        logger.error('Address', 'Get Address', results[0], req.body, [4], 'Please send the value in {"UserId":""} format.');
        res.send({
            ResponseCode: 400,
            ErrorMessage: 'Please send the value in {"UserId":""} format.',
            Data: {}
        });
        return;
    }
    var _userId = req.body.UserId;
    req.getConnection(function (err, connection) {
        let sql = 'CALL GetAddressDetails(?)';
        connection.query(sql, [_userId], (error, results, fields) => {
            if (error) {
                logger.error('Address', 'GetAddress', results[0], req.body, [4], error);
                res.send({
                    "ResponseCode": 400,
                    "ErrorMessage": "Error while geting user address."
                });
            } else {
                if (results[0].length > 0) {
                    logger.info('Address', 'GetAddress', results[0], req.body);
                    res.send({
                        "ResponseCode": 200,
                        "ErrorMessage": "",
                        "Data": { Address : results[0]}
                    });
                }
                else {
                    logger.info('Address', 'GetAddress', results[0], req.body);
                    res.send({
                        "ResponseCode": 204,
                        "ErrorMessage": "User Address not found..",
                        "Data": {}
                    });
                }
            }
        });
    });
};
