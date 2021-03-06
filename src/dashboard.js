"use strict";

var logger = require("./logger");
var app = require('../app');
// const util = require('util')

/*
* Get Dashboard Details (Type, Tag Category, Banner, New Arrival, Hot Deals) 
*/
app.post('/dashboard/get', function (req, res) {
    req.getConnection(function (err, connection) {
        let sql = 'CALL GetDashboardDetails()';
        connection.query(sql, [], (error, results, fields) => {
            if (error) {
                logger.error(error, { 'req': req.body, 'function': 'Dashboard,Get' });
                res.send({
                    "ResponseCode": 400,
                    "ErrorMessage": "Unknown error ocurred.",
                    "Data": {}
                });
            } else {
                if (results.length > 0) {
                    logger.info(results, { 'req': req.body, 'function': 'Dashboard,Get' });

                    // Type Name and tag category mapping
                    var typeName = [], type = [], i;
                    results[0].map(a => {
                        if (type.indexOf(a.ProductType) === -1) {
                            type.push(a.ProductType);
                            var tag = [];
                            results[0].map(b => {
                                if (b.ProductType == a.ProductType) {
                                    tag.push({
                                        "ProductName": b.ProductName,
                                        "ProductId": b.ProductId,
                                        "ImageURL": b.ImageURL
                                    });
                                };
                            });
                            typeName.push({
                                "ProductTypeId": a.ProductTypeId,
                                "ProductType": a.ProductType,
                                "ProductDetails": tag
                            });
                        };
                    });
                    // End Mapping

                    res.send({
                        "ResponseCode": 200,
                        "ErrorMessage": "",
                        "Data": { Type: typeName, Banner: results[1], NewArrivals: results[2], HotDeals: results[3] }
                    });
                }
                else {
                    logger.error("Dashboard details not found.", { 'req': req.body, 'function': 'Dashboard,Get' });
                    res.send({
                        "ResponseCode": 204,
                        "ErrorMessage": "Dashboard does not exits",
                        "Data": {}
                    });
                };
            };
        });
    });
});

/*
* Get Dashboard Details (Type, Tag Category, Banner, New Arrival, Hot Deals) 
*/
app.post('/dashboard/getold', function (req, res) {
    req.getConnection(function (err, connection) {
        let sql = 'CALL GetDashboardDetails()';
        connection.query(sql, [], (error, results, fields) => {
            if (error) {
                logger.error(error, { 'req': req.body, 'function': 'Dashboard,Get' });
                res.send({
                    "ResponseCode": 400,
                    "ErrorMessage": "Unknown error ocurred.",
                    "Data": {}
                });
            } else {
                if (results.length > 0) {
                    logger.info(results, { 'req': req.body, 'function': 'Dashboard,Get' });

                    // Type Name and tag category mapping
                    var typeName = [], type = [], i;
                    results[0].map(a => {
                        if (type.indexOf(a.TypeName) === -1) {
                            type.push(a.TypeName);
                            var tag = [];
                            results[0].map(b => {
                                if (b.TypeName == a.TypeName) {
                                    tag.push({
                                        "TagCatId": b.TagCatId,
                                        "TagCategory": b.TagCategory
                                    });
                                };
                            });
                            typeName.push({
                                "TypeId": a.TypeId,
                                "TypeName": a.TypeName,
                                "TagCategory": tag
                            });
                        };
                    });
                    // End Mapping

                    res.send({
                        "ResponseCode": 200,
                        "ErrorMessage": "",
                        "Data": { Type: typeName, Banner: results[1], NewArrivals: results[2], HotDeals: results[3] }
                    });
                }
                else {
                    logger.error("Dashboard details not found.", { 'req': req.body, 'function': 'Dashboard,Get' });
                    res.send({
                        "ResponseCode": 204,
                        "ErrorMessage": "Dashboard does not exits",
                        "Data": {}
                    });
                };
            };
        });
    });
});

