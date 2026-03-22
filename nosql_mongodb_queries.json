/*
Part 2 — NoSQL (MongoDB Queries)

This file demonstrates MongoDB operations on the orders collection
using a document-oriented database model.
*/


// --------------------------------------------------
// 1. Insert Order Documents
// --------------------------------------------------

db.orders.insertMany([
  {
    order_id: "ORD2001",
    customer_id: "CUST028",
    order_date: "2023-05-20",
    status: "delivered",
    total_amount: 2397,
    num_items: 1
  },
  {
    order_id: "ORD2002",
    customer_id: "CUST015",
    order_date: "2023-05-21",
    status: "pending",
    total_amount: 1200,
    num_items: 2
  }
]);


// --------------------------------------------------
// 2. Retrieve All Orders
// --------------------------------------------------

db.orders.find();


// --------------------------------------------------
// 3. Retrieve Delivered Orders
// --------------------------------------------------

db.orders.find({ status: "delivered" });


// --------------------------------------------------
// 4. Find Orders With Total Amount Greater Than 1000
// --------------------------------------------------

db.orders.find({ total_amount: { $gt: 1000 } });


// --------------------------------------------------
// 5. Find Orders Placed By A Specific Customer
// --------------------------------------------------

db.orders.find({ customer_id: "CUST028" });


// --------------------------------------------------
// 6. Sort Orders By Total Amount (Descending)
// --------------------------------------------------

db.orders.find().sort({ total_amount: -1 });


// --------------------------------------------------
// 7. Projection (Show Only Selected Fields)
// --------------------------------------------------

db.orders.find(
  {},
  { order_id: 1, total_amount: 1, _id: 0 }
);


// --------------------------------------------------
// 8. Update Order Status
// --------------------------------------------------

db.orders.updateOne(
  { order_id: "ORD2002" },
  { $set: { status: "delivered" } }
);


// --------------------------------------------------
// 9. Delete an Order
// --------------------------------------------------

db.orders.deleteOne({ order_id: "ORD2002" });


// --------------------------------------------------
// 10. Aggregation: Total Revenue
// --------------------------------------------------

db.orders.aggregate([
  {
    $group: {
      _id: null,
      total_revenue: { $sum: "$total_amount" }
    }
  }
]);


// --------------------------------------------------
// 11. Aggregation: Revenue by Status
// --------------------------------------------------

db.orders.aggregate([
  {
    $group: {
      _id: "$status",
      total_revenue: { $sum: "$total_amount" }
    }
  }
]);