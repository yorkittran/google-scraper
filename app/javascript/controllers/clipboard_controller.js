import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static get targets() {
    return ["source", "button"];
  }

  copy() {
    navigator.clipboard.writeText(this.sourceTarget.value);
    // Change button
    this.buttonTarget.innerHTML =
      "Copied <i class='fa-solid fa-check ms-2'></i>";
    this.buttonTarget.classList.add("btn-success");
    this.buttonTarget.classList.remove("btn-outline-success");
    // Revert button
    this.timeout = setTimeout(() => {
      this.buttonTarget.innerHTML =
        "Copy Source HTML <i class='fa-solid fa-clipboard ms-2'></i>";
      this.buttonTarget.classList.remove("btn-success");
      this.buttonTarget.classList.add("btn-outline-success");
    }, 1500);
  }
}
