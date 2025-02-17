import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dropdown"
export default class extends Controller {
  static targets = ["menu"]

  connect() {
    // Add event listener for clicks outside the dropdown
    document.addEventListener("click", this.closeOnClickOutside)
  }

  disconnect() {
    // Remove event listener when controller is disconnected
    document.removeEventListener("click", this.closeOnClickOutside)
  }

  toggle() {
    this.menuTarget.classList.toggle("hidden")
    this.menuTarget.classList.toggle("animate-fade-in-up")
  }

  closeOnClickOutside = (event) => {
    if (!this.element.contains(event.target) && !this.menuTarget.classList.contains("hidden")) {
      this.close()
    }
  }

  close() {
    this.menuTarget.classList.add("hidden")
    this.menuTarget.classList.remove("animate-fade-in-up")
  }
}
