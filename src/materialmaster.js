"use strict";

var logger = require("./logger");
var app = require('../app');

/*
* Get User Address (UserID) 
*/
app.post('/materialmaster/get', function (req, res) {
    var _materialId = '';
    if (req.body.MaterialId != null) {
        _materialId = req.body.MaterialId;
    }

    // console.log(_storeId);
    req.getConnection(function (err, connection) {
        let sql = 'CALL GetMaterialMaster(?)';
        connection.query(sql, _materialId, (error, results, fields) => {
            if (error) {
                logger.error(error, { 'req': req.body, 'function': 'Material Master,Get' });
                res.send({
                    "ResponseCode": 400,
                    "ErrorMessage": "Unknown error ocurred.",
                    "Data": {}
                });
            } else {
                if (results.length > 0) {
                    logger.info(results[0], { 'req': req.body, 'function': 'Material Master,Get' });
                    res.send({
                        "ResponseCode": 200,
                        "ErrorMessage": "",
                        "Data": { Material: results[0] }
                    });
                }
                else {
                    logger.error("Material Master details does not exits", { 'req': req.body, 'function': 'Material Master,Get' });
                    res.send({
                        "ResponseCode": 204,
                        "ErrorMessage": "Material Master details does not exits.",
                        "Data": {}
                    });
                }
            }
        });
    });
});

/*
* Add Address (Name , UserID , Line 1 , Phone 1) 
*/
app.post('/materialmaster/add', function (req, res) {

    if (req.body.Material == null) {
        logger.error('Please send the value in {"Material":""} format.', { 'req': req.body, 'function': 'Material,Add' });
        res.send({
            ResponseCode: 400,
            ErrorMessage: 'Please send the value in {"Material":""} format.',
            Data: {}
        });
        return;
    }

    var _material = req.body.Material;
    var _process = req.body.Process;
    var _durability = req.body.DurabilityAndFlexibility;
    var _weight = req.body.Weight;
    var _longLasting = req.body.LongLasting;
    var _corrosion = req.body.CorrosionScratches;
    var _opticianComments = req.body.OpticianComments;
    var _opticianRating = req.body.OpticianRating;
    var _extraDetails = req.body.ExtraDetails;
    var _comments = req.body.Comments;
    var _createdBy = req.body.CreatedBy;

    req.getConnection(function (err, connection) {
        let sql = 'CALL AddMasterMaterial(?,?,?,?,?,?,?,?,?,?,?)';
        connection.query(sql, [_material, _process, _durability, _weight, _longLasting, _corrosion,
            _opticianComments, _opticianRating, _extraDetails, _comments, _createdBy]
            , (error, results, fields) => {
                if (error) {
                    logger.error(error, { 'req': req.body, 'function': 'Material,Add' });
                    res.send({
                        "ResponseCode": 400,
                        "ErrorMessage": "Error while add new Material.",
                        "Data": {}
                    });
                } else {
                    if (results.length > 0) {
                        if ((results[0][0].Message.indexOf('Error') <= -1)) {
                            logger.info(results[0], { 'req': req.body, 'function': 'Material,Add' });
                            res.send({
                                "ResponseCode": 200,
                                "ErrorMessage": "",
                                "Data": results[0][0].Message
                            });
                        }
                        else {
                            logger.error(results[0][0].Message, { 'req': req.body, 'function': 'Material,Add' });
                            res.send({
                                "ResponseCode": 204,
                                "ErrorMessage": results[0][0].Message,
                                "Data": {}
                            });
                        }
                    }
                    else {
                        logger.error('Error while add new address.', { 'req': req.body, 'function': 'Material,Add' });
                        res.send({
                            "ResponseCode": 204,
                            "ErrorMessage": "Error while add new Material.",
                            "Data": {}
                        });
                    }
                }
            });
    });
});
