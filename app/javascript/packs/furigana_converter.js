document.addEventListener('DOMContentLoaded', () => {
  const furiganaInput = document.getElementById('furigana-input');

  if (furiganaInput) { // 対象の入力フィールドが存在する場合のみ動作
    furiganaInput.addEventListener('input', (e) => {
      e.target.value = e.target.value.replace(/[\u3041-\u3096]/g, (s) => {
        return String.fromCharCode(s.charCodeAt(0) + 0x60);
      });
    });
  }
});