$(document).on('ready page:load', function () {
  var selectizeCallback = null;

  $(".category-modal").on("hide.bs.modal", function(e) {
    if (selectizeCallback != null) {
      selectizeCallback();
      selectizeCallback = null;
    }
  });

  $('.selectize').selectize({
    create: function(input, callback) {
      selectizeCallback = callback;
      $(".category-modal").modal();
      $("#new_tag").trigger("reset");
      $("#tag_name").val(input);

      $("#new_tag").on("submit", function(e) {
        e.preventDefault();
        $.ajax({
          method: "POST",
          url: $(this).attr("action"),
          data: $(this).serialize(),
          success: function(response) {
            selectizeCallback({value: response.id, text: response.name});
            selectizeCallback = null;
            $(".category-modal").modal('toggle');
            $.rails.enableFormElements($("#new_tag"));
          }
        })
      });
    }
  });

  $(function() {
    $("#categories_search input").keyup(function() {
      $.get($("#categories_search").attr("action"), $("#categories_search").serialize(), null, "script");
      $(".apple_pagination").hide();
      return false;
    });
  });
});