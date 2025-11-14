import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["recordButton", "status", "urlField"]

  connect() {
    this.mediaRecorder = null
    this.audioChunks = []
    this.isRecording = false
  }

  async toggleRecording() {
    if (!this.isRecording) {
      await this.startRecording()
    } else {
      this.stopRecording()
    }
  }

  async startRecording() {
    try {
      const stream = await navigator.mediaDevices.getUserMedia({ audio: true })
      this.mediaRecorder = new MediaRecorder(stream)

      this.mediaRecorder.ondataavailable = (event) => {
        this.audioChunks.push(event.data)
      }

      this.mediaRecorder.onstop = () => {
        const audioBlob = new Blob(this.audioChunks, { type: 'audio/webm' })
        const audioUrl = URL.createObjectURL(audioBlob)

        // Store URL in hidden field
        this.urlFieldTarget.value = audioUrl

        // Clean up
        this.audioChunks = []
        stream.getTracks().forEach(track => track.stop())
      }

      this.mediaRecorder.start()
      this.isRecording = true

      // Update UI
      this.recordButtonTarget.textContent = "⏹️ Stop Recording"
      this.recordButtonTarget.classList.remove("btn-secondary")
      this.recordButtonTarget.classList.add("btn-primary")
      this.statusTarget.classList.remove("hidden")

      // Haptic feedback
      if ('vibrate' in navigator) {
        navigator.vibrate(20)
      }
    } catch (error) {
      console.error("Error accessing microphone:", error)
      alert("Could not access microphone. Please check permissions.")
    }
  }

  stopRecording() {
    if (this.mediaRecorder && this.isRecording) {
      this.mediaRecorder.stop()
      this.isRecording = false

      // Update UI
      this.recordButtonTarget.textContent = "✅ Recording Saved"
      this.recordButtonTarget.classList.remove("btn-primary")
      this.recordButtonTarget.classList.add("btn-secondary")
      this.statusTarget.classList.add("hidden")
      this.recordButtonTarget.disabled = true

      // Haptic feedback
      if ('vibrate' in navigator) {
        navigator.vibrate([10, 50, 10])
      }
    }
  }

  disconnect() {
    if (this.mediaRecorder && this.isRecording) {
      this.mediaRecorder.stop()
    }
  }
}
