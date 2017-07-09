import Kitura
import HeliumLogger
import LoggerAPI

let router = Router()
HeliumLogger.use()

router.get("/") {
    request, response, next in
    Log.info("Hello!Logger!")
    response.status(.OK).send("Hello Wolrd")
    next()
}

Kitura.addHTTPServer(onPort: 8090, with: router)
Kitura.run()
