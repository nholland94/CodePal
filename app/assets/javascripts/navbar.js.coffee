((root) ->
  CodePal = root.CodePal = (root.CodePal || {})

  Navbar = CodePal.Navbar = {}

  Navbar.addOption = (el) ->
    $el = $("<li></li>").html(el)
    $("nav ul.left").append($el)
)(this)
