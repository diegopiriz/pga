
function readURL(input, preview) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();
    reader.onload = function (e) {
        preview.attr('src', e.target.result);
    }
    reader.readAsDataURL(input.files[0]);
  }
}

function ready_fn() {
  $(".picture_upload").change(function() {
      readURL(this, $(this).parent().parent().parent().find('img'));
      /* make another one visible*/
      $('.dog_picture_item .preview:hidden').first().show();
  });

  /* Hide extra add buttons */
  $('.dog_picture_item .preview').hide().first().show();
};


$(document).ready(ready_fn);
$(document).on('page:load', ready_fn);