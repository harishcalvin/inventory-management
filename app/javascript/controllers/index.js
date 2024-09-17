// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application";
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading";
eagerLoadControllersFrom("controllers", application);
import NewProductController from "./new_product_controller";
application.register("new-product", NewProductController);
// edit
import EditProductController from "./edit_product_controller";
application.register("edit-product", EditProductController);
