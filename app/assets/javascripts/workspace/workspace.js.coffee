((root) ->
  CodePal = root.CodePal = (root.CodePal || {})

  Workspace = CodePal.Workspace = {}

  noConnectionSetup = ->
    return null

  start = Workspace.start = (useConnection, useSession) ->
    CodePal.Editors.start()
    
    if useConnection
      CodePal.Connection.start(useSession)
    else
      noConnectionSetup()

    if useSession
      CodePal.Session.start()

)(this)
