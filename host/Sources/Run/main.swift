import App
import Vapor

var env = try Environment.detect()
try LoggingSystem.bootstrap(from: &env)
let app = Application(env)
app.http.server.configuration.port = 1987
defer { app.shutdown() }
try configure(app)
try app.run()
