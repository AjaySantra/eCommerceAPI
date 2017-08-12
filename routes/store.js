'use strict';

/*
* Store details (filter ) 
*/
exports.GetStore = function (req, res) {
    // if (req.body.StoreId == null) {
    //     res.send({
    //         ResponseCode: 400,
    //         ErrorMessage: 'Please send the value in {"StoreId":""} format.',
    //         Data: []
    //     });
    //     return;
    // }

    var _storeId = '';
    if (req.body.StoreId != null) {
        _storeId = req.body.StoreId;
    }
    console.log(_storeId);
    req.getConnection(function (err, connection) {
        let sql = 'CALL StoreDetails(?)';
        connection.query(sql, _storeId, (error, results, fields) => {
            if (error) {
                res.send({
                    "ResponseCode": 400,
                    "ErrorMessage": "Unknown error ocurred."
                });
            } else {
                if (results.length > 0) {
                    res.send({
                        "ResponseCode": 200,
                        "ErrorMessage": "",
                        "Data": results[0]
                    });
                }
                else {
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