"use strict";

var logger = require("./logger");
var app = require('../app');



/*
* Frame Shape Details(filter ) 
*/
app.post('/frameshape/get', function (req, res) {
    var _frameId = '';
    if (req.body.FrameId != null) {
        _frameId = req.body.FrameId;
    }
    // console.log(_storeId);
    req.getConnection(function (err, connection) {
        let sql = 'CALL GetMasterFrameShape(?)';
        connection.query(sql, _frameId, (error, results, fields) => {
            if (error) {
                logger.error(error, { 'req': req.body, 'function': 'FrameShape,Get' });
                res.send({
                    "ResponseCode": 400,
                    "ErrorMessage": "Unknown error ocurred.",
                    "Data": {}
                });
            } else {
                if (results.length > 0) {
                    logger.info(results[0], { 'req': req.body, 'function': 'FrameShape,Get' });
                    res.send({
                        "ResponseCode": 200,
                        "ErrorMessage": "",
                        "Data": { FrameShape: results[0] }
                    });
                }
                else {
                    logger.error("FrameShape details does not exits", { 'req': req.body, 'function': 'FrameShape,Get' });
                    res.send({
                        "ResponseCode": 204,
                        "ErrorMessage": "FrameShape details does not exits.",
                        "Data": {}
                    });
                }
            }
        });
    });
});


/*
* Add Brand (Name , UserID) 
*/
app.post('/frameshape/add', function (req, res) {

    if (req.body.FrameShape == null) {
        logger.error('Please send the value in {"FrameShape":""} format.', { 'req': req.body, 'function': 'FrameShape,Add' });
        res.send({
            ResponseCode: 400,
            ErrorMessage: 'Please send the value in {"FrameShape":""} format.',
            Data: {}
        });
        return;
    }
    var _frameShape = req.body.FrameShape;
    var _createdBy = req.body.CreatedBy;

    req.getConnection(function (err, connection) {
        let sql = 'CALL AddMasterFrameShape(?,?)';
        connection.query(sql, [_frameShape, _createdBy]
            , (error, results, fields) => {
                if (error) {
                    logger.error(error, { 'req': req.body, 'function': 'FrameShape,Add' });
                    res.send({
                        "ResponseCode": 400,
                        "ErrorMessage": "Error while add new frameshape.",
                        "Data": {}
                    });
                } else {
                    if (results.length > 0) {
                        if ((results[0][0].Message.indexOf('Error') <= -1)) {
                            logger.info(results[0], { 'req': req.body, 'function': 'FrameShape,Add' });
                            res.send({
                                "ResponseCode": 200,
                                "ErrorMessage": "",
                                "Data": results[0][0].Message
                            });
                        }
                        else {
                            logger.error(results[0][0].Message, { 'req': req.body, 'function': 'FrameShape,Add' });
                            res.send({
                                "ResponseCode": 204,
                                "ErrorMessage": results[0][0].Message,
                                "Data": {}
                            });
                        }
                    }
                    else {
                        logger.error('Error while add new FrameShape.', { 'req': req.body, 'function': 'FrameShape,Add' });
                        res.send({
                            "ResponseCode": 204,
                            "ErrorMessage": "Error while add new frameshape.",
                            "Data": {}
                        });
                    }
                }
            });
    });
});
