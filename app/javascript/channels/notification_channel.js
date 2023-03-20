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
    this.changeBell();
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

  changeBell() {
    let bell = document.getElementById("bell");
    let bullhorn = document.getElementById("bullhorn");
    bell.classList.add("d-none");
    bullhorn.classList.remove("d-none");
  },
});
