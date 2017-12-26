"use strict";

var logger = require("./logger");
var app = require('../app');


/*
* Suits Lens Type Details(filter ) 
*/
app.post('/suitslenstype/get', function (req, res) {
    var _typeId = '';
    if (req.body.TypeId != null) {
        _typeId = req.body.TypeId;
    }
    // console.log(_storeId);
    req.getConnection(function (err, connection) {
        let sql = 'CALL GetMasterSuitsLensType(?)';
        connection.query(sql, _typeId, (error, results, fields) => {
            if (error) {
                logger.error(error, { 'req': req.body, 'function': 'SuitsLensType,Get' });
                res.send({
                    "ResponseCode": 400,
                    "ErrorMessage": "Unknown error ocurred.",
                    "Data": {}
                });
            } else {
                if (results.length > 0) {
                    logger.info(results[0], { 'req': req.body, 'function': 'SuitsLensType,Get' });
                    res.send({
                        "ResponseCode": 200,
                        "ErrorMessage": "",
                        "Data": { SuitsLensType: results[0] }
                    });
                }
                else {
                    logger.error("SuitsLensType details does not exits", { 'req': req.body, 'function': 'SuitsLensType,Get' });
                    res.send({
                        "ResponseCode": 204,
                        "ErrorMessage": "SuitsLensType details does not exits.",
                        "Data": {}
                    });
                }
            }
        });
    });
});


/*
* Add Suits lens type (Name , UserID) 
*/
app.post('/suitslenstype/add', function (req, res) {

    if (req.body.SuitsLensType == null) {
        logger.error('Please send the value in {"SuitsLensType":""} format.', { 'req': req.body, 'function': 'SuitsLensType,Add' });
        res.send({
            ResponseCode: 400,
            ErrorMessage: 'Please send the value in {"SuitsLensType":""} format.',
            Data: {}
        });
        return;
    }
    var _suitsLensType = req.body.SuitsLensType;
    var _createdBy = req.body.CreatedBy;

    req.getConnection(function (err, connection) {
        let sql = 'CALL AddMasterSuitsLensType(?,?)';
        connection.query(sql, [_suitsLensType, _createdBy]
            , (error, results, fields) => {
                if (error) {
                    logger.error(error, { 'req': req.body, 'function': 'SuitsLensType,Add' });
                    res.send({
                        "ResponseCode": 400,
                        "ErrorMessage": "Error while add new suits lens type.",
                        "Data": {}
                    });
                } else {
                    if (results.length > 0) {
                        if ((results[0][0].Message.indexOf('Error') <= -1)) {
                            logger.info(results[0], { 'req': req.body, 'function': 'SuitsLensType,Add' });
                            res.send({
                                "ResponseCode": 200,
                                "ErrorMessage": "",
                                "Data": results[0][0].Message
                            });
                        }
                        else {
                            logger.error(results[0][0].Message, { 'req': req.body, 'function': 'SuitsLensType,Add' });
                            res.send({
                                "ResponseCode": 204,
                                "ErrorMessage": results[0][0].Message,
                                "Data": {}
                            });
                        }
                    }
                    else {
                        logger.error('Error while add new SuitsLensType.', { 'req': req.body, 'function': 'SuitsLensType,Add' });
                        res.send({
                            "ResponseCode": 204,
                            "ErrorMessage": "Error while add new suits lens type.",
                            "Data": {}
                        });
                    }
                }
            });
    });
});
