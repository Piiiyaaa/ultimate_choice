// app/javascript/controllers/comments_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["container"]

  showComments(event) {
    const choice = event.currentTarget.dataset.choice
    const questionId = this.element.dataset.questionId
    
    fetch(`/questions/${questionId}/comments?choice=${choice}`)
      .then(response => response.json())
      .then(data => {
        const commentsHtml = data.map(comment => `
          <div class="comment-item p-3 border-bottom">
            <p class="mb-1">${comment.content}</p>
            <small class="text-muted">by ${comment.user_name}</small>
          </div>
        `).join('')
        
        document.getElementById('comments-container').innerHTML = commentsHtml
      })
  }
}