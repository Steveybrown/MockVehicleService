import Vapor
import HTTP

final class MakesController {
    
    func addRoutes(drop: Droplet) {
        let route = drop.grouped("makes")
        route.get(handler: index)
        route.post(handler: create)
        route.get(Make.self, handler: show)
        route.delete(handler: clear)
        route.get(Make.self, "models", handler: testing)
    }
    
    // http - get /makes
    func index(request: Request) throws -> ResponseRepresentable {
        return try Make.all().makeNode().converted(to: JSON.self)
    }
    
    // http - post /makes
    func create(request: Request) throws -> ResponseRepresentable {
        var make = try request.make()
        try make.save()
        return make
    }
    
    // http - get /makes/{{id}}
    func show(request: Request, make: Make) throws -> ResponseRepresentable {
        print(make)
        return make
    }
    
    // http - delete /makes
    func clear(request: Request) throws -> ResponseRepresentable {
        try Make.query().delete()
        return try Make.all().makeJSON().converted(to: JSON.self)
    }
    
    func testing(req: Request, make: Make) -> ResponseRepresentable {
        return "Hello"
    }
}

extension Request {
    func make() throws -> Make {
        guard let json = json else { throw Abort.badRequest }
        return try Make(node: json)
    }
}
