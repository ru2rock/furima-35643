import consumer from "./consumer"

consumer.subscriptions.create("CommentChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) { //(data)の中に入っているのは下の記述の、data.content.textの内容で、contentはcomments_controllerのcontent: @comment
    const html = `<p>${data.user.nickname} ${data.content.text}</p>`;
    const comments = document.getElementById('comments');
    const newComment = document.getElementById('comment_text'); //

    comments.insertAdjacentHTML('afterbegin', html); //htmlで表示したい内容をどこに表示させるかの記述
    newComment.value=''; //15行目のnewCommentを表示した後にフォーム内を空にする
  }
});
