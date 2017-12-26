"use strict";

var logger = require("./logger");
var app = require('../app');

/*
* Frame Type Details(filter ) 
*/
app.post('/producttype/get' ,function (req, res) {
    var _typeId = '';
    if (req.body.FrameId != null) {
        _typeId = req.body.TypeId;
    }
    // console.log(_storeId);
    req.getConnection(function (err, connection) {
        let sql = 'CALL GetMasterProductType(?)';
        connection.query(sql, _typeId, (error, results, fields) => {
            if (error) {
                logger.error(error, { 'req': req.body, 'function': 'ProductType,Get' });
                res.send({
                    "ResponseCode": 400,
                    "ErrorMessage": "Unknown error ocurred.",
                    "Data": {}
                });
            } else {
                if (results.length > 0) {
                    logger.info(results[0], { 'req': req.body, 'function': 'ProductType,Get' });
                    res.send({
                        "ResponseCode": 200,
                        "ErrorMessage": "",
                        "Data": { ProductType: results[0] }
                    });
                }
                else {
                    logger.error("ProductType details does not exits", { 'req': req.body, 'function': 'ProductType,Get' });
                    res.send({
                        "ResponseCode": 204,
                        "ErrorMessage": "ProductType details does not exits.",
                        "Data": {}
                    });
                }
            }
        });
    });
});


/*
* Add Product Type (Name , UserID) 
*/
app.post('/producttype/add' , function (req, res) {
    if (req.body.ProductType == null) {
        logger.error('Please send the value in {"ProductType":""} format.', { 'req': req.body, 'function': 'ProductType,Add' });
        res.send({
            ResponseCode: 400,
            ErrorMessage: 'Please send the value in {"ProductType":""} format.',
            Data: {}
        });
        return;
    }
    var _productType = req.body.ProductType;
    var _createdBy = req.body.CreatedBy;

    req.getConnection(function (err, connection) {
        let sql = 'CALL AddMasterProductType(?,?)';
        connection.query(sql, [_productType, _createdBy]
            , (error, results, fields) => {
                if (error) {
                    logger.error(error, { 'req': req.body, 'function': 'ProductType,Add' });
                    res.send({
                        "ResponseCode": 400,
                        "ErrorMessage": "Error while add new product type.",
                        "Data": {}
                    });
                } else {
                    if (results.length > 0) {
                        if ((results[0][0].Message.indexOf('Error') <= -1)) {
                            logger.info(results[0], { 'req': req.body, 'function': 'ProductType,Add' });
                            res.send({
                                "ResponseCode": 200,
                                "ErrorMessage": "",
                                "Data": results[0][0].Message
                            });
                        }
                        else {
                            logger.error(results[0][0].Message, { 'req': req.body, 'function': 'ProductType,Add' });
                            res.send({
                                "ResponseCode": 204,
                                "ErrorMessage": results[0][0].Message,
                                "Data": {}
                            });
                        }
                    }
                    else {
                        logger.error('Error while add new ProductType.', { 'req': req.body, 'function': 'ProductType,Add' });
                        res.send({
                            "ResponseCode": 204,
                            "ErrorMessage": "Error while add new product type.",
                            "Data": {}
                        });
                    }
                }
            });
    });
});