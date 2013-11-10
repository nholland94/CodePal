((root) ->
  CodePal = root.CodePal = (root.CodePal || {})

  Session = CodePal.Session = {}

  editorFromString = (str) ->
    return if str == "html" then CodePal.Editors.htmlBox else CodePal.Editors.cssBox



  setupSession = (socket) ->
    editors = [CodePal.Editors.htmlBox, CodePal.Editors.cssBox]

    socket.on(
      'editorUpdate'
      (data) ->
        
        editor = editorFromString(data.editor)

        position = editor.getCursorPosition()

        editor.setByAPI = true
        currentData = editor.getValue()
        # newData = data.contents
        # mergedData = mergeContents(currentData, newData)
        # editor.setValue(mergedData)
        editor.setValue(data.contents)
        editor.clearSelection()
        editor.setByAPI = false
        
        editor.moveCursorToPosition(position)
    )

    socket.on(
      'removeControl'
      (data) ->
        editorFromString(data.editor).setReadonly(true)
    )

    socket.on(
      'giveControl'
      (data) ->
        editorFromString(data.editor).setReadonly(false)
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

      editor.$el.bind(
        'keypress'
        'Ctrl+space'
        (e) ->
          console.log("cool, I got to the keypress event")
          e.preventDefault()
          socket.emit(
            'takeControl'
            {
              editor: if editor == CodePal.Edtiors.htmlBox then "html" else "css"
            }
          )
          return false
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
