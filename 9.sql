//--use p10

db.Journal.drop();
db.Journal.insertMany([
    {'book_id':1, 'book_name': 'JavacdOOP','amt':500,'status':'Available'},
    {'book_id':1, 'book_name': 'JavaOOP','amt':400, 'status': 'Not Available'},
    {'book_id':1, 'book_name': 'Java','amt':300,'status': 'Not Available'},
    {'book_id': 2, 'book_name': 'Java','amt':300,'status': 'Available'},
    {'book_id': 2, 'book_name':'OPP','amt':200,'status':'Available'},
    {'book_id': 2, 'book_name':'C+','amt': 200,'status': 'Available'},
    {'book_id':3, 'book_name':'C+','amt': 150,'status':'Available'},
    {'book_id':3, 'book_name':'C++','amt':200,'status': 'Not Available'},
    {'book_id':4,'book_name': 'OPP C++','amt':300,'status': 'Not Available'},
    {'book_id':5,'book_name': 'OPP C++','amt':400,'status': 'Available'},
    {'book_id':5,'book_name':'C++','amt':400,'status': 'Available'},
    {'book_id':5,'book_name':'C++ Java', 'amt':400, 'status': 'Not Available'}
]);

print("--- Aggregation (Total 'amt' per 'book_id') ---");
db.Journal.aggregate([
  {
    $group: {
      _id: "$book_id",
      total_amount: { $sum: "$amt" }
    }
  },
  {
    $sort: { _id: 1 }
  }
]).pretty();

print("\n---Indexing (Finding books by 'status') ---");

print("Creating index on 'status'...");
db.Journal.createIndex({ "status": 1 });

print("\nFinding all 'Available' books:");
db.Journal.find({ "status": "Available" }).pretty();

print("\nFinding all 'Not Available' books:");
db.Setting.find({ "status": "Not Available" }).pretty();
