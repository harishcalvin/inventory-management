import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["sizeField", "colorField", "materialField"];

  toggleFields(event) {
    const selectedType = event.target.value;
    this.hideAllFields();
    if (selectedType === "Size") {
      this.sizeFieldTarget.style.display = "block";
    } else if (selectedType === "Color") {
      this.colorFieldTarget.style.display = "block";
    } else if (selectedType === "Material") {
      this.materialFieldTarget.style.display = "block";
    }
  }

  hideAllFields() {
    this.sizeFieldTarget.style.display = "none";
    this.colorFieldTarget.style.display = "none";
    this.materialFieldTarget.style.display = "none";
  }
}
