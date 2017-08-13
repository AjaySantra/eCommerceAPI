'use strict';

var passwordHash = require('password-hash');

/*
 * Check User Credentials.
 */
exports.login = function (req, res) {
    //console.log(req);

    if (req.body.UserId == null || req.body.Password == null) {
        res.send({
            ResponseCode: 400,
            ErrorMessage: 'Please send the value in {"UserId":"","Password":""} format.',
            Data: []
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
                res.send({
                    "ResponseCode": 400,
                    "ErrorMessage": "Unknown error ocurred."
                });
            } else {
                if (results.length > 0) {
                    if (results[0][0].Message.indexOf('Invalid') <= -1) {
                        if (passwordHash.verify(_password, results[0][0].Password)) {
                            res.send({
                                "ResponseCode": 200,
                                "ErrorMessage": "",
                                "Data": { User: results[0][0], Cart: results[1][0] }
                            });
                        }
                        else {
                            res.send({
                                "ResponseCode": 204,
                                "ErrorMessage": "Password not match.",
                                "Data": []
                            });
                        }
                    }
                    else {
                        res.send({
                            "ResponseCode": 204,
                            "ErrorMessage": results[0][0].Message,
                            "Data": []
                        });
                    }
                }
                else {
                    res.send({
                        "ResponseCode": 204,
                        "ErrorMessage": "User Id does not exits",
                        "Data": []
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
    var _password = passwordHash.generate(req.body.Password);
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
                res.send({
                    "ResponseCode": 400,
                    "ErrorMessage": error//"Unknown error ocurred."
                });
            } else {
                if (results.length > 0) {
                    if ((results[0][0].Message.indexOf('Unable') <= -1) && (results[0][0].Message.indexOf('Already') <= -1)) {
                        res.send({
                            "ResponseCode": 200,
                            "ErrorMessage": "",
                            "Data": { User: results[0][0], Cart: results[1][0] }
                        });
                    }
                    else {
                        res.send({
                            "ResponseCode": 204,
                            "ErrorMessage": results[0][0].Message,
                            "Data": []
                        });
                    }
                }
                else {
                    res.send({
                        "ResponseCode": 204,
                        "ErrorMessage": "User Id does not exits",
                        "Data": []
                    });
                }
            }
        });
    });
};
