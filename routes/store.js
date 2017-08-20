"use strict";
var fs = require('fs');

var logger = require('tracer').console({
    transport: function (data) {
        // console.log(data.output);
        fs.open('./trace.log', 'a', parseInt('0644', 8), function (e, id) {
            fs.write(id, data.output + "\n", null, 'utf8', function () {
                fs.close(id, function () {
                });
            });
        });
    }
});


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

                logger.error('Get Store', 'Store', results[0], req.body, [4], error);

                res.send({
                    "ResponseCode": 400,
                    "ErrorMessage": "Unknown error ocurred."
                });
            } else {
                if (results.length > 0) {

                    logger.info('Get Store', 'Store', results[0], req.body);

                    res.send({
                        "ResponseCode": 200,
                        "ErrorMessage": "",
                        "Data": results[0]
                    });
                }
                else {
                    logger.info('Get Store', 'Store', results[0], req.body);
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