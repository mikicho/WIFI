package controllers;

import tink.http.Response;

import sys.io.File;
class Root {
    public function new() {}

    @:sub
    public var api = new API();

    @:get("/")
    public function index() {
        return OutgoingResponse.blob(StatusCode.OK, File.getContent("client/public/index.html"), "text/html");
    }
}