import Vapor
import VaporPostgreSQL

let drop = Droplet()
drop.preparations.append(CarModel.self)

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

drop.resource("posts", PostController())
drop.resource("makes", CarModelController())

drop.run()
