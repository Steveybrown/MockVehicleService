import Vapor
import HTTP

final class MakesController: ResourceRepresentable {
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
    
    func testing(_ req: Request, _ name: String) -> ResponseRepresentable {
        return "Hello, \(name)"
    }
    
    func makeResource() -> Resource<Make> {
        return Resource(
            index: index,
            store: create,
            show: show,
            clear: clear
        )
    }
}

extension Request {
    func make() throws -> Make {
        guard let json = json else { throw Abort.badRequest }
        return try Make(node: json)
    }
}
