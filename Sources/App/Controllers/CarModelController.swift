import Vapor
import HTTP

final class CarModelController: ResourceRepresentable {
    func index(request: Request) throws -> ResponseRepresentable {
        return try CarModel.all().makeNode().converted(to: JSON.self)
    }
    
    func create(request: Request) throws -> ResponseRepresentable {
        var carModel = try request.carModel()
        try carModel.save()
        return carModel
    }
    
    func makeResource() -> Resource<CarModel> {
        return Resource(
            index: index,
            store: create            
        )
    }
}

extension Request {
    func carModel() throws -> CarModel {
        guard let json = json else { throw Abort.badRequest }
        return try CarModel(node: json)
    }
}
