((root) ->
  CodePal = root.CodePal = (root.CodePal || {})

  Editors = CodePal.Editors = (CodePal.Editors || {})

  OptionsMenu = Editors.OptionsMenu = {}

  optionsMenuAppear = (e) ->
    type = $(e.currentTarget.parentElement).data('type')
    menu = $('#' + type + '-container .editor-options')
    menu.toggle()
    image = $($(e.currentTarget).find('.gear')[0])

    angle = 0
    intervalId = setInterval(
      ->
        angle += 5
        image.rotate(angle)
      50
    )

    $(e.currentTarget).unbind('click')
    $(e.currentTarget).click (e) ->
      clearInterval(intervalId)
      image.rotate(0)
      
      menu.toggle()

      $(e.currentTarget).unbind('click')
      $(e.currentTarget).click(optionsMenuAppear)
  
  start = OptionsMenu.start = ->
    $(".editor-header button").click(optionsMenuAppear)

)(this)
