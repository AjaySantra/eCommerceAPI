"use strict";
var logger = require("./logger");
var passwordHash = require('password-hash');
var app = require('../app');

/*
* Store details (filter ) 
*/
app.post('/customer/get', function (req, res) {
    var _userId = '';
    if (req.body.UserId != null) {
        _userId = req.body.UserId;
    }
    // console.log(_storeId);
    req.getConnection(function (err, connection) {
        let sql = 'CALL GetCustomerDetails_All(?)';
        connection.query(sql, _userId, (error, results, fields) => {
            if (error) {
                logger.error(error, { 'req': req.body, 'function': 'Customer,Get' });
                res.send({
                    "ResponseCode": 400,
                    "ErrorMessage": "Unknown error ocurred.",
                    "Data": {}
                });
            } else {
                if (results.length > 0) {
                    logger.info(results[0], { 'req': req.body, 'function': 'Customer,Get' });
                    res.send({
                        "ResponseCode": 200,
                        "ErrorMessage": "",
                        "Data": { Customer : results[0] }
                    });
                }
                else {
                    logger.error("Store Id does not exits", { 'req': req.body, 'function': 'Customer,Get' });
                    res.send({
                        "ResponseCode": 204,
                        "ErrorMessage": "customer detail does not exits.",
                        "Data": {}
                    });
                }
            }
        });
    });
});