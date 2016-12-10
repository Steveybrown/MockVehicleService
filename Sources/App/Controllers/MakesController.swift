import Vapor
import HTTP

final class MakesController: ResourceRepresentable {
    func index(request: Request) throws -> ResponseRepresentable {
        return try Make.all().makeNode().converted(to: JSON.self)
    }
    
    func create(request: Request) throws -> ResponseRepresentable {
        var make = try request.make()
        try make.save()
        return make
    }
    
    func makeResource() -> Resource<Make> {
        return Resource(
            index: index,
            store: create            
        )
    }
}

extension Request {
    func make() throws -> Make {
        guard let json = json else { throw Abort.badRequest }
        return try Make(node: json)
    }
}
