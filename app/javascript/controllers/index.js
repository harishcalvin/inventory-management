// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application";
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading";

// Use importmap paths instead of relative paths
import NewProductController from "controllers/new_product_controller";
import EditProductController from "controllers/edit_product_controller";
import SalesController from "controllers/sales_controller";
import CatalogController from "controllers/catalog_controller";

eagerLoadControllersFrom("controllers", application);

application.register("new-product", NewProductController);
application.register("edit-product", EditProductController);
application.register("sales", SalesController);
application.register("catalog", CatalogController);

console.log("Registered Stimulus controllers:", application.controllers);
