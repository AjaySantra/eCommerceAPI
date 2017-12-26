"use strict";

var logger = require("./logger");
var app = require('../app');

/*
* Frame Style Details(filter ) 
*/
app.post('/framestyle/get' ,function (req, res) {
    var _frameId = '';
    if (req.body.FrameId != null) {
        _frameId = req.body.FrameId;
    }
    // console.log(_storeId);
    req.getConnection(function (err, connection) {
        let sql = 'CALL GetMasterFrameStyle(?)';
        connection.query(sql, _frameId, (error, results, fields) => {
            if (error) {
                logger.error(error, { 'req': req.body, 'function': 'FrameStyle,Get' });
                res.send({
                    "ResponseCode": 400,
                    "ErrorMessage": "Unknown error ocurred.",
                    "Data": {}
                });
            } else {
                if (results.length > 0) {
                    logger.info(results[0], { 'req': req.body, 'function': 'FrameStyle,Get' });
                    res.send({
                        "ResponseCode": 200,
                        "ErrorMessage": "",
                        "Data": { FrameStyle: results[0] }
                    });
                }
                else {
                    logger.error("FrameStyle details does not exits", { 'req': req.body, 'function': 'FrameStyle,Get' });
                    res.send({
                        "ResponseCode": 204,
                        "ErrorMessage": "FrameStyle details does not exits.",
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
app.post('/framestyle/add' ,function (req, res) {

    if (req.body.FrameStyle == null) {
        logger.error('Please send the value in {"FrameStyle":""} format.', { 'req': req.body, 'function': 'FrameStyle,Add' });
        res.send({
            ResponseCode: 400,
            ErrorMessage: 'Please send the value in {"FrameStyle":""} format.',
            Data: {}
        });
        return;
    }
    var _frameStyle = req.body.FrameStyle;
    var _createdBy = req.body.CreatedBy;

    req.getConnection(function (err, connection) {
        let sql = 'CALL AddMasterFrameStyle(?,?)';
        connection.query(sql, [_frameStyle, _createdBy]
            , (error, results, fields) => {
                if (error) {
                    logger.error(error, { 'req': req.body, 'function': 'FrameStyle,Add' });
                    res.send({
                        "ResponseCode": 400,
                        "ErrorMessage": "Error while add new framestyle.",
                        "Data": {}
                    });
                } else {
                    if (results.length > 0) {
                        if ((results[0][0].Message.indexOf('Error') <= -1)) {
                            logger.info(results[0], { 'req': req.body, 'function': 'FrameStyle,Add' });
                            res.send({
                                "ResponseCode": 200,
                                "ErrorMessage": "",
                                "Data": results[0][0].Message
                            });
                        }
                        else {
                            logger.error(results[0][0].Message, { 'req': req.body, 'function': 'FrameStyle,Add' });
                            res.send({
                                "ResponseCode": 204,
                                "ErrorMessage": results[0][0].Message,
                                "Data": {}
                            });
                        }
                    }
                    else {
                        logger.error('Error while add new FrameStyle.', { 'req': req.body, 'function': 'FrameStyle,Add' });
                        res.send({
                            "ResponseCode": 204,
                            "ErrorMessage": "Error while add new framestyle.",
                            "Data": {}
                        });
                    }
                }
            });
    });
});
