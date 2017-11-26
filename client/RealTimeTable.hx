
import react.ReactComponent;
import react.ReactComponent.ReactComponentOfState;
import react.ReactMacro.jsx;

class RealTimeTable extends ReactComponentOfState<RealTimeTableState> {

    public function new() {
        super();
        this.state = {aliveEmployees: []};
    }

    override function componentWillMount() {
        API.getRealTimeStatus().handle(function(o) switch o {
            case Success(body): this.setState({aliveEmployees: haxe.Json.parse(body)}); // should trace an html page
            case Failure(e): trace(e);
        });
    }

    override function render():ReactElement {
        var i = 1;
        var rows = [for(employee in this.state.aliveEmployees) {
            jsx('<tr key=${i++}>
                <td>${employee.name.first} ${employee.name.last}</td>
                <td>${employee.mac}</td>
            </tr>');
        }];
        
        return jsx('
			<div>
                <table>
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>MAC</th>
                        </tr>
                    </thead>
                    <tbody>
                        ${rows}
                    </tbody>
                </table>
			</div>
		');
    }
}

typedef RealTimeTableState = {
    aliveEmployees:Array<Dynamic>
}