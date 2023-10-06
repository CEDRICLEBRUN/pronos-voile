import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="countdown-start-race"
export default class extends Controller {
  static values = {
    date: String,
    refreshInterval: { type: Number, default: 1000 },
    expiredMessage: { type: String, default: "" }
  }

  connect() {
    console.log(this.dateValue)
    this.endTime = new Date(this.dateValue).getTime()
    this.update()
    this.timer = setInterval(() => { this.update() }, this.refreshIntervalValue )
  }

  disconnect() {
    this.stopTimer()
  }

  stopTimer() {
    if (this.time) {
      clearInterval(this.timer)
    }
  }

  update() {
    let difference = this.timeDifference()

    if (difference < 0) {
      this.element.textContent = this.expiredMessageValue
      this.stopTimer()
      return
    } else {
      let days = ("0" + (Math.floor(difference / (1000 * 60 * 60 * 24)))).slice(-2)
      let hours = ("0" + (Math.floor((difference % (1000 * 60 * 60 * 24) )/ (1000 * 60 * 60)))).slice(-2)
      let minutes = ("0" + (Math.floor((difference % (1000 * 60 * 60) )/ (1000 * 60)))).slice(-2)
      let secondes = ("0" + (Math.floor((difference % (1000 * 60) )/ 1000))).slice(-2)

      this.element.textContent = `${days}J ${hours}h ${minutes}m ${secondes}s`

    }
  }

  timeDifference() {
    return this.endTime - new Date().getTime()
  }
}
