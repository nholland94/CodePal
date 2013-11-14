// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require pace
//= require jquery
//= require jquery_ujs
//= require jQueryRotate
//= require jquery.hotkeys
//= require underscore
//= require yummi-loader
//= require socket.io
//= require ace
//= require theme-monokai
//= require mode-html
//= require worker-css
//= require mode-javascript
//= require worker-javascript
//= require underscore
//= require backbone
//= require code_pal
//= require_tree ./workspace
//= require_tree .

$(window).load(function() {
  $('body').toggleClass('on off');
});
