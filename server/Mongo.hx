
import js.mongo.MongoClient;
import js.mongo.MongoError;
import js.mongo.DB;


class Mongo {
    public static var DB:DB;

    private function new(){}

    public static function connect(callback:Void->Void) {
        MongoClient.connect("mongodb://localhost:27017/wifi").then(function(db:DB) {
            trace("Connect to: mongodb://localhost:27017/wifi");
            Mongo.DB = db;
            callback();
        }).catchError(function(error:MongoError) {
            trace("Mongo connect error: " + error.message);
        });
    }
}