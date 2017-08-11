'use strict';

var passwordHash = require('password-hash');

/*
 * Check User Credentials.
 */
exports.login = function (req, res) {
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
        let sql = 'CALL UserAuthentication(?)';
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
                                "Data": results[0]
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
}


/*
* User Registration (Through email and social network) 
*/
exports.register = function (req, res) {
    // console.log("req",req.body);
    var today = new Date();
    var users = {
        "first_name": req.body.first_name,
        "last_name": req.body.last_name,
        "email": req.body.email,
        "password": req.body.password,
        "created": today,
        "modified": today
    }
    connection.query('INSERT INTO users SET ?', users, function (error, results, fields) {
        if (error) {
            console.log("error ocurred", error);
            res.send({
                "code": 400,
                "failed": "error ocurred"
            })
        } else {
            console.log('The solution is: ', results);
            res.send({
                "code": 200,
                "success": "user registered sucessfully"
            });
        }
    });
}


