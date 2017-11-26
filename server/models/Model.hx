package models;

import js.mongo.ObjectID;

class Model {
    @:isVar public var _id(get, set):ObjectID;

    inline function set__id(id):ObjectID {
        return this._id = id;
    }
    inline function get__id():ObjectID {
        return this._id;
    }
}