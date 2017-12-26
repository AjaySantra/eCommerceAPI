"use strict";

var logger = require("./logger");
var app = require('../app');

/*
* Frame Type Details(filter ) 
*/
app.post('/frametype/get', function (req, res) {
    var _typeId = '';
    if (req.body.FrameId != null) {
        _typeId = req.body.TypeId;
    }
    // console.log(_storeId);
    req.getConnection(function (err, connection) {
        let sql = 'CALL GetMasterFrameType(?)';
        connection.query(sql, _typeId, (error, results, fields) => {
            if (error) {
                logger.error(error, { 'req': req.body, 'function': 'FrameType,Get' });
                res.send({
                    "ResponseCode": 400,
                    "ErrorMessage": "Unknown error ocurred.",
                    "Data": {}
                });
            } else {
                if (results.length > 0) {
                    logger.info(results[0], { 'req': req.body, 'function': 'FrameType,Get' });
                    res.send({
                        "ResponseCode": 200,
                        "ErrorMessage": "",
                        "Data": { FrameType: results[0] }
                    });
                }
                else {
                    logger.error("FrameType details does not exits", { 'req': req.body, 'function': 'FrameType,Get' });
                    res.send({
                        "ResponseCode": 204,
                        "ErrorMessage": "FrameType details does not exits.",
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
app.post('/frametype/add', function (req, res) {

    if (req.body.FrameType == null) {
        logger.error('Please send the value in {"FrameType":""} format.', { 'req': req.body, 'function': 'FrameType,Add' });
        res.send({
            ResponseCode: 400,
            ErrorMessage: 'Please send the value in {"FrameType":""} format.',
            Data: {}
        });
        return;
    }
    var _frameType = req.body.FrameType;
    var _createdBy = req.body.CreatedBy;

    req.getConnection(function (err, connection) {
        let sql = 'CALL AddMasterFrameType(?,?)';
        connection.query(sql, [_frameType, _createdBy]
            , (error, results, fields) => {
                if (error) {
                    logger.error(error, { 'req': req.body, 'function': 'FrameType,Add' });
                    res.send({
                        "ResponseCode": 400,
                        "ErrorMessage": "Error while add new frametype.",
                        "Data": {}
                    });
                } else {
                    if (results.length > 0) {
                        if ((results[0][0].Message.indexOf('Error') <= -1)) {
                            logger.info(results[0], { 'req': req.body, 'function': 'FrameType,Add' });
                            res.send({
                                "ResponseCode": 200,
                                "ErrorMessage": "",
                                "Data": results[0][0].Message
                            });
                        }
                        else {
                            logger.error(results[0][0].Message, { 'req': req.body, 'function': 'FrameType,Add' });
                            res.send({
                                "ResponseCode": 204,
                                "ErrorMessage": results[0][0].Message,
                                "Data": {}
                            });
                        }
                    }
                    else {
                        logger.error('Error while add new FrameType.', { 'req': req.body, 'function': 'FrameType,Add' });
                        res.send({
                            "ResponseCode": 204,
                            "ErrorMessage": "Error while add new frametype.",
                            "Data": {}
                        });
                    }
                }
            });
    });
});