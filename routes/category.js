"use strict";

var logger = require("./logger");

/*
* Get Category and SubCategory Details (Category Id Optional) 
*/
exports.Get = function (req, res) {
    var _catId = '';
    if (req.body.CatId != null) {
        _catId = req.body.CatId;
    }
    else {
        _catId = 0;
    }
    // console.log(_catID);

    req.getConnection(function (err, connection) {
        let sql = 'CALL GetCatSubCatDetails(?)';
        connection.query(sql, _catId, (error, results, fields) => {
            if (error) {
                logger.error(error, { 'req': req.body, 'function': 'Category,Get' });
                res.send({
                    "ResponseCode": 400,
                    "ErrorMessage": "Unknown error ocurred.",
                    "Data": {}
                });
            } else {
                if (results.length > 0) {
                    logger.info(results[0], { 'req': req.body, 'function': 'Category,Get' });
                    //results.Distinct(results[0][0])
                    res.send({
                        "ResponseCode": 200,
                        "ErrorMessage": "",
                        "Data": results[0]
                    });
                }
                else {
                    logger.error("Category details not found.", { 'req': req.body, 'function': 'Category,Get' });
                    res.send({
                        "ResponseCode": 204,
                        "ErrorMessage": "Category details not found.",
                        "Data": {}
                    });
                }
            }
        });
    });
}




/**
 * Banner
 * Category
 * Subcategory
 * Best Selling
 * Hot Deals
 */