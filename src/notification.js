"use strict";

var logger = require("./logger");
var passwordHash = require('password-hash');
var app = require('../app');

/*
* Notification details (filter ) 
*/

app.post('/notification/get', function (req, res) {
    var _userId = '';
    if (req.body.UserId != null) {
        _userId = req.body.UserId;
    }
    console.log(_userId);
    req.getConnection(function (err, connection) {
        let sql = 'CALL GetNotificationDetails(?)';
        connection.query(sql, _userId, (error, results, fields) => {
            if (error) {
                logger.error(error, { 'req': req.body, 'function': 'Notification ,Get ' });
                res.send({
                    "ResponseCode": 400,
                    "ErrorMessage": "Unknown error ocurred.",
                    "Data": {}
                });
            } else {
                if (results.length > 0) {
                    logger.info(results[0], { 'req': req.body, 'function': 'Notification ,Get ' });
                    res.send({
                        "ResponseCode": 200,
                        "ErrorMessage": "",
                        "Data": { Seller: results[0] }
                    });
                }
                else {
                    logger.error("Notification details does not exits", { 'req': req.body, 'function': 'Notification ,Get ' });
                    res.send({
                        "ResponseCode": 204,
                        "ErrorMessage": "Notification details does not exits",
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
app.post('/notification/add', function (req, res) {
    if (req.body.Type == null || req.body.UserId == null || req.body.Notification == null) {
        logger.error('Please send the value in {"Type":"","UserId":"",Notification":""} format.', { 'req': req.body, 'function': 'Notification, Add' });
        res.send({
            ResponseCode: 400,
            ErrorMessage: 'Please send the value in {"Type":"","UserId":"",Notification":""} format.',
            Data: {}
        });
        return;
    }

    var _type = req.body.Type;
    var _notification = req.body.Notification;
    var _subject = req.body.Subject;
    var _details = req.body.Details;
    var _comments = req.body.Commments;
    var _createdBy = req.body.CreatedBy;
    var _userId = req.body.UserId;

    req.getConnection(function (err, connection) {
        let sql = 'CALL AddNotificationDetails(?,?,?,?,?,?,?)';
        connection.query(sql, [_type, _notification, _subject, _details, _comments, _createdBy, _userId]

            , (error, results, fields) => {
                if (error) {
                    logger.error(error, { 'req': req.body, 'function': 'Notification, Add' });
                    res.send({
                        "ResponseCode": 400,
                        "ErrorMessage": "Error while add new notification.",
                        "Data": {}
                    });
                } else {
                    if (results.length > 0) {
                        if ((results[0][0].Message.indexOf('Error') <= -1)) {
                            logger.info(results[0], { 'req': req.body, 'function': 'Notification, Add' });
                            res.send({
                                "ResponseCode": 200,
                                "ErrorMessage": "",
                                "Data": results[0][0].Message
                            });
                        }
                        else {
                            logger.error(results[0][0].Message, { 'req': req.body, 'function': 'Notification, Add' });
                            res.send({
                                "ResponseCode": 204,
                                "ErrorMessage": results[0][0].Message,
                                "Data": {}
                            });
                        }
                    }
                    else {
                        logger.error('Error while add new notification.', { 'req': req.body, 'function': 'Notification, Add' });
                        res.send({
                            "ResponseCode": 204,
                            "ErrorMessage": "Error while add new notification details.",
                            "Data": {}
                        });
                    }
                }
            });
    });
});