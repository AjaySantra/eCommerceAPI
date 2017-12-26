"use strict";
var logger = require("./logger");
var passwordHash = require('password-hash');
var app = require('../app');


/*
* Product details (filter ) 
*/
app.post('/cart/get' , function (req, res) {
    var _productId = '';
    console.log(req.body);
    _productId = req.body.ProductIds;
    // console.log(_storeId);
    req.getConnection(function (err, connection) {
        let sql = 'CALL GetProductDetails(?)';
        connection.query(sql, _productId, (error, results, fields) => {
            if (error) {
                logger.error(error, { 'req': req.body, 'function': 'Product,Get' });
                res.send({
                    "ResponseCode": 400,
                    "ErrorMessage": "Unknown error ocurred.",
                    "Data": {}
                });
            } else {
                if (results.length > 0) {
                    logger.info(results[0], { 'req': req.body, 'function': 'Product, Get' });
                    res.send({
                        "ResponseCode": 200,
                        "ErrorMessage": "",
                        "Data": { Products : results[0] }
                    });
                }
                else {
                    logger.error("Product details not found.", { 'req': req.body, 'function': 'Product,Get' });
                    res.send({
                        "ResponseCode": 204,
                        "ErrorMessage": "Product details not found.",
                        "Data": {}
                    });
                }
            }
        });
    });
});