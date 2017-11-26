import react.ReactComponent;
import react.ReactComponent.ReactComponentOfState;
import react.ReactMacro.jsx;
import datetime.DateTime;

class MonthlyReport extends ReactComponentOfState<MonthlyReportState> {

    public function new () {
        super();

        this.state = {selectedMonth: 1, report: null};
    }

    override function render():ReactElement {
        var rows = null;
        if (this.state.report != null) {
            var i = 0;
            rows = [for(row in this.state.report) {
                if (row.employees_docs.length > 0) {
                    var first = DateTools.format(DateTime.fromString(row.first.date), "%H:%M:%S");
                    var last = DateTools.format(DateTime.fromString(row.last.date), "%H:%M:%S");

                    jsx('<tr key=${i++}>
                        <td>${row._id.day}/${this.state.selectedMonth}/2017</td>
                        <td>${row.employees_docs[0].name.first} ${row.employees_docs[0].name.last}</td>
                        <td>${first}</td>
                        <td>${last}</td>
                    </tr>');
                }
            }];
        }

        return jsx('
			<div>
                <form onSubmit=${this.handleSubmit}>
                    <select onChange=${this.handleChange}>
                        <option value="1">January</option>
                        <option value="2">February</option>
                        <option value="3">March</option>
                        <option value="4">April</option>
                        <option value="5">May</option>
                        <option value="6">June</option>
                        <option value="7">July</option>
                        <option value="8">August</option>
                        <option value="9">September</option>
                        <option value="10">October</option>
                        <option value="11">November</option>
                        <option value="12">December</option>
                    </select>
                    <input type="submit" value="Get report" />
                </form>

                <table>
                    <thead>

                    </thead>
                    <tbody>
                        ${rows}
                    </tbody>
                </table>
			</div>
		');
    }

    function handleSubmit(event:js.html.Event) {
        event.preventDefault();
        
        API.getMonthlyReport(this.state.selectedMonth).handle(function(o) switch o {
            case Success(body): this.setState({report: haxe.Json.parse(body)}); // should trace an html page
            case Failure(e): trace(e);
        });
    }

    function handleChange(event) {
        event.preventDefault();

        this.setState({selectedMonth: event.target.value});
    }
}

typedef MonthlyReportState = {
    selectedMonth:Int,
    report:Array<Dynamic>
}