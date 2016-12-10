import Vapor
import VaporPostgreSQL

/*
 -- api endpoints
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
drop.resource("makes", MakesController())

drop.get("vehicles") { req in
    return JSON(Node(["vehicles": "1"]))
}


drop.run()
