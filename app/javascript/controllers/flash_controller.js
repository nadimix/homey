import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash"
export default class extends Controller {
  static targets = ["banner"]

  connect() {
    this.bannerTarget.classList.add("animate-fade-in-up");
    setTimeout(() => {
      this.close()
    }, 4000)
  }

  close() {
    this.element.remove()
  }
}
