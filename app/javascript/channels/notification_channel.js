import consumer from "channels/consumer";

consumer.subscriptions.create("NotificationChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    this.addNotification(data);
    this.addBadgeToBell();
  },

  addNotification(content) {
    const ul = document.getElementById("notifications");
    // create divider
    let divider = document.createElement("div");
    divider.setAttribute("class", "dropdown-divider");

    // create li
    let li = document.createElement("li");
    li.append(document.createTextNode(content));
    li.setAttribute("class", "p-2");

    // prepend to ul
    if (ul.getElementsByTagName("li").length == 0) {
      ul.prepend(li);
    } else {
      ul.prepend(divider);
      ul.prepend(li);
    }
  },

  addBadgeToBell() {
    let container = document.getElementById("notification-icon-container");
    const span = document.createElement("span");
    span.id = "icon-badge";
    if (!container.querySelector("span")) container.append(span);
  },
});
