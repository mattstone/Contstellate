import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    // Add shooting stars only
    for (let i = 0; i < 3; i++) {
      const star = document.createElement('div')
      star.className = 'shooting-star'
      this.element.prepend(star)
    }
  }
}
