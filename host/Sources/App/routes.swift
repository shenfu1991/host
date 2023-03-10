import Vapor

struct AddUserModel: Content {
    var msg: String?
    var success: Bool
}


func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }
    
    app.get("runcmd",":cmd") { req -> AddUserModel in
        let name = req.parameters.get("cmd") ?? ""
        _ = runCMD(host: name)        
        return AddUserModel(msg: "success", success: true)
    }
    
    app.get("update") { req -> AddUserModel in
        update()
        return AddUserModel(msg: "success", success: true)
    }
    
    app.get("cmd",":cmd") { req -> AddUserModel in
        let name = req.parameters.get("cmd") ?? ""
        shellFunc(name)
        return AddUserModel(msg: "success", success: true)
    }
}
