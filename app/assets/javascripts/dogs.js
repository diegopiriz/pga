
function set_hidden_inputs(preview, data) {
  var parts = data.split(",");
  preview.parent().find("input[type=hidden][name*='data']").val(data);
};

function readData(evt) {
  var modal = $('#myModal');
  modal.modal({backdrop: 'static'});
  preview = $(this).parent().parent().find('img');
  

  evt.stopPropagation();
  evt.preventDefault();
  var file = evt.dataTransfer !== undefined ? evt.dataTransfer.files[0] : evt.target.files[0];
  var reader = new FileReader();
  reader.onload = (function(theFile) {
  return function(e) {
    var image = new Image();
    image.src = e.target.result;
    image.onload = function() {
    var canvas = document.createElement('canvas');
    canvas.width = 500;
    canvas.height = image.height * (500 / image.width);
    var ctx = canvas.getContext('2d');
    ctx.drawImage(image, 0, 0, canvas.width, canvas.height);

    $('#image_input').html(['<img src="', canvas.toDataURL(), '"/>'].join(''));

    var img = $('#image_input img')[0];
    var canvas = document.createElement('canvas');

    $('#image_input img').Jcrop({
      bgColor: 'black',
      bgOpacity: .6,
      setSelect: [0, 0, 100, 100],
      aspectRatio: 1,
      onSelect: imgSelect,
      onChange: imgSelect
    });

    function imgSelect(selection) {
      canvas.width = canvas.height = 500;

      var ctx = canvas.getContext('2d');
      ctx.drawImage(img, selection.x, selection.y, selection.w, selection.h, 0, 0, canvas.width, canvas.height);
    
      $('#image_output').attr('src', canvas.toDataURL());
      preview.attr('src', canvas.toDataURL());
      
      set_hidden_inputs(preview, canvas.toDataURL());
     }
    }
  }
  })(file);
  reader.readAsDataURL(file);
  $('.dog_picture_item .preview:hidden').first().show();
}

function ready_fn() {
  var inputFile = $(".picture_upload");
  //inputFile.click(function() {this.value = null;}, false);
  inputFile.change(readData);
  $('.dog_picture_item .preview:hidden').first().show();
};


$(document).ready(ready_fn);
$(document).on('page:load', ready_fn);