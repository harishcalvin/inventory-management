import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.initializeProductForm();
  }

  initializeProductForm() {
    const generateVariantsBtn = document.getElementById("generate-variants");
    const variantsReview = document.getElementById("variants-review");
    const variantsTable = document
      .getElementById("variants-table")
      .getElementsByTagName("tbody")[0];
    const productForm = document.getElementById("product-form");

    generateVariantsBtn.addEventListener("click", function () {
      const sizes = document
        .getElementById("sizes")
        .value.split(",")
        .map((s) => s.trim());
      const colors = document
        .getElementById("colors")
        .value.split(",")
        .map((c) => c.trim());
      const materials = document
        .getElementById("materials")
        .value.split(",")
        .map((m) => m.trim());
      const createProductBtn = document.getElementById("create-product-btn");
      variantsTable.innerHTML = "";
      // console.log(sizes, colors, materials)

      for (let size of sizes) {
        for (let color of colors) {
          for (let material of materials) {
            const row = variantsTable.insertRow();
            row.innerHTML = `
              <td>${size}</td>
              <td>${color}</td>
              <td>${material}</td>
              <td><input type="number" step="0.01" min="0" class="variant-price"></td>
              <td><input type="number" min="0" class="variant-stock"></td>
              <td><button type="button" class="remove-variant">Remove</button></td>
            `;
          }
        }
      }

      variantsReview.style.display = "block";
      createProductBtn.style.display = "inline-flex"; // Show the button after generating variants
    });

    variantsTable.addEventListener("click", function (e) {
      if (e.target.classList.contains("remove-variant")) {
        e.target.closest("tr").remove();
        if (variantsTable.rows.length === 0) {
          createProductBtn.style.display = "none"; // Hide the button if all variants are removed
          variantsReview.style.display = "none";
        }
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
