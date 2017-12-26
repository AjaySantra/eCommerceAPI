"use strict";

var logger = require("./logger");
var app = require('../app');


/*
* Brand Details(filter ) 
*/
app.post('/brand/get', function (req, res) {
    var _brandId = '';
    if (req.body.BrandId != null) {
        _brandId = req.body.BrandId;
    }
    // console.log(_storeId);
    req.getConnection(function (err, connection) {
        let sql = 'CALL GetMasterBrand(?)';
        connection.query(sql, _brandId, (error, results, fields) => {
            if (error) {
                logger.error(error, { 'req': req.body, 'function': 'Brand,Get' });
                res.send({
                    "ResponseCode": 400,
                    "ErrorMessage": "Unknown error ocurred.",
                    "Data": {}
                });
            } else {
                if (results.length > 0) {
                    logger.info(results[0], { 'req': req.body, 'function': 'Brand,Get' });
                    res.send({
                        "ResponseCode": 200,
                        "ErrorMessage": "",
                        "Data": { Brand: results[0] }
                    });
                }
                else {
                    logger.error("Brand details does not exits", { 'req': req.body, 'function': 'Brand,Get' });
                    res.send({
                        "ResponseCode": 204,
                        "ErrorMessage": "Brand details does not exits.",
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
app.post('/brand/add',function (req, res) {

    if (req.body.BrandName == null) {
        logger.error('Please send the value in {"BrandName":""} format.', { 'req': req.body, 'function': 'Brand,Add' });
        res.send({
            ResponseCode: 400,
            ErrorMessage: 'Please send the value in {"BrandName":""} format.',
            Data: {}
        });
        return;
    }
    var _name = req.body.BrandName;
    var _createdBy = req.body.CreatedBy;

    req.getConnection(function (err, connection) {
        let sql = 'CALL AddMasterBrand(?,?)';
        connection.query(sql, [_name, _createdBy]
            , (error, results, fields) => {
                if (error) {
                    logger.error(error, { 'req': req.body, 'function': 'Brand,Add' });
                    res.send({
                        "ResponseCode": 400,
                        "ErrorMessage": "Error while add new brand.",
                        "Data": {}
                    });
                } else {
                    if (results.length > 0) {
                        if ((results[0][0].Message.indexOf('Error') <= -1)) {
                            logger.info(results[0], { 'req': req.body, 'function': 'Brand,Add' });
                            res.send({
                                "ResponseCode": 200,
                                "ErrorMessage": "",
                                "Data": results[0][0].Message
                            });
                        }
                        else {
                            logger.error(results[0][0].Message, { 'req': req.body, 'function': 'Brand,Add' });
                            res.send({
                                "ResponseCode": 204,
                                "ErrorMessage": results[0][0].Message,
                                "Data": {}
                            });
                        }
                    }
                    else {
                        logger.error('Error while add new Brand.', { 'req': req.body, 'function': 'Brand,Add' });
                        res.send({
                            "ResponseCode": 204,
                            "ErrorMessage": "Error while add new brand.",
                            "Data": {}
                        });
                    }
                }
            });
    });
});
