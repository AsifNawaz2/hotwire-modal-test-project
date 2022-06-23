import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="turbo-modal"
export default class extends Controller {
  hideModal() {
    // it might be nice to also remove the modal SRC
    this.element.parentElement.removeAttribute("src")
    this.element.remove()
  }
}
