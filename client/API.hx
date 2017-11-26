import tink.http.clients.JsClient;
import tink.http.Request;
using tink.io.Source;

class API {
    public static inline var url = "/";

    public static function getRealTimeStatus() {
        var client = new JsClient();

        return client.request(new OutgoingRequest(new OutgoingRequestHeader(GET, API.url + 'api/attendance/alive', []), '')).next(function(res) return res.body.all());
    }

    public static function getMonthlyReport(month:Int) {
        var client = new JsClient();

        return client.request(new OutgoingRequest(new OutgoingRequestHeader(GET, API.url + 'api/attendance/alive/${month}', []), '')).next(function(res) return res.body.all());
    }
}
