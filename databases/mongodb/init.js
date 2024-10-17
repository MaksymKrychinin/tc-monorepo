// Connect to the database
db = connect("localhost:27017/support_service");

// Create a sample collection for chat logs
db.createCollection("chat_logs");

// Insert sample data into chat logs collection
db.chat_logs.insertMany([
    { user_id: 1, message: "Hello, I need help with my order.", timestamp: new Date() },
    { user_id: 2, message: "I have a billing issue.", timestamp: new Date() }
]);