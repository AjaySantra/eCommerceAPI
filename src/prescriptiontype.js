// import { request } from "http";

"use strict";

var logger = require("./logger");
var app = require('../app');


/*
* Prescription Type Details(filter ) 
*/
app.post('/prescriptiontype/get' , function (req, res) {
    var _typeId = '';
    if (req.body.TypeId != null) {
        _typeId = req.body.TypeId;
    }
    // console.log(_storeId);
    req.getConnection(function (err, connection) {
        let sql = 'CALL GetMasterPrescriptionType(?)';
        connection.query(sql, _typeId, (error, results, fields) => {
            if (error) {
                logger.error(error, { 'req': req.body, 'function': 'PrescriptionType,Get' });
                res.send({
                    "ResponseCode": 400,
                    "ErrorMessage": "Unknown error ocurred.",
                    "Data": {}
                });
            } else {
                if (results.length > 0) {
                    logger.info(results[0], { 'req': req.body, 'function': 'PrescriptionType,Get' });
                    res.send({
                        "ResponseCode": 200,
                        "ErrorMessage": "",
                        "Data": { PrescriptionType: results[0] }
                    });
                }
                else {
                    logger.error("PrescriptionType details does not exits", { 'req': req.body, 'function': 'PrescriptionType,Get' });
                    res.send({
                        "ResponseCode": 204,
                        "ErrorMessage": "PrescriptionType details does not exits.",
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
app.post('/prescriptiontype/add' ,  function (req, res) {

    if (req.body.PrescriptionType == null) {
        logger.error('Please send the value in {"PrescriptionType":""} format.', { 'req': req.body, 'function': 'PrescriptionType,Add' });
        res.send({
            ResponseCode: 400,
            ErrorMessage: 'Please send the value in {"PrescriptionType":""} format.',
            Data: {}
        });
        return;
    }
    var _prescriptionType = req.body.PrescriptionType;
    var _createdBy = req.body.CreatedBy;

    req.getConnection(function (err, connection) {
        let sql = 'CALL AddMasterPrescriptionType(?,?)';
        connection.query(sql, [_prescriptionType, _createdBy]
            , (error, results, fields) => {
                if (error) {
                    logger.error(error, { 'req': req.body, 'function': 'PrescriptionType,Add' });
                    res.send({
                        "ResponseCode": 400,
                        "ErrorMessage": "Error while add new prescription type.",
                        "Data": {}
                    });
                } else {
                    if (results.length > 0) {
                        if ((results[0][0].Message.indexOf('Error') <= -1)) {
                            logger.info(results[0], { 'req': req.body, 'function': 'PrescriptionType,Add' });
                            res.send({
                                "ResponseCode": 200,
                                "ErrorMessage": "",
                                "Data": results[0][0].Message
                            });
                        }
                        else {
                            logger.error(results[0][0].Message, { 'req': req.body, 'function': 'PrescriptionType,Add' });
                            res.send({
                                "ResponseCode": 204,
                                "ErrorMessage": results[0][0].Message,
                                "Data": {}
                            });
                        }
                    }
                    else {
                        logger.error('Error while add new PrescriptionType.', { 'req': req.body, 'function': 'PrescriptionType,Add' });
                        res.send({
                            "ResponseCode": 204,
                            "ErrorMessage": "Error while add new prescription type.",
                            "Data": {}
                        });
                    }
                }
            });
    });
});
