import Foundation
import Vapor
import HTTP

final class ModelController {
    
    func addRoutes(drop: Droplet) {
        let route = drop.grouped("models")
        route.get(handler: index)
        route.get("1", "2", "3", handler: test)
    }
    
    func index(request: Request) throws -> ResponseRepresentable {
        return "<h1>hello</h1>"
    }
    
    func test(req: Request) throws -> ResponseRepresentable {
        return "hello "
    }
    
}
