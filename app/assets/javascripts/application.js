// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require bootstrap-sprockets
//= require autocomplete-rails
//= require jquery-ui
//= require ckeditor-jquery

$(document).ready(function() {
  setTimeout(function() {
    $('#notice_wrapper').fadeOut(function() {
      $(this).remove();
    })
  }, 4500);

  setTimeout(function() {
    $('.ckeditor').ckeditor({
    // optional config
    });
  }, 500);

  $("#recipe_has_ingredients").change(function() {
    console.log("changed");
    showRecipeParametersIfNeed();
  });

  var showRecipeParametersIfNeed = function() {
    var checked = $("#recipe_has_ingredients").is(":checked");
    showRecipeParameters(!checked);
  }

  var showRecipeParameters = function(show) {
    var params = $("#recipe_parameters");
    if (show) {
      params.show();
    } else {
      params.hide();
    }
  }

  showRecipeParametersIfNeed();

})

$(document).on('page:update', function(){
    console.log('page updated');
    if ($('.ckeditor')[0]) {
        CKEDITOR.replace($('.ckeditor').attr('id'));
    }
});