(function(root) {
  var CodePal = root.CodePal = (root.CodePal || {});

  var Navbar = CodePal.Navbar = {};

  Navbar.addOption = function(el) {
    var $el = $("<li></li>").html(el);
    $("nav ul.left").append($el);
  };
})(this);
