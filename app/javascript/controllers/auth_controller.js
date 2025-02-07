import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["frame", "nav", "signinForm", "signupForm"]
  
  connect() {
    if (window.location.pathname.includes("sign_up")) {
      this.activateSignup()
    }
  }
  
  activateSignup() {
    this.frameTarget.classList.add("frame-long")
    this.signinFormTarget.classList.add("form-hidden")
    this.signupFormTarget.classList.remove("form-hidden")
    this.signupFormTarget.style.transform = "translateX(0)"
    this.signupFormTarget.style.opacity = "1"
  }
  
  activateSignin() {
    this.frameTarget.classList.remove("frame-long")
    this.signinFormTarget.classList.remove("form-hidden")
    this.signinFormTarget.style.transform = "translateX(0)"
    this.signinFormTarget.style.opacity = "1"
    this.signupFormTarget.classList.add("form-hidden")
  }
  
  handleSubmit(event) {
    // フォームの種類を取得
    const formType = event.target.dataset.authForm
    
    // アニメーション処理
    this.frameTarget.classList.add("frame-short")
    this.navTarget.classList.add("nav-up")
    
    // フォームの種類に応じた処理
    if (formType === "signup") {
      // 新規登録フォームの場合
      const submitButton = event.target.querySelector('input[type="submit"]')
      if (submitButton) {
        submitButton.value = "新規登録"
      }
    }
  }
}