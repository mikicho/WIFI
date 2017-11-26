import react.ReactDOM;
import react.React;
import js.Browser;

class Application {
    public function new() {
        ReactDOM.render(React.createElement(Dashboard), Browser.document.getElementById('react-dashboard'));
    }
}