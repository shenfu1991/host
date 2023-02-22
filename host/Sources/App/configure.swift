import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    // register routes
    try routes(app)
}

public func runCMD(shell: String) {
    
    let cmds = """

cat>./cmd<<EOF

killall \(shell)
killall \(shell)
killall \(shell)
killall \(shell)
cd /root/\(shell)/x-bot
git checkout Package.swift
git checkout Package.resolved
git checkout *
git pull

rm -rf /root/\(shell)/x-bot/Package.swift

cat>"/root/\(shell)/x-bot/Package.swift"<<XOF

// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "x-bot",
    platforms: [
       .macOS(.v10_15)
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0")
        //.package(url: "https://github.com/vapor/mysql-kit.git", from: "4.0.0")
    ],
    targets: [
        .target(
            name: "App",
            dependencies: [
                .product(name: "Vapor", package: "vapor")
               // .product(name: "MySQLKit",package: "mysql-kit")
            ],
            swiftSettings: [
                .unsafeFlags(["-cross-module-optimization"], .when(configuration: .release))
            ]
        ),
        .target(name: "\(shell)", dependencies: [.target(name: "App")]),
        .testTarget(name: "AppTests", dependencies: [
            .target(name: "App"),
            .product(name: "XCTVapor", package: "vapor"),
        ])
    ]
)

XOF

sleep 5 &
cd /root/\(shell)/x-bot &
rm -rf *.out &
#nohup swift run &
nohup swift run > x-bot.log 2>&1 &


EOF

chmod +x cmd
./cmd

"""
    
    
    shellFunc(cmds)
}

@discardableResult
func shellFunc(_ args: String...) -> Int32 {
    let task = Process()
    task.launchPath = "/usr/bin/env"
    task.arguments = args
    task.launch()
    task.waitUntilExit()
    return task.terminationStatus
}
