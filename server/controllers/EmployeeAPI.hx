package controllers;

class EmployeeAPI {
    public function new() {}

    @:post("/")
    public function add(body:{mac:String, name:models.Employee.EmployeeName}) {
        trace("POST api/employee");
        var employee = new models.Employee();
        employee.mac = body.mac.toLowerCase();
        employee.name = body.name;
        return employee.insertEmployee();
    }
}
