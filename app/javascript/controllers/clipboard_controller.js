import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static get targets() {
    return ["source"];
  }

  copy() {
    navigator.clipboard.writeText(this.sourceTarget.value);
  }
}
