$(document).ready(function(){
  $(".l_url").click(function(){
    var id = $(this).attr('id');
    $.ajax({
          type: "GET",
          url: '/short_urls/ '+ id + '/update_clicks',
          dataType: "json",
          success: function(data) {
                // $("#"+id+"_total_clicks").html(data.clicks);
                window.location.reload(true);
          }
    });
  });
})
  
