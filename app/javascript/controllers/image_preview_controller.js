import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["preview", "input"]

  connect() {
    console.log("Image preview controller connected")
  }

  preview({ target }) {
    const preview = this.previewTargets[Array.from(this.inputTargets).indexOf(target)]

    if (target.files && target.files[0]) {
      const reader = new FileReader()

      reader.onload = (e) => {
        preview.src = e.target.result
        preview.style.display = 'block'
      }

      reader.readAsDataURL(target.files[0])
    } else {
      preview.src = ""
      preview.style.display = 'none'
    }
  }
}