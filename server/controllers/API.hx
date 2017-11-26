package controllers;

class API {
    public function new() {}

    @:sub("employee")
    public var employee = new EmployeeAPI();
    
    @:sub("attendance")
    public var attendance = new AttendancesAPI();

    @:get("check-for-update")
    public function checkForUpdate() {
        return haxe.crypto.Md5.encode(sys.io.File.getContent("./pinger.js"));
    }

    @:get("get-pinger-file")
    public function getPingerFile() {
        return sys.io.File.getContent("./pinger.js");
    }
}