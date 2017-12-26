"use strict";
var logger = require("./logger");
var passwordHash = require('password-hash');
var app = require('../app');

/*
* Product details (filter ) 
*/
app.post('/search/get' , function (req, res) {
    var _searchText = '';
    if (req.body.SearchText != null) {
        _searchText = req.body.SearchText;
    }
    // console.log(_storeId);
    req.getConnection(function (err, connection) {
        let sql = 'CALL SearchProductDetails(?)';
        connection.query(sql, _searchText, (error, results, fields) => {
            if (error) {
                logger.error(error, { 'req': req.body, 'function': 'Search,Get' });
                res.send({
                    "ResponseCode": 400,
                    "ErrorMessage": "Unknown error ocurred.",
                    "Data": {}
                });
            } else {
                if (results.length > 0) {
                    logger.info(results[0], { 'req': req.body, 'function': 'Search, Get' });
                    res.send({
                        "ResponseCode": 200,
                        "ErrorMessage": "",
                        "Data": { Products: results[0] }
                    });
                }
                else {
                    logger.error("Serach Product details not found.", { 'req': req.body, 'function': 'Search,Get' });
                    res.send({
                        "ResponseCode": 204,
                        "ErrorMessage": "Serach Product details not found.",
                        "Data": {}
                    });
                }
            }
        });
    });
});


/*
* Filter Product details (filter ) 
*/
app.post('/filter/get' , function (req, res) {
    var _brand = '';
    var _productType = '';
    var _frameSize = '';
    var _frameColor = '';
    var _weightGroup = '';
    var _material = '';
    var _prescriptionType = '';
    var _frameShape = '';
    var _frameType = '';
    var _discountType = '';
    var _frameStyle = '';
    var _suitsLensType = '';

    req.body.filterItems.map(a => {

        if (a.key == 'Brand') {
            _brand = a.value;
        };
        if (a.key == 'ProductType') {
            _productType = a.value;
        };
        if (a.key === 'FrameSize') {
            _frameSize = a.value;
        };
        if (a.key === 'FrameColor') {
            _frameColor = a.value;
        };
        if (a.key === 'WeightGroup') {
            _weightGroup = a.value;
        };
        if (a.key === 'Material') {
            _material = a.value;
        };
        if (a.key === 'PrescriptionType') {
            _prescriptionType = a.value;
        };
        if (a.key === 'FrameShape') {
            _frameShape = a.value;
        };
        if (a.key === 'FrameType') {
            _frameType = a.value;
        };
        if (a.key === 'DiscountType') {
            _discountType = a.value;
        };
        if (a.key === 'FrameStyle') {
            _frameStyle = a.value;
        };
        if (a.key === 'FrameStyle') {
            _suitsLensType = a.value;
        };
    });

    // console.log(_storeId);
    req.getConnection(function (err, connection) {
        let sql = 'CALL FilterProductDetails(?,?,?,?,?,?,?,?,?,?,?,?)';
        connection.query(sql, [_brand, _productType, _frameSize, _frameColor, _weightGroup, _material,
            _prescriptionType, _frameShape, _frameType, _discountType, _suitsLensType, _frameStyle]
            , (error, results, fields) => {
                if (error) {
                    logger.error(error, { 'req': req.body, 'function': 'Filter,Get' });
                    res.send({
                        "ResponseCode": 400,
                        "ErrorMessage": "Unknown error ocurred.",
                        "Data": {}
                    });
                } else {
                    if (results.length > 0) {
                        logger.info(results[0], { 'req': req.body, 'function': 'Filter, Get' });
                        res.send({
                            "ResponseCode": 200,
                            "ErrorMessage": "",
                            "Data": { Products: results[0] }
                        });
                    }
                    else {
                        logger.error("Filter Product details not found.", { 'req': req.body, 'function': 'Filter,Get' });
                        res.send({
                            "ResponseCode": 204,
                            "ErrorMessage": "Filter Product details not found.",
                            "Data": {}
                        });
                    }
                }
            });
    });
});
