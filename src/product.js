"use strict";
var logger = require("./logger");
var passwordHash = require('password-hash');
var app = require('../app');


/*
* Product details (filter ) 
*/
app.post('/product/get', function (req, res) {
    var _productId = '';
    if (req.body.ProductId != null) {
        _productId = req.body.ProductId;
    }
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
                        "Data": { Products: results[0] }
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


/*
* Get Master (filter ) 
*/
app.post('/product/getmaster', function (req, res) {
    req.getConnection(function (err, connection) {
        let sql = 'CALL GetAllMasterForProducts()';
        connection.query(sql, '', (error, results, fields) => {
            if (error) {
                logger.error(error, { 'req': req.body, 'function': 'Product,GetMaster' });
                res.send({
                    "ResponseCode": 400,
                    "ErrorMessage": "Unknown error ocurred.",
                    "Data": {}
                });
            } else {
                if (results.length > 0) {
                    logger.info(results[0], { 'req': req.body, 'function': 'Product, GetMaster' });
                    res.send({
                        "ResponseCode": 200,
                        "ErrorMessage": "",
                        "Data": {
                            filterItems: [
                                { key: 'Brand', label: 'Brand', values: results[0] },
                                { key: 'ProductType', label: 'Product Type', values: results[1] },
                                { key: 'FrameSize', label: 'Frame Size', values: results[2] },
                                { key: 'FrameColor', label: 'Frame Color', values: results[3] },
                                { key: 'WeightGroup', label: 'Weight Group', values: results[4] },
                                { key: 'Material', label: 'Material', values: results[5] },
                                { key: 'PrescriptionType', label: 'Prescription Type', values: results[6] },
                                { key: 'FrameStyle', label: 'Frame Style', values: results[7] },
                                { key: 'FrameShape', label: 'Frame Shape', values: results[8] },
                                { key: 'FrameType', label: 'Frame Type', values: results[9] },
                                { key: 'DiscountType', label: 'Discount Type', values: results[10] },
                                { key: 'SuitsLensType', label: 'SuitsLens Type', values: results[11] }]
                        }
                    });
                }
                else {
                    logger.error("All Master details not found.", { 'req': req.body, 'function': 'Product,GetMaster' });
                    res.send({
                        "ResponseCode": 204,
                        "ErrorMessage": "All Master details not found.",
                        "Data": {}
                    });
                }
            }
        });
    });
});

/*
* Product Master get (filter ) 
*/
app.post('/product/getmasterdashboard', function (req, res) {
    req.getConnection(function (err, connection) {
        let sql = 'CALL GetAllMasterForProducts()';
        connection.query(sql, '', (error, results, fields) => {
            if (error) {
                logger.error(error, { 'req': req.body, 'function': 'Product,GetMaster' });
                res.send({
                    "ResponseCode": 400,
                    "ErrorMessage": "Unknown error ocurred.",
                    "Data": {}
                });
            } else {
                if (results.length > 0) {
                    logger.info(results[0], { 'req': req.body, 'function': 'Product, GetMaster' });
                    res.send({
                        "ResponseCode": 200,
                        "ErrorMessage": "",
                        "Data": {
                            BrandMaster: results[0],
                            ProductTypeMaster: results[1],
                            FrameSizeMaster: results[2],
                            FrameColorMaster: results[3],
                            WeightGroupMaster: results[4],
                            MaterialMaster: results[5],
                            PrescriptionTypeMaster: results[6],
                            FrameStyleMaster: results[7],
                            FrameShapeMaster: results[8],
                            FrameTypeMaster: results[9],
                            DiscountTypeMaster: results[10],
                            SuitsLensTypeMaster: results[11],
                        }
                    });
                }
                else {
                    logger.error("All Master details not found.", { 'req': req.body, 'function': 'Product,GetMaster' });
                    res.send({
                        "ResponseCode": 204,
                        "ErrorMessage": "All Master details not found.",
                        "Data": {}
                    });
                }
            }
        });
    });
});

/*
* Add PRODUCT (Name , UserID, Password, LoginType , Line 1 , Phone 1) 
*/
app.post('/product/add', function (req, res) {
    if (req.body.ProductName == null || req.body.ModelNo == null) {
        logger.error('Please send the value in {"ProductName":"","ModelNo":""}  format.', { 'req': req.body, 'function': 'Product,Add' });
        res.send({
            ResponseCode: 400,
            ErrorMessage: 'Please send the value in {"ProductName":"","ModelNo":""} format.',
            Data: {}
        });
        return;
    }

    var _storeId = 'ST001';//req.body.StoreId;
    var _productName = req.body.ProductName;
    var _description = req.body.Description;
    var _modelNo = req.body.ModelNo;
    var _brandId = req.body.BrandId;
    var _productType = req.body.ProductType;
    var _frameSize = req.body.FrameSize;
    var _frameColour = req.body.FrameColour;
    var _weight = req.body.Weight;
    var _weightGroup = req.body.WeightGroup;
    var _material = req.body.Material;
    var _frameMaterial = req.body.FrameMaterial;
    var _templeMaterial = req.body.TempleMaterial;
    var _prescriptionType = req.body.PrescriptionType;
    var _frameStyle = req.body.FrameStyle;
    var _frameStyleSecondary = req.body.FrameStyleSecondary;
    var _frameShape = req.body.FrameShape;
    var _frameType = req.body.FrameType;
    var _collection = req.body.Collection;
    var _productWarranty = req.body.ProductWarranty;
    var _gender = req.body.Gender;
    var _height = req.body.Height;
    var _condition = req.body.Condition;
    var _templeColour = req.body.TempleColour;
    var _price = req.body.Price;
    var _discount = req.body.Discount;
    var _discountType = req.body.DiscountType;
    var _mRP = req.body.MRP;
    var _mRPAfterDiscount = req.body.MRPAfterDiscount;
    var _isPower = req.body.IsPower;
    var _suitsLensType = req.body.SuitsLensType;
    var _isCODAvailable = req.body.isCODAvailable;
    var _status = 'Available';
    var _availableStatus = '1';
    var _isApproved = '1';
    var _createdBy = req.body.CreatedBy;


    req.getConnection(function (err, connection) {
        let sql = 'CALL AddProductDetails(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)';
        connection.query(sql, [_storeId, _productName, _description, _modelNo, _brandId, _productType,
            _frameSize, _frameColour, _weight, _weightGroup, _material, _frameMaterial, _templeMaterial, _prescriptionType, _frameStyle,
            _frameStyleSecondary, _frameShape, _frameType, _collection, _productWarranty, _gender, _height, _condition,
            _templeColour, _price, _discount, _discountType, _mRP, _mRPAfterDiscount, _isPower, _suitsLensType,
            _isCODAvailable, _status, _availableStatus, _isApproved, _createdBy,]

            , (error, results, fields) => {
                if (error) {
                    logger.error(error, { 'req': req.body, 'function': 'Product,Add' });
                    res.send({
                        "ResponseCode": 400,
                        "ErrorMessage": "Error while add new Product.",
                        "Data": {}
                    });
                } else {
                    if (results.length > 0) {
                        if ((results[0][0].Message.indexOf('Error') <= -1)) {
                            logger.info(results[0], { 'req': req.body, 'function': 'Product,Add' });
                            res.send({
                                "ResponseCode": 200,
                                "ErrorMessage": "",
                                "Data": results[0][0].Message
                            });
                        }
                        else {
                            logger.error(results[0][0].Message, { 'req': req.body, 'function': 'Product,Add' });
                            res.send({
                                "ResponseCode": 204,
                                "ErrorMessage": results[0][0].Message,
                                "Data": {}
                            });
                        }
                    }
                    else {
                        logger.error('Error while add new Product.', { 'req': req.body, 'function': 'Product,Add' });
                        res.send({
                            "ResponseCode": 204,
                            "ErrorMessage": "Error while add new Product details.",
                            "Data": {}
                        });
                    }
                }
            });
    });
});
