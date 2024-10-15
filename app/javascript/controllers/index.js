// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application";
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading";

// Use importmap paths instead of relative paths
import NewProductController from "controllers/new_product_controller.js";
import EditProductController from "controllers/edit_product_controller.js";
import SalesController from "controllers/sales_controller.js";
import CatalogController from "controllers/catalog_controller.js";

eagerLoadControllersFrom("controllers", application);

application.register("new-product", NewProductController);
application.register("edit-product", EditProductController);
application.register("sales", SalesController);
application.register("catalog", CatalogController);

console.log("Registered Stimulus controllers:", application.controllers);
