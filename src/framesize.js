"use strict";

var logger = require("./logger");
var app = require('../app');


/*
* Frame Size Details(filter ) 
*/
app.post('/framesize/get', function (req, res) {
    var _frameId = '';
    if (req.body.FrameId != null) {
        _frameId = req.body.FrameId;
    }
    // console.log(_storeId);
    req.getConnection(function (err, connection) {
        let sql = 'CALL GetMasterFrameSize(?)';
        connection.query(sql, _frameId, (error, results, fields) => {
            if (error) {
                logger.error(error, { 'req': req.body, 'function': 'FrameSize,Get' });
                res.send({
                    "ResponseCode": 400,
                    "ErrorMessage": "Unknown error ocurred.",
                    "Data": {}
                });
            } else {
                if (results.length > 0) {
                    logger.info(results[0], { 'req': req.body, 'function': 'FrameSize,Get' });
                    res.send({
                        "ResponseCode": 200,
                        "ErrorMessage": "",
                        "Data": { FrameSize: results[0] }
                    });
                }
                else {
                    logger.error("FrameSize details does not exits", { 'req': req.body, 'function': 'FrameSize,Get' });
                    res.send({
                        "ResponseCode": 204,
                        "ErrorMessage": "FrameSize details does not exits.",
                        "Data": {}
                    });
                }
            }
        });
    });
});


/*
* Add Frame Size (Name , UserID) 
*/
app.post('/framesize/add', function (req, res) {

    if (req.body.FrameSize == null) {
        logger.error('Please send the value in {"FrameSize":""} format.', { 'req': req.body, 'function': 'FrameSize,Add' });
        res.send({
            ResponseCode: 400,
            ErrorMessage: 'Please send the value in {"FrameSize":""} format.',
            Data: {}
        });
        return;
    }
    var _frameSize = req.body.FrameSize;
    var _createdBy = req.body.CreatedBy;

    req.getConnection(function (err, connection) {
        let sql = 'CALL AddMasterFrameSize(?,?)';
        connection.query(sql, [_frameSize, _createdBy]
            , (error, results, fields) => {
                if (error) {
                    logger.error(error, { 'req': req.body, 'function': 'FrameSize,Add' });
                    res.send({
                        "ResponseCode": 400,
                        "ErrorMessage": "Error while add new framesize.",
                        "Data": {}
                    });
                } else {
                    if (results.length > 0) {
                        if ((results[0][0].Message.indexOf('Error') <= -1)) {
                            logger.info(results[0], { 'req': req.body, 'function': 'FrameSize,Add' });
                            res.send({
                                "ResponseCode": 200,
                                "ErrorMessage": "",
                                "Data": results[0][0].Message
                            });
                        }
                        else {
                            logger.error(results[0][0].Message, { 'req': req.body, 'function': 'FrameSize,Add' });
                            res.send({
                                "ResponseCode": 204,
                                "ErrorMessage": results[0][0].Message,
                                "Data": {}
                            });
                        }
                    }
                    else {
                        logger.error('Error while add new FrameSize.', { 'req': req.body, 'function': 'FrameSize,Add' });
                        res.send({
                            "ResponseCode": 204,
                            "ErrorMessage": "Error while add new framesize.",
                            "Data": {}
                        });
                    }
                }
            });
    });
});
