document.addEventListener("DOMContentLoaded", function() {
    console.log(postIds.length)

    postIds.forEach(function(postId){
        const btn = document.getElementById("option-btn-" + postId.toString());
        const list = document.getElementById("option-list-" + postId.toString());
    
        btn.addEventListener("click", function() {
            if (list.style.display === "none") {
                list.style.display = "block";
                btn.style.color = "#f8934f"
                return;
            }
            
            btn.style.color = "#ffffff"
            list.style.display = "none";
        });
    
        list.addEventListener("click", function(e) {
        // Add button option listeners.
        });
    });
  });
