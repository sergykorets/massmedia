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
});
// $(document).on('ready page:load', function () {
//   $("#post_tag_ids").chosen({
//     create_option_text: 'Create category',
//     create_option: function(term){
//       var chosen = this;
//       $.post('add_term.php', {term: term}, function(data){
//         chosen.append_option({
//           value: 'value-' + data.term,
//           text: data.term
//         });
//       });
//     }
//   });
// });

// $(document).on('ready page:load', function () {
//    $("#post_tag_ids").chosen({
//       create_option: function(term) {
//          this.append_option({
//             value: term,
//             text: term
//          });
//          $('#post_tag_ids').modal({});
//       },
//       persistent_create_option: true,
//       create_option_text: 'Create New Business'
//    });
// });