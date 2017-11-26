package models;

using tink.CoreApi;
import tink.core.Promise;
import js.mongo.Collection.CollectionName;

class Attendances extends Model {
    static inline var TABLE = new CollectionName<AttendanceDocument>("attendances");

    @:isVar public var mac(get,set):String;
    @:isVar public var timestamp(get,set):Date;

    public function new() {}

    public static function aggregate(pipeline:Dynamic, ?options = null) {
        trace("aggregate: " + Std.string(pipeline));

        return Mongo.DB.collection(TABLE).aggregate(pipeline, options);
    }

    public static function find(query:Dynamic = null) {
        trace("find: " + Std.string(query));
        return Mongo.DB.collection(TABLE).find(query);
    }

    public function insertAttendancePulse():Promise<Bool> {
        return this.insert();
    }

    public function insert() {
        return Promise.ofJsPromise(Mongo.DB.collection(TABLE).insertOne({
            "mac": this.mac,
            "dateTime": {
                timestamp: this.timestamp,
                timezone: 'Asia/Tel_Aviv'
            }
        })).next(function(results) {
            return true;
        });
    }

    inline function get_mac():String {return this.mac;}
    inline function set_mac(mac:String):String {return this.mac = mac;}

    inline function get_timestamp():Date {return this.timestamp;}
    inline function set_timestamp(timestamp:Date):Date {return this.timestamp = timestamp;}
} 

typedef AttendanceDocument = {
    mac: String,
    dateTime: {timestamp:Date, timezone:String}
}