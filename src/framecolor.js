"use strict";

var logger = require("./logger");
var app = require('../app');


/*
* Frame Shape Details(filter ) 
*/
app.post('/framecolor/get', function (req, res) {
    var _colorId = '';
    if (req.body.ColorId != null) {
        _colorId = req.body.ColorId;
    }
    // console.log(_storeId);
    req.getConnection(function (err, connection) {
        let sql = 'CALL GetMasterFrameColor(?)';
        connection.query(sql, _colorId, (error, results, fields) => {
            if (error) {
                logger.error(error, { 'req': req.body, 'function': 'FrameColor,Get' });
                res.send({
                    "ResponseCode": 400,
                    "ErrorMessage": "Unknown error ocurred.",
                    "Data": {}
                });
            } else {
                if (results.length > 0) {
                    logger.info(results[0], { 'req': req.body, 'function': 'FrameColor,Get' });
                    res.send({
                        "ResponseCode": 200,
                        "ErrorMessage": "",
                        "Data": { FrameColor: results[0] }
                    });
                }
                else {
                    logger.error("FrameColor details does not exits", { 'req': req.body, 'function': 'FrameColor,Get' });
                    res.send({
                        "ResponseCode": 204,
                        "ErrorMessage": "FrameColor details does not exits.",
                        "Data": {}
                    });
                }
            }
        });
    });
});


/*
* Add Color (Name , UserID) 
*/
app.post('/framecolor/add', function (req, res) {

    if (req.body.FrameColor == null) {
        logger.error('Please send the value in {"FrameColor":""} format.', { 'req': req.body, 'function': 'FrameColor,Add' });
        res.send({
            ResponseCode: 400,
            ErrorMessage: 'Please send the value in {"FrameColor":""} format.',
            Data: {}
        });
        return;
    }
    var _frameColor = req.body.FrameColor;
    var _createdBy = req.body.CreatedBy;

    req.getConnection(function (err, connection) {
        let sql = 'CALL AddMasterFrameColor(?,?)';
        connection.query(sql, [_frameColor, _createdBy]
            , (error, results, fields) => {
                if (error) {
                    logger.error(error, { 'req': req.body, 'function': 'FrameColor,Add' });
                    res.send({
                        "ResponseCode": 400,
                        "ErrorMessage": "Error while add new framecolor.",
                        "Data": {}
                    });
                } else {
                    if (results.length > 0) {
                        if ((results[0][0].Message.indexOf('Error') <= -1)) {
                            logger.info(results[0], { 'req': req.body, 'function': 'FrameColor,Add' });
                            res.send({
                                "ResponseCode": 200,
                                "ErrorMessage": "",
                                "Data": results[0][0].Message
                            });
                        }
                        else {
                            logger.error(results[0][0].Message, { 'req': req.body, 'function': 'FrameColor,Add' });
                            res.send({
                                "ResponseCode": 204,
                                "ErrorMessage": results[0][0].Message,
                                "Data": {}
                            });
                        }
                    }
                    else {
                        logger.error('Error while add new FrameColor.', { 'req': req.body, 'function': 'FrameColor,Add' });
                        res.send({
                            "ResponseCode": 204,
                            "ErrorMessage": "Error while add new framecolor.",
                            "Data": {}
                        });
                    }
                }
            });
    });
});
