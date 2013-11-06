((root) ->
  CodePal = root.CodePal = (root.CodePal || {})

  Lib = CodePal.Lib = {}

  Lib.sendAlert = (message, type) ->
    alertText = $('<p></p>')
    alertText.attr("type", type)
    alertText.html(message)
    alertText.css({opacity: 0})
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
