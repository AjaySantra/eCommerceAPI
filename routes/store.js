"use strict";
var logger = require("./logger");

/*
* Store details (filter ) 
*/
exports.GetStore = function (req, res) {
    var _storeId = '';
    if (req.body.StoreId != null) {
        _storeId = req.body.StoreId;
    }
    console.log(_storeId);
    req.getConnection(function (err, connection) {
        let sql = 'CALL StoreDetails(?)';
        connection.query(sql, _storeId, (error, results, fields) => {
            if (error) {
                logger.error(error, { 'req': req.body, 'function': 'Store,GetStore' });
                res.send({
                    "ResponseCode": 400,
                    "ErrorMessage": "Unknown error ocurred.",
                    "Data": {}
                });
            } else {
                if (results.length > 0) {
                    logger.error(results[0], { 'req': req.body, 'function': 'Store,GetStore' });
                    res.send({
                        "ResponseCode": 200,
                        "ErrorMessage": "",
                        "Data": results[0]
                    });
                }
                else {
                    logger.error("Store Id does not exits", { 'req': req.body, 'function': 'Store,GetStore' });
                    res.send({
                        "ResponseCode": 204,
                        "ErrorMessage": "Store Id does not exits",
                        "Data": []
                    });
                }
            }
        });
    });
}