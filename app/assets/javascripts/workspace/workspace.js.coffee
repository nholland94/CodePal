((root) ->
  CodePal = root.CodePal = (root.CodePal || {})

  Workspace = CodePal.Workspace = {}

  noConnectionSetup = ->
    return null

  start = Workspace.start = (useConnection) ->
    CodePal.Editors.start()
    
    if useConnection
      CodePal.Connection.start()
    else
      noConnectionSetup()

)(this)
