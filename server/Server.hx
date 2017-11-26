

import tink.http.containers.*;
import tink.http.Response;
import tink.http.Handler;
import tink.http.middleware.Static;
import tink.web.routing.*;
import controllers.Root;

class Server {
    public static var container:NodeContainer;

    private function new() {}

    public static function run() {
		var router = new Router<Root>(new Root());
		var handler:Handler = function(req) {
            return router.route(Context.ofRequest(req))
                .recover(OutgoingResponse.reportError);
        };

		handler = handler.applyMiddleware(new Static('./client/public/', '/'));
		Server.container = new NodeContainer(8080);
		container.run(handler);
    }
}