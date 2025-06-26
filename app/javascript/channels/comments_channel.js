// app/javascript/channels/comments_channel.js
import consumer from "./consumer"

document.addEventListener('turbo:load', () => {
  // Find the element that holds the article ID
  const commentsElement = document.getElementById('comments');

  if (commentsElement) {
    const articleId = commentsElement.dataset.articleId;

    consumer.subscriptions.create({ channel: "CommentsChannel", article_id: articleId }, {
      connected() {
        // Called when the subscription is ready for use on the server
        console.log(`Connected to comments channel for article ${articleId}`);
      },

      disconnected() {
        // Called when the subscription has been terminated by the server
        console.log(`Disconnected from comments channel for article ${articleId}`);
      },

      received(data) {
        // Called when there's incoming data on the websocket for this channel
        // This is where we'll handle the Turbo Stream content
        console.log("Received data:", data);
        Turbo.renderStreamMessage(data); // Render the received Turbo Stream
      }
    });
  }
});