import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="close-button"
export default class extends Controller {
  static targets = ["info"]

  close() {
    this.infoTarget.classList.toggle("hidden")
  }
}
