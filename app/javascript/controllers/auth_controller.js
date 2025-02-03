import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["frame", "nav", "signinForm", "signupForm"]
  
  connect() {
    // Check if we're on the signup page
    if (window.location.pathname.includes("sign_up")) {
      this.activateSignup()
    }
  }
  
  activateSignup() {
    this.frameTarget.classList.add("frame-long")
    this.signinFormTarget.classList.add("form-hidden")
    this.signupFormTarget.classList.remove("form-hidden")
    this.signupFormTarget.style.transform = "translateX(0)"  // 追加
    this.signupFormTarget.style.opacity = "1"  // 追加
  }
  
  activateSignin() {
    this.frameTarget.classList.remove("frame-long")
    this.signinFormTarget.classList.remove("form-hidden")
    this.signinFormTarget.style.transform = "translateX(0)"  // 追加
    this.signinFormTarget.style.opacity = "1"  // 追加
    this.signupFormTarget.classList.add("form-hidden")
  }
  
  handleSubmit(event) {
    this.frameTarget.classList.add("frame-short")
    this.navTarget.classList.add("nav-up")
  }
}