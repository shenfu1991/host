import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }
    
    app.get("runcmd",":cmd") { req async -> Int32 in
        let name = req.parameters.get("cmd") ?? ""
       return runCMD(host: name)
//       return "Hello, world!"
    }
}
