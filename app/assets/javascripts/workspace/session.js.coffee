((root) ->
  CodePal = root.CodePal = (root.CodePal || {})

  Session = CodePal.Session = {}

  version = Session.version = 0

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

        Session.version = data.version
    )

    socket.on(
      'updateVersion'
      (newVersion) ->
        Session.version = newVersion
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
        (e) ->
          if !editor.setByAPI
            range = editor.getSelectionRange()

            ###
            if range.start.row < range.end.row && false # to not execute this code for now
              rows = editor.getValue().split("\n")

              if rows[range.start.row].length > range.start.column - 1
                if e.data.range.end.row == range.start.row
                  console.log('removeMultipleLines')
                  socket.emit(
                    'editorUpdate'
                    {
                      contents:
                        action: 'removeMultipleLines'
                        range: range
                        text: ""
                      editor: if editor == CodePal.Editors.htmlBox then "html" else "css"
                    }
                  )
              else
                if e.data.range.start.row == range.start.row
                  console.log('removeMultipleFlatLines')
                  socket.emit(
                    'editorUpdate'
                    contents:
                      action: 'removeMultipleFlatLines'
                      range: range
                      text: ""
                    editor: if editor == CodePal.Editors.htmlBox then "html" else "css"
                  )
            else
            ###
            console.log(e.data.action)
            socket.emit(
              'editorUpdate'
              {
                contents: e.data
                version: Session.version
                editor: if editor == CodePal.Editors.htmlBox then "html" else "css"
              }
            )
          ###
          # old method
          if !editor.setByAPI
            socket.emit(
              'editorUpdate'
              {
                contents: editor.getValue()
                editor: if editor == CodePal.Editors.htmlBox then "html" else "css"
              }
            )
          #
          ###
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
          Session.version = data.version
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
              version: Session.version
            }
          )
    )
)(this)
