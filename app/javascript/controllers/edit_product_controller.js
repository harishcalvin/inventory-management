import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.editProductForm();
  }
  editProductForm() {
    const productForm = document.getElementById("product-form");
    const variantsTable = document
      .getElementById("variants-table")
      ?.getElementsByTagName("tbody")[0];

    if (variantsTable) {
      variantsTable.addEventListener("click", function (e) {
        if (e.target.classList.contains("remove-variant")) {
          e.target.closest("tr").remove();
        }
      });

      productForm.addEventListener("submit", function (e) {
        e.preventDefault();
        const variantRows = variantsTable.getElementsByTagName("tr");
        const variants = [];

        for (let row of variantRows) {
          const cells = row.getElementsByTagName("td");
          variants.push({
            size: cells[0].textContent,
            color: cells[1].textContent,
            material: cells[2].textContent,
            price: cells[3].getElementsByTagName("input")[0].value,
            stock_quantity: cells[4].getElementsByTagName("input")[0].value,
          });
        }

        const variantsInput = document.createElement("input");
        variantsInput.type = "hidden";
        variantsInput.name = "variants";
        variantsInput.value = JSON.stringify(variants);
        productForm.appendChild(variantsInput);

        productForm.submit();
      });
    }
  }
}
