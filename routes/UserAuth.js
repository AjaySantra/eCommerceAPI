"use strict";
var fs = require('fs');

var logger = require('tracer').console({
    transport: function (data) {
       console.log(data.output);
        fs.open('./TraceLog.log', 'a', parseInt('0644', 8), function (e, id) {
            fs.write(id, data.output + "\n", null, 'utf8', function () {
                fs.close(id, function () {
                });
            });
        });
    }
});

var passwordHash = require('password-hash');

/*
 * Check User Credentials.
 */
exports.login = function (req, res) {
    //console.log(req);

    if (req.body.UserId == null || req.body.Password == null) {

        logger.error('Login', 'UserAuth', results[0], req.body, [4], 'Please send the value in {"UserId":"","Password":""} format.');

        res.send({
            ResponseCode: 400,
            ErrorMessage: 'Please send the value in {"UserId":"","Password":""} format.',
            Data: {}
        });
        return;
    }
    var _userID = req.body.UserId;
    var _password = req.body.Password;

    // console.log(passwordHash.generate(_password));

    req.getConnection(function (err, connection) {

        let sql = 'CALL CheckUserAuthentication(?)';
        connection.query(sql, [_userID], (error, results, fields) => {
            if (error) {
                logger.error('Login', 'UserAuth', results[0], req.body, [4], error);
                res.send({
                    "ResponseCode": 400,
                    "ErrorMessage": "Unknown error ocurred."
                });
            } else {
                if (results.length > 0) {
                    if (results[0][0].Message.indexOf('Invalid') <= -1) {
                        if (passwordHash.verify(_password, results[0][0].Password)) {
                            logger.info('UserAuth', 'Login', results[0], req.body);
                            res.send({
                                "ResponseCode": 200,
                                "ErrorMessage": "",
                                "Data": { User: results[0][0], Cart: results[1][0] }
                            });
                        }
                        else {
                            logger.info('UserAuth', 'Login', results[0], req.body);
                            res.send({
                                "ResponseCode": 204,
                                "ErrorMessage": "Password not match.",
                                "Data": {}
                            });
                        }
                    }
                    else {
                        logger.info('UserAuth', 'Login', results[0], req.body);
                        res.send({
                            "ResponseCode": 204,
                            "ErrorMessage": results[0][0].Message,
                            "Data": {}
                        });
                    }
                }
                else {
                    logger.info('UserAuth', 'Login', results[0], req.body);
                    res.send({
                        "ResponseCode": 204,
                        "ErrorMessage": "User Id does not exits",
                        "Data": {}
                    });
                }
            }
        });
    });
};


/*
* User Registration (Through email and social network) 
*/
exports.register = function (req, res) {
    // console.log("req",req.body);

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
                logger.error('UserAuth', 'Register', results[0], req.body, [4], error);
                res.send({
                    "ResponseCode": 400,
                    "ErrorMessage": "Error while register new user."
                });
            } else {
                if (results.length > 0) {
                    if ((results[0][0].Message.indexOf('Unable') <= -1) && (results[0][0].Message.indexOf('Already') <= -1)) {
                        logger.info('UserAuth', 'Register', results[0], req.body);
                        res.send({
                            "ResponseCode": 200,
                            "ErrorMessage": "",
                            "Data": { User: results[0][0], Cart: results[1][0] }
                        });
                    }
                    else {
                        logger.info('UserAuth', 'Register', results[0], req.body);
                        res.send({
                            "ResponseCode": 204,
                            "ErrorMessage": results[0][0].Message,
                            "Data": {}
                        });
                    }
                }
                else {
                    logger.info('UserAuth', 'Register', results[0], req.body);
                    res.send({
                        "ResponseCode": 204,
                        "ErrorMessage": "User Id does not exits",
                        "Data": {}
                    });
                }
            }
        });
    });
};


/*
* User Details Update (Through email and social network) 
*/
exports.Update = function (req, res) {
    console.log("req",req.body);

    if (req.body.UserId == null) {
        logger.error('UserAuth', 'UserUpdate', results[0], req.body, [4], 'Please send the value in {"UserId":""} format.');

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
                logger.error('UserAuth', 'UserUpdate', results[0], req.body, [4], error);

                res.send({
                    "ResponseCode": 400,
                    "ErrorMessage": "Error while updating details.."
                });
            } else {
                if (results.length > 0) {
                    if ((results[0][0].Message.indexOf('Invalid') <= -1)) {
                        logger.info('UserAuth', 'User Update', results[0], req.body);
                        res.send({
                            "ResponseCode": 200,
                            "ErrorMessage": "",
                            "Data": { User: results[0][0], Cart: results[1][0] }
                        });
                    }
                    else {
                        logger.info('UserAuth', 'User Update', results[0], req.body);
                        res.send({
                            "ResponseCode": 204,
                            "ErrorMessage": results[0][0].Message,
                            "Data": {}
                        });
                    }
                }
                else {
                    logger.info('UserAuth', 'User Update', results[0], req.body);
                    res.send({
                        "ResponseCode": 204,
                        "ErrorMessage": "User Id does not exits",
                        "Data": {}
                    });
                }
            }
        });
    });
};
