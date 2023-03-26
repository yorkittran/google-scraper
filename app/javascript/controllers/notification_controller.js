import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  clearBadge() {
    const span = document.getElementById("icon-badge");
    if (span) span.parentNode.removeChild(span);
  }
}
