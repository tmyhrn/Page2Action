document.addEventListener("DOMContentLoaded", function() {
  // 下から上に文字が浮かび上がるアニメーションを適用
  const elementsToAnimate = document.querySelectorAll(".animate-float-up");
  elementsToAnimate.forEach(element => {
    element.style.opacity = 0;
    element.style.transform = "translateY(50px)";
  });

  // 下から上に画像が浮かび上がるアニメーションを適用
  const imageToAnimate = document.querySelector(".about-img");
  imageToAnimate.style.opacity = 0;
  imageToAnimate.style.transform = "translateY(50px)";

  // アニメーション終了後にクラスを削除する関数を定義
  function onAnimationEnd() {
    imageToAnimate.removeEventListener("animationend", onAnimationEnd);
    imageToAnimate.style.opacity = 1;
    imageToAnimate.style.transform = "translateY(0)";
  }

  // アニメーション終了イベントのリスナーを追加
  imageToAnimate.addEventListener("animationend", onAnimationEnd);

  setTimeout(() => {
    elementsToAnimate.forEach(element => {
      element.style.opacity = 1;
      element.style.transform = "translateY(0)";
    });
    imageToAnimate.classList.add("animate-float-up");
  }, 100);
});