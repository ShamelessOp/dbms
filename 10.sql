-- sabse pehle 'use p10' likh ke enter hit karo fir badme code paste karo
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

// --- 2. Define Map and Reduce functions ---
var mapFunction = function() {
    emit(this.book_id, this.amt);
};

var reduceFunction = function(key, values) {
    return Array.sum(values);
};

// --- 3. Run the MapReduce operation ---
// This saves the results into a new collection called 'book_totals'
db.Journal.mapReduce(
    mapFunction,
    reduceFunction,
    { out: "book_totals" }
);

// --- 4. View the results ---
print("--- MapReduce Results (from 'book_totals' collection) ---");
db.book_totals.find().sort({ _id: 1 }).pretty();