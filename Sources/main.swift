import Kitura
import HeliumLogger
import LoggerAPI
import SwiftyJSON

let router = Router()
HeliumLogger.use()

// http://localhost:8090/
router.get("/") {
    request, response, next in
    Log.info("Hello, Kitura!")
    response.status(.OK).send("Hello, Kitura!")
    next()
}

// http://localhost:8090/test
router.get("/test") { request, response, next in
    try response.send("Hello! Test.").end()
}

// http://localhost:8090/json?id=12345
router.get("/json") { (request, response, next) in
    let id = request.queryParameters["id"] ?? ""
    let dict: [String: Any] = [
        "ios": [
            "id": "\(id)",
            "name": "swift"
        ],
        "android": [
            "id": "\(id)",
            "name": "Kotlin"
        ]
        
    ]
    try response.send(json: JSON(dict)).end()
}

Kitura.addHTTPServer(onPort: 8090, with: router)
Kitura.run()
