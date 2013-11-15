((root) ->
  CodePal = root.CodePal = (root.CodePal || {})

  Session = CodePal.Session = {}

  version = Session.version = 0

  editorFromString = (str) ->
    if str == "html"
      return CodePal.Editors.htmlBox
    else if str == "css"
      return CodePal.Editors.cssBox
    else if str == "js"
      return CodePal.Editors.jsBox

  stringFromEditor = (editor) ->
    if editor == CodePal.Editors.htmlBox
      return "html"
    else if editor == CodePal.Editors.cssBox
      return "css"
    else if editor == CodePal.Editors.jsBox
      return "js"

  setupSession = (socket) ->
    editors = [CodePal.Editors.htmlBox, CodePal.Editors.cssBox, CodePal.Editors.jsBox]

    socket.on(
      'editorUpdate'
      (data) ->
        console.log(data)
        
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

        # Session.version = data.version
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
          ###
          if !editor.setByAPI
            range = editor.getSelectionRange()
           
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
                editor: stringFromEditor(editor)              }
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
              editor: stringFromeEditor(editor)
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
          CodePal.Editors.jsBox.setValue(data.js, -1)
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
              js: CodePal.Editors.jsBox.getValue()
              version: Session.version
            }
          )
    )
)(this)
