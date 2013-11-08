((root) ->
  CodePal = root.CodePal = (root.CodePal || {})

  Session = CodePal.Session = {}

  setupSession = (socket) ->
    editors = [CodePal.Editors.htmlBox, CodePal.Editors.cssBox]

    socket.on(
      'editorUpdate'
      (data) ->
        
        editor = if data.editor == "html" then CodePal.Editors.htmlBox else CodePal.Editors.cssBox

        position = editor.getCursorPosition()

        editor.setByAPI = true
        editor.setValue(data.contents)
        editor.clearSelection()
        editor.setByAPI = false
        
        editor.moveCursorToPosition(position)
    )

    _(editors).each (editor) ->
      editor.on(
        'change'
        ->
          if !editor.setByAPI
            socket.emit(
              'editorUpdate'
              {
                contents: editor.getValue()
                editor: if editor == CodePal.Editors.htmlBox then "html" else "css"
              }
            )
      )

 

  start = Session.start = ->
    socket = io.connect('pp-code-pal.herokuapp.com:80')

    expectingValues = true

    socket.emit('requestEditorValues', {})

    socket.on(
      'editorValues'
      (data) ->
        console.log('got here')
        if data == 'no_data'
          expectingValues = false
          CodePal.Connection.getStoredValues ->
            setupSession(socket)
        else if expectingValues
          CodePal.Editors.htmlBox.setValue(data.html, -1)
          CodePal.Editors.cssBox.setValue(data.css, -1)
          CodePal.Editors.renderOutput()
          expectingValues = false
          setupSession(socket)
    )

    socket.on(
      'requestEditorValues'
      ->
        console.log(expectingValues)
        if !expectingValues
          socket.emit(
            'editorValues'
            {
              html: CodePal.Editors.htmlBox.getValue()
              css: CodePal.Editors.cssBox.getValue()
            }
          )
    )
)(this)
