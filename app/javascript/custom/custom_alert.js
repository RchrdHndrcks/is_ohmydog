document.addEventListener("DOMContentLoaded", function() {
    var alertMessage = document.getElementById("alert-message");
    var closeAlertButton = document.getElementById("close-alert");
  
    if (alertMessage) {
      alertMessage.style.display = "block";
  
      closeAlertButton.addEventListener("click", function() {
        alertMessage.style.display = "none";
      });
    }
  });