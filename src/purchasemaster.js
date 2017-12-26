"use strict";

var logger = require("./logger");
var passwordHash = require('password-hash');
var app = require('../app');


/*
* Purchase details (filter ) 
*/
app.post('/purchasemaster/get' ,function (req, res) {
    var _sellerId = '';
    var _orderNo = '';
    if (req.body.SellerId != null) {
        _sellerId = req.body.SellerId;
    }
    if (req.body.OrderNo != null) {
        _orderNo = req.body.OrderNo;
    }
    req.getConnection(function (err, connection) {
        let sql = 'CALL GetPurchaseMaster(?,?)';
        connection.query(sql, [_sellerId, _orderNo], (error, results, fields) => {
            if (error) {
                logger.error(error, { 'req': req.body, 'function': 'PurchaseMaster,GET' });
                res.send({
                    "ResponseCode": 400,
                    "ErrorMessage": "Unknown error ocurred.",
                    "Data": {}
                });
            } else {
                if (results.length > 0) {
                    logger.info(results[0], { 'req': req.body, 'function': 'PurchaseMaster,GET' });
                    res.send({
                        "ResponseCode": 200,
                        "ErrorMessage": "",
                        "Data": { PurchaseMaster : results[0] }
                    });
                }
                else {
                    logger.error("Purchase details does not exits", { 'req': req.body, 'function': 'PurchaseMaster,GET' });
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