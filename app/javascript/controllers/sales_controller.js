// javascript > controllers > sales_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [
    "productSelect",
    "variantSelect",
    "quantityInput",
    "itemsBody",
    "total",
    "totalInput",
    "form",
  ];
  connect() {
    console.log("Sales controller connected");
    this.products = JSON.parse(this.element.dataset.salesProducts);
  }

  handleProductChange(event) {
    const productId = event.target.value;
    const product = this.products.find((p) => p.id == productId);

    if (
      product.product_variants.length > 1 ||
      (product.product_variants.length === 1 &&
        product.product_variants[0].size !== "Default")
    ) {
      this.variantSelectTarget.innerHTML =
        '<option value="">Select a variant</option>' +
        product.product_variants
          .map(
            (v) =>
              `<option value="${v.id}" data-price="${v.price}">${v.size} - ${v.color} - ${v.material}</option>`
          )
          .join("");
      this.variantSelectTarget.style.display = "block";
    } else {
      this.variantSelectTarget.style.display = "none";
      this.variantSelectTarget.innerHTML = `<option value="${product.product_variants[0].id}" data-price="${product.product_variants[0].price}">Default</option>`;
    }
  }

  handleVariantChange(event) {
    // You can add logic here if needed
  }

  addItemToBill(event) {
    const productId = this.productSelectTarget.value;
    const variantId = this.variantSelectTarget.value;
    const quantity = parseInt(this.quantityInputTarget.value);

    const product = this.products.find((p) => p.id == productId);
    const variant = product.product_variants.find((v) => v.id == variantId);

    if (!variant) {
      alert("Please select a product variant");
      return;
    }

    const price = parseFloat(variant.price);
    if (isNaN(price)) {
      console.error("Invalid price for variant:", variant);
      alert("Error: Invalid price for the selected variant");
      return;
    }

    const subtotal = price * quantity;

    const row = document.createElement("tr");
    row.innerHTML = `
      <td class="px-6 py-4 whitespace-nowrap">${product.name}</td>
      <td class="px-6 py-4 whitespace-nowrap">${variant.size} - ${
      variant.color
    } - ${variant.material}</td>
      <td class="px-6 py-4 whitespace-nowrap">${quantity}</td>
      <td class="px-6 py-4 whitespace-nowrap">₹${price.toFixed(2)}</td>
      <td class="px-6 py-4 whitespace-nowrap">₹${subtotal.toFixed(2)}</td>
      <td class="px-6 py-4 whitespace-nowrap">
        <button type="button" class="text-red-600 hover:text-red-900" data-action="click->sales#removeItem">Remove</button>
      </td>
    `;
    row.dataset.productId = productId;
    row.dataset.variantId = variantId;
    this.itemsBodyTarget.appendChild(row);

    this.updateTotal();
  }

  removeItem(event) {
    event.target.closest("tr").remove();
    this.updateTotal();
  }

  updateTotal() {
    let total = 0;
    this.itemsBodyTarget.querySelectorAll("tr").forEach((row) => {
      total += parseFloat(row.cells[4].textContent.replace("₹", ""));
    });
    this.totalTarget.textContent = `₹${total.toFixed(2)}`;
    this.totalInputTarget.value = total.toFixed(2);
  }

  completeSale(event) {
    console.log("completeSale method called");
    event.preventDefault();
    if (this.itemsBodyTarget.children.length === 0) {
      alert("Please add items to the bill before completing the sale.");
      return;
    }

    const formData = new FormData(this.formTarget);

    // Add items to formData
    const items = Array.from(this.itemsBodyTarget.children).map((row) => {
      const cells = row.cells;
      return {
        product_variant_id: row.dataset.variantId,
        quantity: parseInt(cells[2].textContent),
        price: parseFloat(cells[3].textContent.replace("₹", "")),
      };
    });

    formData.append("sale[items]", JSON.stringify(items));
    formData.append("sale[total]", this.totalInputTarget.value);

    console.log("Form data:", Object.fromEntries(formData));

    fetch(this.formTarget.action, {
      method: "POST",
      body: formData,
      headers: {
        "X-Requested-With": "XMLHttpRequest",
        Accept: "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]')
          .content,
      },
    })
      .then((response) => {
        console.log("Response received:", response);
        if (!response.ok) {
          return response.json().then((data) => {
            throw new Error(
              data.errors ? data.errors.join(", ") : "Unknown error"
            );
          });
        }
        return response.json();
      })
      .then((data) => {
        console.log("Data received:", data);
        if (data.success) {
          this.showNotice("Sale completed successfully!");
          this.clearForm();
        } else {
          alert(
            "Error completing sale: " +
              (data.errors ? data.errors.join(", ") : "Unknown error")
          );
        }
      })
      .catch((error) => {
        console.error("Error:", error);
        alert("An error occurred: " + error.message);
      });
  }

  showNotice(message) {
    const notice = document.getElementById("notice");
    notice.textContent = message;
    notice.style.display = "block";
    setTimeout(() => {
      notice.style.display = "none";
    }, 5000);
  }

  clearForm() {
    this.itemsBodyTarget.innerHTML = "";
    this.totalTarget.textContent = "₹0.00";
    this.totalInputTarget.value = "0.00";
    this.productSelectTarget.selectedIndex = 0;
    this.variantSelectTarget.innerHTML =
      '<option value="">Select a variant</option>';
    this.variantSelectTarget.style.display = "none";
    this.quantityInputTarget.value = "1";
  }
}
