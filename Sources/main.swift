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
        "shop": "bood_store",
        "Item": [
            "id": "\(id)",
            "name": "book",
            "value": "890"
        ]
    ]
    try response.send(json: JSON(dict)).end()
}

Kitura.addHTTPServer(onPort: 8090, with: router)
Kitura.run()
