"use strict";

var logger = require("./logger");
var passwordHash = require('password-hash');
var app = require('../app');

/*
* Purchase details (filter ) 
*/
app.post('/purchasedetails/get', function (req, res) {
    var _orderNo = '';
    if (req.body.OrderNo != null) {
        _orderNo = req.body.OrderNo;
    }
    req.getConnection(function (err, connection) {
        let sql = 'CALL GetPurchaseDetails(?)';
        connection.query(sql, [_orderNo], (error, results, fields) => {
            if (error) {
                logger.error(error, { 'req': req.body, 'function': 'PurchaseDetails,GET' });
                res.send({
                    "ResponseCode": 400,
                    "ErrorMessage": "Unknown error ocurred.",
                    "Data": {}
                });
            } else {
                if (results.length > 0) {
                    logger.info(results[0], { 'req': req.body, 'function': 'PurchaseDetails,GET' });
                    res.send({
                        "ResponseCode": 200,
                        "ErrorMessage": "",
                        "Data": { PurchaseDetails: results[0] }
                    });
                }
                else {
                    logger.error("Purchase details does not exits", { 'req': req.body, 'function': 'PurchaseDetails,GET' });
                    res.send({
                        "ResponseCode": 204,
                        "ErrorMessage": "Purchase details does not exits",
                        "Data": {}
                    });
                }
            }
        });
    });
});