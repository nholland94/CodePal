((root) ->
  CodePal = root.CodePal = (root.CodePal || {})

  Lib = CodePal.Lib = {}

  Lib.sendAlert = (message, type) ->
    alertText = $('<div></div>')
    alertText.attr("class", type)
    alertText.html(message)
    alertText.css({display: "none"})
    $('div.alerts').append(alertText)
    alertText.fadeIn(
      600
      ->
        setTimeout(
          ->
            alertText.fadeOut(
              600
              ->
                alertText.remove()
            )
          2000
        )
    )
)(this)
