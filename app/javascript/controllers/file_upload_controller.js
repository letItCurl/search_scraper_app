import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "filename"]

  updateFileName() {
    const file = this.inputTarget.files[0]
    this.filenameTarget.textContent = file ? file.name : "CSV only. Max 10MB."
    this.element.requestSubmit()
  }
}
