import Kitura
import HeliumLogger
import LoggerAPI
import SwiftyJSON

let router = Router()
HeliumLogger.use()

router.get("/") {
    request, response, next in
    Log.info("Hello, Kitura!")
    response.status(.OK).send("Hello, Kitura!")
    next()
}

router.get("/test") { request, response, next in
    try response.send("Hello! Test.").end()
}

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

// http://localhost:8090/
Kitura.addHTTPServer(onPort: 8090, with: router)
Kitura.run()
