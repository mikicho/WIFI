package controllers;

import tink.core.Promise;
import models.Attendances;

class AttendancesAPI {
    public function new() {}

    @:get('/alive')
    public function getAlives() {
        var timestampQuery:Array<Dynamic> = [];

        var timeSpan:Date = Date.now();
        timeSpan = DateTools.delta(timeSpan, -10 * 60 * 1000); // 10 * 60 * 1000 = 10 min in ms

        return Attendances.aggregate([
                {"$match":{"dateTime.timestamp":{"$gte":timeSpan}}},
                {"$sort":{"_id":1}},{"$group":{_id:"$mac"}}
            ]).toArray().then(function (results:Array<Dynamic>) {
            var macs = new Array<String>();
            
            for (result in results) {
               macs.push(result._id);
            }

            return models.Employee.find({_id:{"$in": macs}}).toArray();
        });
    }

    @:get('/alive/$month')
    public function monthlyReport(month:Int = null) {
        var timestampQuery:Array<Dynamic> = [];

        var timeSpan:Date = Date.now();
        timeSpan = DateTools.delta(timeSpan, -10 * 60 * 1000); // 10 * 60 * 1000 = 10 min in ms
        
        timestampQuery = [
            {"$project": {month: {"$month": {date:"$dateTime.timestamp", timezone:"$dateTime.timezone"}}, mac: 1, dateTime: 1}}, 
            {"$match":{month: month}},
            {"$group":{_id:{
                    mac: "$mac", 
                    day:{"$dayOfMonth": {date:"$dateTime.timestamp", timezone:"$dateTime.timezone"}}
                }, 
                first: {"$min": {date:"$dateTime.timestamp", timezone:"$dateTime.timezone"}}, 
                last: {"$max": {date:"$dateTime.timestamp", timezone:"$dateTime.timezone"}}}
            },
            {"$sort":{"first":1}},            
            {"$lookup":{from: "employees", localField: "_id.mac", foreignField:"_id", as: "employees_docs"}}
        ];

        return Attendances.aggregate(timestampQuery).toArray();
    }

    @:post("/")
    public function insertAttendancePulse(body:{mac:String, timestamp:Date}) {
        trace("POST attendance " + body);

        var attendances = new Attendances();
        attendances.mac = body.mac;
        attendances.timestamp = body.timestamp;
        return attendances.insertAttendancePulse();
    }
}