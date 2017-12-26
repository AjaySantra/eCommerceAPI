"use strict";

var logger = require("./logger");
var passwordHash = require('password-hash');
var app = require('../app');

/*
 * Check User Credentials.
 */
app.post('/login', function (req, res) {
    if (req.body.UserId == null || req.body.Password == null) {
        logger.error('Please send the value in {"UserId":"","Password":""} format.', { 'req': req.body, 'function': 'UserAuth,login' });
        res.send({
            ResponseCode: 400,
            ErrorMessage: 'Please send the value in {"UserId":"","Password":""} format.',
            Data: {}
        });
        return;
    }
    var _userID = req.body.UserId;
    var _password = req.body.Password;
    req.getConnection(function (err, connection) {
        let sql = 'CALL CheckUserAuthentication(?)';
        connection.query(sql, [_userID], (error, results, fields) => {
            if (error) {
                logger.error(error, { 'req': req.body, 'function': 'UserAuth,login' });
                res.send({
                    "ResponseCode": 400,
                    "ErrorMessage": "Unknown error ocurred.",
                    'Data': {}
                });
            } else {
                if (results.length > 0) {
                    if (results[0][0].Message.indexOf('Invalid') <= -1) {
                        if (passwordHash.verify(_password, results[0][0].Password)) {
                            logger.info(results[0], { 'req': req.body, 'function': 'UserAuth,login' });
                            res.send({
                                "ResponseCode": 200,
                                "ErrorMessage": "",
                                "Data": { User: results[0][0], Cart: results[1][0] }
                            });
                        }
                        else {
                            logger.error('Password not match.', { 'req': req.body, 'function': 'UserAuth,login' });
                            res.send({
                                "ResponseCode": 204,
                                "ErrorMessage": "Password not match.",
                                "Data": {}
                            });
                        }
                    }
                    else {
                        logger.error(results[0][0].Message, { 'req': req.body, 'function': 'UserAuth,login' });
                        res.send({
                            "ResponseCode": 204,
                            "ErrorMessage": results[0][0].Message,
                            "Data": {}
                        });
                    }
                }
                else {
                    logger.error('User Id does not exits', { 'req': req.body, 'function': 'UserAuth,login' });
                    res.send({
                        "ResponseCode": 204,
                        "ErrorMessage": "User Id does not exits",
                        "Data": {}
                    });
                }
            }
        });
    });
});


/*
* User Registration (Through email and social network) 
*/
app.post('/register', function (req, res) {
    var _firstname = req.body.FirstName;
    var _lastname = req.body.LastName;
    var _userId = req.body.Email;
    var _password = '';
    if (req.body.Password)
        _password = passwordHash.generate(req.body.Password);
    var _contactNo = req.body.ContactNo;
    var _gender = req.body.Gender;
    var _referralCode = req.body.ReferralCode;
    var _socialToken = req.body.SocialMediaAccessToken;
    var _socialType = req.body.SocialMediaType;
    var _isSocial = req.body.IsSocial;
    var _createdBy = req.body.CreatedBy;
    var _loginType = req.body.LoginType;
    var _accessToken = req.body.AccessToken;

    req.getConnection(function (err, connection) {
        let sql = 'CALL UserRegistration(?,?,?,?,?,?,?,?,?,?,?,?,?)';
        connection.query(sql, [_firstname, _lastname, _userId, _password, _contactNo, _gender, _referralCode, _isSocial, _socialToken, _socialType, _createdBy, _loginType, _accessToken], (error, results, fields) => {
            if (error) {
                logger.error(error, { 'req': req.body, 'function': 'UserAuth,Register' });
                res.send({
                    "ResponseCode": 400,
                    "ErrorMessage": "Error while register new user.",
                    "Data": {}
                });
            } else {
                if (results.length > 0) {
                    if ((results[0][0].Message.indexOf('Unable') <= -1) && (results[0][0].Message.indexOf('Already') <= -1)) {
                        logger.info(results[0], { 'req': req.body, 'function': 'UserAuth,Register' });
                        res.send({
                            "ResponseCode": 200,
                            "ErrorMessage": "",
                            "Data": { User: results[0][0], Cart: results[1][0] }
                        });
                    }
                    else {
                        logger.error(results[0][0].Message, { 'req': req.body, 'function': 'UserAuth,Register' });
                        res.send({
                            "ResponseCode": 204,
                            "ErrorMessage": results[0][0].Message,
                            "Data": {}
                        });
                    }
                }
                else {
                    logger.error('User Id does not exits', { 'req': req.body, 'function': 'UserAuth,Register' });
                    res.send({
                        "ResponseCode": 204,
                        "ErrorMessage": "User Id does not exits",
                        "Data": {}
                    });
                }
            }
        });
    });
});


/*
* User Details Update (Through email and social network) 
*/
app.post('/user/udpate', function (req, res) {
    console.log("req", req.body);

    if (req.body.UserId == null) {
        logger.error('Please send the value in {"UserId":""} format.', { 'req': req.body, 'function': 'UserAuth,Update' });
        res.send({
            ResponseCode: 400,
            ErrorMessage: 'Please send the value in {"UserId":""} format.',
            Data: {}
        });
        return;
    }

    var _userId = req.body.UserId;
    var _contactNo = req.body.ContactNo;
    var _gender = req.body.Gender;
    var _dob = req.body.DOB;

    req.getConnection(function (err, connection) {
        let sql = 'CALL UpdateCustomerDetails(?,?,?,?)';
        connection.query(sql, [_userId, _dob, _contactNo, _gender], (error, results, fields) => {
            if (error) {
                logger.error(error, { 'req': req.body, 'function': 'UserAuth,Update' });
                res.send({
                    "ResponseCode": 400,
                    "ErrorMessage": "Error while updating details..",
                    "Data": {}
                });
            } else {
                if (results.length > 0) {
                    if ((results[0][0].Message.indexOf('Invalid') <= -1)) {
                        logger.info(results[0][0], { 'req': req.body, 'function': 'UserAuth,Update' });
                        res.send({
                            "ResponseCode": 200,
                            "ErrorMessage": "",
                            "Data": { User: results[0][0], Cart: results[1][0] }
                        });
                    }
                    else {
                        logger.error(results[0][0].Message, { 'req': req.body, 'function': 'UserAuth,Update' });
                        res.send({
                            "ResponseCode": 204,
                            "ErrorMessage": results[0][0].Message,
                            "Data": {}
                        });
                    }
                }
                else {
                    logger.error("User Id does not exits", { 'req': req.body, 'function': 'UserAuth,Update' });
                    res.send({
                        "ResponseCode": 204,
                        "ErrorMessage": "User Id does not exits",
                        "Data": {}
                    });
                }
            }
        });
    });
});