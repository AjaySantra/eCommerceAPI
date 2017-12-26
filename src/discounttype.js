"use strict";

var logger = require("./logger");
var app = require('../app');


/*
* Discount Shape Details(filter ) 
*/
app.post('/discounttype/get', function (req, res) {
    var _typeId = '';
    if (req.body.TypeId != null) {
        _typeId = req.body.TypeId;
    }
    // console.log(_storeId);
    req.getConnection(function (err, connection) {
        let sql = 'CALL GetMasterDiscountType(?)';
        connection.query(sql, _typeId, (error, results, fields) => {
            if (error) {
                logger.error(error, { 'req': req.body, 'function': 'DiscountType,Get' });
                res.send({
                    "ResponseCode": 400,
                    "ErrorMessage": "Unknown error ocurred.",
                    "Data": {}
                });
            } else {
                if (results.length > 0) {
                    logger.info(results[0], { 'req': req.body, 'function': 'DiscountType,Get' });
                    res.send({
                        "ResponseCode": 200,
                        "ErrorMessage": "",
                        "Data": { DiscountType: results[0] }
                    });
                }
                else {
                    logger.error("DiscountType details does not exits", { 'req': req.body, 'function': 'DiscountType,Get' });
                    res.send({
                        "ResponseCode": 204,
                        "ErrorMessage": "DiscountType details does not exits.",
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
app.post('/discounttype/add', function (req, res) {

    if (req.body.DiscountType == null) {
        logger.error('Please send the value in {"DiscountType":""} format.', { 'req': req.body, 'function': 'DiscountType,Add' });
        res.send({
            ResponseCode: 400,
            ErrorMessage: 'Please send the value in {"DiscountType":""} format.',
            Data: {}
        });
        return;
    }
    var _discountType = req.body.DiscountType;
    var _createdBy = req.body.CreatedBy;

    req.getConnection(function (err, connection) {
        let sql = 'CALL AddMasterDiscountType(?,?)';
        connection.query(sql, [_discountType, _createdBy]
            , (error, results, fields) => {
                if (error) {
                    logger.error(error, { 'req': req.body, 'function': 'DiscountType,Add' });
                    res.send({
                        "ResponseCode": 400,
                        "ErrorMessage": "Error while add new discount type.",
                        "Data": {}
                    });
                } else {
                    if (results.length > 0) {
                        if ((results[0][0].Message.indexOf('Error') <= -1)) {
                            logger.info(results[0], { 'req': req.body, 'function': 'DiscountType,Add' });
                            res.send({
                                "ResponseCode": 200,
                                "ErrorMessage": "",
                                "Data": results[0][0].Message
                            });
                        }
                        else {
                            logger.error(results[0][0].Message, { 'req': req.body, 'function': 'DiscountType,Add' });
                            res.send({
                                "ResponseCode": 204,
                                "ErrorMessage": results[0][0].Message,
                                "Data": {}
                            });
                        }
                    }
                    else {
                        logger.error('Error while add new DiscountType.', { 'req': req.body, 'function': 'DiscountType,Add' });
                        res.send({
                            "ResponseCode": 204,
                            "ErrorMessage": "Error while add new discount type.",
                            "Data": {}
                        });
                    }
                }
            });
    });
});
