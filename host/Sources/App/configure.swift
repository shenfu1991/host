import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    // register routes
    try routes(app)
}

public func runCMD(host: String) ->Int32 {
    var cmds = "/root/\(host)/x-bot/MENG"
    if host.contains("rn") {
        cmds = "/root/\(host)/MENG"
    }
   return shellFunc(cmds)
}

public func update() {
  shellFunc("/root/host/host/go")
}

@discardableResult
func shellFunc(_ args: String...) -> Int32 {
    let task = Process()
    task.launchPath = "/usr/bin/env"
    task.arguments = args
    task.launch()
//    task.exit
//    return task.terminationStatus
    return 0
}
