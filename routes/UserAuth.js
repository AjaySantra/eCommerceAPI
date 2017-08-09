'use strict';

/*
 * GET customers listing.
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


exports.login = function (req, res) {
    var _userID = req.body.UserId;
    var _password = req.body.Password;
    req.getConnection(function (err, connection) {
        let sql = 'CALL UserAuthentication(?,?)';
        connection.query(sql, [_userID, _password], (error, results, fields) => {
            if (error) {
                res.send({
                    "ResponseCode": 400,
                    "failed": "error ocurred"
                })
            } else {
                // console.log('The solution is: ', results);
                if (results.length > 0) {
                    res.send({
                        "ResponseCode": 200,
                        "success": "login sucessfull",
                        Data: results[0]
                    });
                }
                else {
                    res.send({
                        "ResponseCode": 204,
                        "success": "User Id does not exits"
                    });
                }
            }
        });
    });
}

// https://medium.com/technoetics/handling-user-login-and-registration-using-nodejs-and-mysql-81b146e37419