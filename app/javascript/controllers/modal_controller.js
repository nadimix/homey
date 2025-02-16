import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  static targets = ["dialog"]

  open() {
    this.dialogTarget.classList.remove("hidden")
    this.dialogTarget.classList.add("animate-fade-in-up")
    // Prevent scrolling on the body when modal is open
    document.body.style.overflow = "hidden"
  }

  close() {
    this.dialogTarget.classList.add("hidden")
    this.dialogTarget.classList.remove("animate-fade-in-up")
    // Restore scrolling on the body when modal is closed
    document.body.style.overflow = "auto"
  }
}
