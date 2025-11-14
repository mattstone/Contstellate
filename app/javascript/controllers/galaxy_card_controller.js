import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    color: String
  }

  connect() {
    // Apply galaxy color for hover effects
    this.element.style.setProperty('--galaxy-color', this.colorValue)
  }

  // Optional: Add haptic feedback on mobile
  click() {
    if ('vibrate' in navigator) {
      navigator.vibrate(10)
    }
  }
}
