
class Main {
    static function main() {
        new Main();
    }

    public function new() {
        Mongo.connect(Server.run);
    }
}