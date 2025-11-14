import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["canvas"]
  static values = {
    galaxies: Array
  }

  connect() {
    // Simple constellation animation
    // In a future version, this could draw SVG lines connecting the galaxy icons
    this.animateGalaxies()
  }

  animateGalaxies() {
    const icons = this.canvasTarget.querySelectorAll('div')

    icons.forEach((icon, index) => {
      setTimeout(() => {
        icon.style.opacity = '0'
        icon.style.transform = 'scale(0.5)'

        setTimeout(() => {
          icon.style.transition = 'all 0.5s ease-out'
          icon.style.opacity = '1'
          icon.style.transform = 'scale(1)'
        }, 50)
      }, index * 150)
    })
  }
}
