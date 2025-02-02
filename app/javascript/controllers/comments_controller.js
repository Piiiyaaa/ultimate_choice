import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal", "modalTitle", "commentsContainer"]
  static values = { questionId: String }

  connect() {
    if (this.hasModalTarget) {
      this.modal = new bootstrap.Modal(this.modalTarget)
    }
  }

  showComments(event) {
    event.preventDefault()
    
    // クリックされた要素を取得とラジオボタン選択
    const choiceBlock = event.currentTarget
    const radio = choiceBlock.querySelector('.choice-input')
    
    if (radio) {
      // 前の選択をクリア
      document.querySelectorAll('.choice-block').forEach(block => {
        block.classList.remove('selected')
      })
      
      // 新しい選択を反映
      radio.checked = true
      choiceBlock.classList.add('selected')
    }

    const choice = choiceBlock.dataset.commentsChoiceValue
    this.modalTitleTarget.textContent = `他の人の${choice}を選んだ理由`

    // コメント取得と表示
    fetch(`/questions/${this.questionIdValue}/comments?choice=${encodeURIComponent(choice)}`)
      .then(response => response.ok ? response.json() : Promise.reject('Network response was not ok'))
      .then(data => {
        this.commentsContainerTarget.innerHTML = this.formatComments(data)
        this.modal.show()
      })
      .catch(error => {
        console.error('Error:', error)
        this.commentsContainerTarget.innerHTML = 
          '<p class="text-danger">コメントの読み込みに失敗しました</p>'
      })
  }

  formatComments(comments) {
    return comments.length ? 
      comments.map(comment => `
        <div class="comment-item p-3 border-bottom">
          <p class="mb-1">${comment.content || '内容なし'}</p>
          <small class="text-muted">by ${comment.user_name}</small>
        </div>
      `).join('') : 
      '<p class="text-center text-muted p-3">まだコメントはありません</p>'
  }
}