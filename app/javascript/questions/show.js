document.addEventListener('turbo:load', () => {
    const choiceBlocks = document.querySelectorAll('.choice-block');
    
    choiceBlocks.forEach(block => {
      block.addEventListener('click', () => {
        // ラジオボタンを選択
        const radio = block.querySelector('.choice-input');
        radio.checked = true;
        
        // 選択されていないブロックから選択状態を解除
        choiceBlocks.forEach(otherBlock => {
          otherBlock.classList.remove('selected');
        });
        
        // 選択されたブロックにクラスを追加してアニメーションをトリガー
        block.classList.add('selected');
      });
    });
  });
  