import Vapor
import VaporPostgreSQL

public enum Endpoint: String {
    case makes, users, vehicles
}


/*
    *** API Endpoints
    /makes/audi/models/
    /users
    /vehicles
 */

let drop = Droplet()
drop.preparations.append(CarModel.self)
drop.preparations.append(Make.self)

do {
    try drop.addProvider(VaporPostgreSQL.Provider.self)
} catch {
    print("Error adding providor \(error)")
}

drop.get { req in
    return try drop.view.make("welcome", [
    	"message": drop.localization[req.lang, "welcome", "title"]
    ])
}

// drop.resource("posts", PostController())
let mc = MakesController()
drop.resource(Endpoint.makes.rawValue, mc)
drop.get("makess", String.self, handler: mc.testing)


drop.get(Endpoint.vehicles.rawValue) { req in
    return JSON(Node(["vehicles": "1"]))
}

drop.get("makes2") { req in
    
    print(req.uri)
    return JSON(Node(["testing": "1"]) )
}

drop.run()
