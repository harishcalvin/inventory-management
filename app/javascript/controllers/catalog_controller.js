import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["productList", "categoryFilter", "sortSelect"];

  connect() {
    console.log("Catalog controller connected");
  }

  filterProducts() {
    this.fetchProducts();
  }

  sortProducts() {
    this.fetchProducts();
  }

  fetchProducts() {
    const categoryId = this.categoryFilterTarget.value;
    const sortValue = this.sortSelectTarget.value;
    const url = new URL(window.location.href);
    url.searchParams.set("category_id", categoryId);
    url.searchParams.set("sort", sortValue);

    fetch(url, {
      headers: {
        Accept: "text/html",
        "X-Requested-With": "XMLHttpRequest",
      },
    })
      .then((response) => response.text())
      .then((html) => {
        this.productListTarget.innerHTML = html;
      });
  }
}
