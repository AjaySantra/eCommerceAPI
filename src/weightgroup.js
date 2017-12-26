"use strict";

var logger = require("./logger");
var app = require('../app');


/*
* Weight Group Details(filter ) 
*/
app.post('/weightgroup/get' , function (req, res) {
    var _weightgroupId = '';
    if (req.body.WeightGroupId != null) {
        _weightgroupId = req.body.WeightGroupId;
    }
    // console.log(_storeId);
    req.getConnection(function (err, connection) {
        let sql = 'CALL GetMasterWeightGroup(?)';
        connection.query(sql, _weightgroupId, (error, results, fields) => {
            if (error) {
                logger.error(error, { 'req': req.body, 'function': 'WeightGroup,Get' });
                res.send({
                    "ResponseCode": 400,
                    "ErrorMessage": "Unknown error ocurred.",
                    "Data": {}
                });
            } else {
                if (results.length > 0) {
                    logger.info(results[0], { 'req': req.body, 'function': 'WeightGroup,Get' });
                    res.send({
                        "ResponseCode": 200,
                        "ErrorMessage": "",
                        "Data": { WeightGroup: results[0] }
                    });
                }
                else {
                    logger.error("WeightGroup details does not exits", { 'req': req.body, 'function': 'WeightGroup,Get' });
                    res.send({
                        "ResponseCode": 204,
                        "ErrorMessage": "WeightGroup details does not exits.",
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
app.post('/weightgroup/add' , function (req, res) {

    if (req.body.WeightGroup == null) {
        logger.error('Please send the value in {"WeightGroup":""} format.', { 'req': req.body, 'WeightGroup': 'WeightGroup,Add' });
        res.send({
            ResponseCode: 400,
            ErrorMessage: 'Please send the value in {"WeightGroup":""} format.',
            Data: {}
        });
        return;
    }
    var _weightGroup = req.body.WeightGroup;
    var _createdBy = req.body.CreatedBy;

    req.getConnection(function (err, connection) {
        let sql = 'CALL AddMasterWeightGroup(?,?)';
        connection.query(sql, [_weightGroup, _createdBy]
            , (error, results, fields) => {
                if (error) {
                    logger.error(error, { 'req': req.body, 'function': 'WeightGroup,Add' });
                    res.send({
                        "ResponseCode": 400,
                        "ErrorMessage": "Error while add new weightgroup.",
                        "Data": {}
                    });
                } else {
                    if (results.length > 0) {
                        if ((results[0][0].Message.indexOf('Error') <= -1)) {
                            logger.info(results[0], { 'req': req.body, 'function': 'WeightGroup,Add' });
                            res.send({
                                "ResponseCode": 200,
                                "ErrorMessage": "",
                                "Data": results[0][0].Message
                            });
                        }
                        else {
                            logger.error(results[0][0].Message, { 'req': req.body, 'function': 'WeightGroup,Add' });
                            res.send({
                                "ResponseCode": 204,
                                "ErrorMessage": results[0][0].Message,
                                "Data": {}
                            });
                        }
                    }
                    else {
                        logger.error('Error while add new WeightGroup.', { 'req': req.body, 'function': 'WeightGroup,Add' });
                        res.send({
                            "ResponseCode": 204,
                            "ErrorMessage": "Error while add new weightgroup.",
                            "Data": {}
                        });
                    }
                }
            });
    });
});
