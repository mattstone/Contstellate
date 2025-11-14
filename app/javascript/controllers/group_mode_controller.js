import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["playerSelector"]

  showPlayerCount(event) {
    event.preventDefault()
    this.playerSelectorTarget.classList.remove("hidden")
    this.playerSelectorTarget.classList.add("fade-in")
  }
}
