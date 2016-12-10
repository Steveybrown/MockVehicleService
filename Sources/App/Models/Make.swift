import Vapor
import Fluent
import Foundation

final class Make: Model {
    var id: Node?
    var make: String
    
    init(make: String) {
        self.make = make
    }
    
    init(node: Node, in context: Context) throws {
        id = try node.extract("id")
        make = try node.extract("make")
    }
    
    func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            "id": id,
            "make": make
            ])
    }
}

extension Make: Preparation {
    static func prepare(_ database: Database) throws {
        try database.create("makes") { makes in
            makes.id()
            makes.string("make")
        }
    }
    
    static func seedData() {
        var m1 = Make(make: "Audi")
        var m2 = Make(make: "BMW")
        var m3 = Make(make: "Chevrolet")
        var m4 = Make(make: "Dodge")
        
        do {
            try m1.save()
            try m2.save()
            try m3.save()
            try m4.save()
        } catch {
            print("Failed to seed database with make data! \(error)")
        }
    }
    
    static func revert(_ database: Database) throws { }
}
