import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.element.addEventListener("submit", this.handleSubmit.bind(this))
  }

  handleSubmit(event) {
    if (this.element.dataset.turboConfirm) {
      if (!confirm(this.element.dataset.turboConfirm)) {
        event.preventDefault()
        event.stopPropagation()
      }
    }
  }
}