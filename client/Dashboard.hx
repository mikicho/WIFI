
import react.ReactComponent;
import react.ReactMacro.jsx;

class Dashboard extends ReactComponent {
    override function render():ReactElement {
        return jsx('
			<div>
                <RealTimeTable />
                <MonthlyReport />
			</div>
		');
    }
}