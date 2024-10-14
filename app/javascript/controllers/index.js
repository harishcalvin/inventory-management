// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application";
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading";

eagerLoadControllersFrom("controllers", application);

import NewProductController from "./new_product_controller.js";
import EditProductController from "./edit_product_controller.js";
import SalesController from "./sales_controller.js";
import CatalogController from "./catalog_controller.js";

application.register("new-product", NewProductController);
application.register("edit-product", EditProductController);
application.register("sales", SalesController);
application.register("catalog", CatalogController);

console.log("Registered Stimulus controllers:", application.controllers);
