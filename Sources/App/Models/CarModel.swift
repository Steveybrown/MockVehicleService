import Vapor
import Fluent
import Foundation

final class CarModel: Model {
    var id: Node?
    var make: String
    var exists: Bool = false
    
    init(make: String) {
        self.id = UUID().uuidString.makeNode()
        self.make = make
    }
    
    public init(node: Node, in context: Context) throws {
        id = try node.extract("id")
        make = try node.extract("make")
    }

    public func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            "id": id,
            "make": make
            ])
    }
}

extension CarModel: Preparation {
    static func prepare(_ database: Database) throws {
        try database.create("carmodels") { models in
            models.id()
            models.string("make")
        }
    }
    
    static func revert(_ database: Database) throws {
        //
    }
}
