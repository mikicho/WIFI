package models;

import tink.core.Promise;

import js.mongo.Collection.CollectionName;

class Employee extends Model {
    static inline var TABLE = new CollectionName<EmployeeDocument>("employees");

    @:isVar public var name(get, set):EmployeeName;
    @:isVar public var mac(get, set):String;

    public function new(){}

    public static function find(query:Dynamic = null) {
        trace("find: " + Std.string(query));
        return Mongo.DB.collection(TABLE).find(query);
    }
    public function insertEmployee() {
        return this.insert();
    }

    public function insert():Promise<Bool> {
        return Promise.ofJsPromise(Mongo.DB.collection(TABLE).insertOne({
            "_id": this.mac,
            "name": {
                "first":this.name.first,
                "last": this.name.last
            }
        })).next(function(results) {
            return true;
        });
    }

    inline function get_name():EmployeeName {return this.name;}
    inline function set_name(name:EmployeeName) {return this.name = name;}

    inline function get_mac():String {return this.mac;}
    inline function set_mac(mac:String) {return this.mac = mac;}
}

typedef EmployeeName = {
    first:String,
    last:String
}

typedef EmployeeDocument = {
    _id:String,
    name:EmployeeName
}