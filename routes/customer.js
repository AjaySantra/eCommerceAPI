'use strict';

/*
 * GET customers listing.
 */
exports.list = function (req, res) {
    req.getConnection(function (err, connection) {
        connection.query('SELECT * FROM Customers', function (err, rows) {
            if (err) {
                var Data = { ErrorMessage: 'Data Not Found..', ResponseCode: '401', Data: rows };
                res.send(Data);
            }
            else {
                var Data = { ErrorMessage: '', ResponseCode: '200', Data: rows };
                res.send(Data);
            }
            //    console.log("Error Selecting : %s ",err ); 
        });
    });
};

exports.add = function (req, res) {
    res.render('add_customer', { page_title: "Add Customers-Node.js" });
};

exports.edit = function (req, res) {
    var id = req.params.id;
    req.getConnection(function (err, connection) {
        connection.query('SELECT * FROM customers WHERE id = ?', [id], function (err, rows) {
            if (err)
                console.log("Error Selecting : %s ", err);
            res.render('edit_customer', { page_title: "Edit Customers - Node.js", data: rows });
        });
    });
};
/*Save the customer*/
exports.save = function (req, res) {
    var input = JSON.parse(JSON.stringify(req.body));
    req.getConnection(function (err, connection) {
        var data = {
            CustomerName: input.CustomerName,
            EmailId: input.EmailId,
            PhoneNo: input.PhoneNo,
            Address: input.Address
        };
        var query = connection.query("INSERT INTO customer set ? ", data, function (err, rows) {
            if (err)
                console.log("Error inserting : %s ", err);
            res.redirect('/customers');
        });
        // console.log(query.sql); get raw query
    });
};/*Save edited customer*/

exports.save_edit = function (req, res) {
    var input = JSON.parse(JSON.stringify(req.body));
    var id = req.params.id;
    req.getConnection(function (err, connection) {
        var data = {
            CustomerName: input.CustomerName,
            EmailId: input.EmailId,
            PhoneNo: input.PhoneNo,
            Address: input.Address
        };
        connection.query("UPDATE customer set ? WHERE id = ? ", [data, id], function (err, rows) {
            if (err)
                console.log("Error Updating : %s ", err);
            res.redirect('/customers');
        });
    });
};

exports.delete_customer = function (req, res) {
    var id = req.params.id;
    req.getConnection(function (err, connection) {
        connection.query("DELETE FROM customers  WHERE id = ? ", [id], function (err, rows) {
            if (err)
                console.log("Error deleting : %s ", err);

            res.send('Customers details delete successfully.');
        });
    });
};