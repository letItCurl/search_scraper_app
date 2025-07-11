import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["mobileMenu", "dropdownMenu"]

  toggle() {
    this.mobileMenuTarget.classList.toggle("hidden")
  }

  toggleDropdown() {
    this.dropdownMenuTarget.classList.toggle("hidden")
  }
}